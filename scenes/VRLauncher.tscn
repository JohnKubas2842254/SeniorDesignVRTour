[gd_scene load_steps=3 format=3]

[ext_resource type="Script" path="res://vr_launcher.gd" id="1_l5jd3"]
[ext_resource type="Texture2D" uid="uid://bemx8dl3tnfsh" path="res://cleveland-state-university.png" id="2_smb8y"]

[node name="VRLauncher" type="Node"]
script = ExtResource("1_l5jd3")

[node name="Control" type="Control" parent="."]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2

[node name="TextureRect" type="TextureRect" parent="Control"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
texture = ExtResource("2_smb8y")
expand_mode = 1
stretch_mode = 6

[node name="ColorRect" type="ColorRect" parent="Control"]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
color = Color(0, 0, 0, 0.501961)

[node name="Label" type="Label" parent="Control"]
layout_mode = 1
anchors_preset = 8
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -143.0
offset_top = -13.0
offset_right = 143.0
offset_bottom = 13.0
grow_horizontal = 2
grow_vertical = 2
theme_override_colors/font_shadow_color = Color(0, 0, 0, 1)
theme_override_constants/shadow_offset_x = 2
theme_override_constants/shadow_offset_y = 2
theme_override_font_sizes/font_size = 32
text = "Loading... Detecting VR hardware..."