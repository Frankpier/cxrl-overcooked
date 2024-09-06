from cx_reinforcement_learning.cxrl_gym import CXRLGym


class OvercookedEnv(CXRLGym):
    def __init__(self):
        number_of_robots = 1
        step_wait_time = 5
        reset_wait_time = 5
        super().__init__(number_of_robots, step_wait_time, reset_wait_time)

    def step(self, action):
        return super().step(action)
    
    def reset(self, seed: int = None, options: dict[str, any] = None):
        return super().reset(seed=seed)
    
    def generate_action_space(self):
        self.get_logger().info("Generating action space...")
        action_space =  ["MOVE-PLATE-FROM-SINK-TO-COUNTER#order#1",
                         "MOVE-PLATE-FROM-SINK-TO-COUNTER#order#2",
                         "MOVE-PLATE-FROM-SINK-TO-COUNTER#order#3",
                         "PUT-COOKED-BEEF-ON-PLATE#order#1",
                         "PUT-COOKED-BEEF-ON-PLATE#order#2",
                         "PUT-COOKED-BEEF-ON-PLATE#order#3",
                         "PUT-BUN-ON-PLATE#order#1",
                         "PUT-BUN-ON-PLATE#order#2",
                         "PUT-BUN-ON-PLATE#order#3",
                         "PUT-CHEESE-ON-PLATE#order#1",
                         "PUT-CHEESE-ON-PLATE#order#2",
                         "PUT-CHEESE-ON-PLATE#order#3",
                         "PUT-CHOPPED-LETTUCE-ON-PLATE#order#1",
                         "PUT-CHOPPED-LETTUCE-ON-PLATE#order#2",
                         "PUT-CHOPPED-LETTUCE-ON-PLATE#order#3",
                         "PUT-CHOPPED-TOMATO-ON-PLATE#order#1",
                         "PUT-CHOPPED-TOMATO-ON-PLATE#order#2",
                         "PUT-CHOPPED-TOMATO-ON-PLATE#order#3",
                         "DELIVER-PLATE#order#1",
                         "DELIVER-PLATE#order#2",
                         "DELIVER-PLATE#order#3"
                        ]       
        return action_space

    def render(self):
        pass

    