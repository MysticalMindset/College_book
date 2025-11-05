classdef mean_init
    methods(Static)
        function MaskInitialization(maskInitContext)
            % Access mask workspace
            maskWS = maskInitContext.MaskWorkspace;

            % --- Get user-entered parameters safely ---
            try
                f = maskWS.get('f');
            catch
                error('Parameter "f" (Fundamental frequency) not found in mask workspace.');
            end

            % Optional parameter: Ncycles
            try
                Ncycles = maskWS.get('Ncycles');
            catch
                % Default to averaging one cycle if not present
                Ncycles = 1;
            end

            % Optional parameter: InitialValue
            try
                InitialValue = maskWS.get('InitialValue');
            catch
                InitialValue = 0;
            end

            % --- Compute period for averaging ---
            if f <= 0
                error('Fundamental frequency "f" must be positive.');
            end
            T = Ncycles / f;

            % --- Write values back to mask workspace ---
            maskWS.set('T', T);
            maskWS.set('ComputedT', T); % for diagnostics or display if needed
            maskWS.set('InitialValue', InitialValue);
        end
    end
end
