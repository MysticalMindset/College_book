import launch
from launch.substitutions import Command, LaunchConfiguration
import launch_ros
import os

# define the package name
packageName='demo_robot'

#urdf relative file path with respect to the package path
urdfRelativePath='urdf/model.urdf'

#RViz config file path with repsect to the package path
rvizRelativePath='config/config.rviz'

def generate_launch_description():
    # absolute model path
    pkgPath = launch_ros.substitutions.FindPackageShare(package=packageName).find(packageName)
    # absolute urdf model path
    urdfModelPath= os.path.join(pkgPath,urdfRelativePath)
    # absolute rviz config file path
    rvizConfigPath= os.path.join(pkgPath,rvizRelativePath)
    
    # here, for verification, print the URDF model path
    print(urdfModelPath)

    # load the robot description
    with open(urdfModelPath,'r') as infp:
    	robot_desc = infp.read()
    
    # define a parameter with the robot URDF description
    params = {'robot_description': robot_desc}
    
    # robot state publisher node
    robot_state_publisher_node =launch_ros.actions.Node(
    package='robot_state_publisher',
	executable='robot_state_publisher',
    output='screen',
    parameters=[params],
    arguments=[urdfModelPath])


# joint state publisher node
#    joint_state_publisher_node = launch_ros.actions.Node(
#        package='joint_state_publisher',
#        executable='joint_state_publisher',
#        name='joint_state_publisher',
#        parameters=[params],
#		arguments=[urdfModelPath]
#    )
 
    # joint state publisher node GUI
    joint_state_publisher_gui_node = launch_ros.actions.Node(
        package='joint_state_publisher_gui',
        executable='joint_state_publisher_gui',
        name='joint_state_publisher_gui',
        arguments=[urdfModelPath],
        condition=launch.conditions.IfCondition(LaunchConfiguration('gui'))
    )
    
    # rviz node
    rviz_node = launch_ros.actions.Node(
        package='rviz2',
        executable='rviz2',
        name='rviz2',
        output='screen',
        arguments=['-d', rvizConfigPath]
    )

    # finally, combine everything and return
    return launch.LaunchDescription([
        launch.actions.DeclareLaunchArgument(name='gui', default_value='True',
                                            description='This is a flag for joint_state_publisher_gui'),
        robot_state_publisher_node,
 #       joint_state_publisher_node,
        joint_state_publisher_gui_node,
        rviz_node
    ]) 
    