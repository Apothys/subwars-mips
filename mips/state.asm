# state.asm
# Submarine state and knowledge

.data
# Submarine state structure (52 bytes)
# 0:    (4) int size = 52
# 4:    (4) int player
# 8:    (8) vector position
# 16:   (8) vector rotation
# 24:   (4) flag move
# 28:   (4) flag turn
# 32:   (4) flag ping
# 36:   (4) flag fire
# 40:   (4) flag bounds
# 44:   (4) flag collide
# 48:   (4) flag alive

submarine_1_prototype:
    .word   52, 1, 0,0, 1,0, 0, 0, 0, 0, 0, 0, 1

submarine_2_prototype:
    .word   52, 2, 7,7, -1,0, 0, 0, 0, 0, 0, 0, 1

.text

create_subs_function:
    # //this assumes that subs are created in main and passed here to get initialized
    # void create_subs(submarine* A, submarine* B) {
    #     vector botLeft = {MAP_LEFT, MAP_BOTTOM};
    #     vector topRight = {MAP_RIGHT, MAP_TOP};
    #     vector right = {1, 0};
    #     vector left = {-1, 0};
    #     A->player = 1;
    #     B->player = 2;
    #     A->position = botLeft;
    #     A->rotation = right;
    #     B->position = topRight;
    #     B->rotation = left;
    # 
    #     reset_flags(A);
    #     reset_flags(B);
    # 
    #     A->alive = B->alive = true;
    # }
    jr $ra

reset_flags_function:
    # void reset_flags(submarine* sub) {
    #     sub->move = false;
    #     sub->turn = false;
    #     sub->ping = false;
    #     sub->fire = false;
    #     sub->bounds = false;
    # }
    jr $ra

sub_move_function:
    # void sub_move(submarine* sub, bool dir) {
    #     // Determine direction
    #     vector resultant = {0, 0};
    #     if (dir) {
    # 	resultant = add(sub->position, sub->rotation);
    #     } else {
    #         resultant = subtract(sub->position, sub->rotation);
    #     }
    # 
    #     // Check boundaries
    #     if (resultant.x >= MAP_LEFT &&
    #         resultant.x <= MAP_RIGHT &&
    #         resultant.y >= MAP_BOTTOM &&
    #         resultant.y <= MAP_TOP)
    #     {
    #         // Move if sub would stay in-bounds
    #         sub->move = true;
    #         sub->position = resultant;
    #     } else {
    #         // Notify otherwise, but do not move
    #         sub->bounds = true;
    #     }
    # }
    jr $ra

check_collision_function:
    # void check_collision(submarine* A, submarine* B)
    # {
    #     if (equals(A->position, B->position)) {
    #         // A and B occupy the same point in space
    #         A->collide = B->collide = true;
    #     } else if (A->move && B->move) {
    #         // check to see if they may have passed through each other (if they have both moved and are facing away from each other)
    # 
    #         // subtract B from A
    #         vector displacement = subtract(A->position, B->position);
    # 
    #         if (equals(A->rotation, displacement) && equals(B->rotation, mult(displacement, -1)))
    #         {
    #             // A and B passed through each other this turn
    #             A->collide = B->collide = true;
    #         }
    #     }
    # 
    #     // Any collision results in death of both parties
    #     if (A->collide || B->collide) A->alive = B->alive = false;
    # }
    jr $ra

sub_fire_function:
    # void sub_fire(submarine* sub, submarine* target){
    #     sub->fire = true;
    #     if (collide(sub->position, sub->rotation, target->position)) {
    #         target->alive = false;
    #     }
    # }
    jr $ra

sub_rotate_left_function:
    # void sub_rotate_left(submarine* sub) {
    #     sub->turn = true;
    #     sub->rotation = left(sub->rotation);
    # }
    jr $ra

sub_rotate_right_function:
    # void sub_rotate_right(submarine* sub) {
    #     sub->turn = true;
    #     sub->rotation = right(sub->rotation);
    # }
    jr $ra

sub_ping_function:
    # void sub_ping(submarine* sub) {
    #     sub->ping = true;
    # }
    jr $ra

evaluate_motion_function:
    # void evaluate_motion(submarine* sub, int command)
    # {
    #     switch (command)
    #     {
    #         case 0:
    #             sub_move(sub, true);
    #             break;
    #         case 1:
    #             sub_move(sub, false);
    #             break;
    #         case 2:
    #             sub_rotate_left(sub);
    #             break;
    #         case 3:
    #             sub_rotate_right(sub);
    #             break;
    #     }
    # }
    jr $ra

evaluate_action_function:
    # void evaluate_action(submarine* sub, submarine* enemy, int command)
    # {
    #     switch (command)
    #     {
    #         case 4:
    #             sub_ping(sub);
    #             break;
    #         case 5:
    #             sub_fire(sub, enemy);
    #             break;
    #     }
    # }
    jr $ra