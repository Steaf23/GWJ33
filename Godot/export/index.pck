GDPC                                                                                D   res://.import/Bag_Potion.png-aa8cca30d5f685058b7551f651e4154b.stex  `      ]      *�{����_�9%�<   res://.import/Tile.png-234d274035d91a842071fd1b6df51f5f.stex *      �       ���9MVd<{3(��<   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stexp/      U      �woM����aT����u$   res://Bag.gd.remap  `?             P��p� Z-��=W\   res://Bag.gdc          �      ��OO+ �Mpȹ+0,   res://Bag.tscn  �	      V      �x9WË0�M���"�I   res://BagItem.gd.remap  �?      "       ����-S����U�   res://BagItem.gdc   0      U      �T<����2p��b�l�   res://BagItem.tscn  �      �      ̰}�ʎ�$�k^�E�   res://Bag_Potion.png.import �      �      ����:-��9�� ��b   res://GroundItem.gd.remap   �?      %       ��%������Vn�7�   res://GroundItem.gdc`"      Y      2�Ck!�����i��   res://GroundItem.tscn   �%      X      ��0�U��o_6��)   res://Tile.png.import   �*      �      �d'2��("�8d���   res://World.tscn�-      ?      �3�ѻԿ2�Ԓx�D�   res://default_env.tres  �.      �       um�`�N��<*ỳ�8   res://icon.png  �?      �      G1?��z�c��vN��   res://icon.png.import   �<      �      �`�8�D�Ւ�(�1��   res://project.binary�L      �      +��G2�Ԩ�)tjc�            GDSC         !   �      ������ƶ   ��������󶶶   ��������Ŷ��   ��������۶��   �������Ŷ���   ����׶��   �����¶�   ����¶��   ��������������������ض��   �������ض���   ������������������������ض��   �����������¶���   ������Ҷ   ��������������������ض��   �����������ζ���   ���������Ҷ�   ��������ƶ��   ���ƶ���   ���������������Ŷ���   �����������������������ض���   ���۶���   ���Ӷ���                                 Z         picked up %s                         	                           	      
                '      -      3      K      Q      Y      Z      c      i      o      u      �      �      �      �      �      �      �      �      �       �   !   3YY:�  YY;�  Y;�  YY0�  P�  QV�  &�  �  V�  -�  Y0�  P�  QV�  &�  4�  V�  &�  �  V�  �  T�	  P�
  PQ�  T�  QT�  P�  P�  R�  QQ�  &�  4�  V�  &�  T�  �  V�  �  &�  T�  PQV�  &�  �  V�  �  T�  �  �  �  T�  PQ�  �  T�	  �  T�	  T�  P�  P�  R�  QQ�  �  �  �  '�  T�  �  V�  &�  T�  PQV�  &�  �  V�  �  T�  �  �  Y0�  P�  QV�  �?  P�  L�  T�  MQ�  �  �  Y`     [gd_scene load_steps=5 format=2]

[ext_resource path="res://Tile.png" type="Texture" id=1]
[ext_resource path="res://BagItem.tscn" type="PackedScene" id=2]
[ext_resource path="res://Bag.gd" type="Script" id=3]

[sub_resource type="TileSet" id=1]
0/name = "Tile.png 0"
0/texture = ExtResource( 1 )
0/tex_offset = Vector2( 0, 0 )
0/modulate = Color( 1, 1, 1, 1 )
0/region = Rect2( 0, 0, 32, 32 )
0/tile_mode = 0
0/occluder_offset = Vector2( 0, 0 )
0/navigation_offset = Vector2( 0, 0 )
0/shape_offset = Vector2( 0, 0 )
0/shape_transform = Transform2D( 1, 0, 0, 1, 0, 0 )
0/shape_one_way = false
0/shape_one_way_margin = 0.0
0/shapes = [  ]
0/z_index = 0

[node name="Bag" type="TileMap"]
tile_set = SubResource( 1 )
cell_size = Vector2( 32, 32 )
format = 1
tile_data = PoolIntArray( 0, 0, 0, 1, 0, 0, 2, 0, 0, 3, 0, 0, 4, 0, 0, 5, 0, 0, 6, 0, 0, 7, 0, 0, 8, 0, 0, 9, 0, 0, 10, 0, 0, 11, 0, 0, 12, 0, 0, 13, 0, 0, 14, 0, 0, 65536, 0, 0, 65537, 0, 0, 65538, 0, 0, 65539, 0, 0, 65540, 0, 0, 65541, 0, 0, 65542, 0, 0, 65543, 0, 0, 65544, 0, 0, 65545, 0, 0, 65546, 0, 0, 65547, 0, 0, 65548, 0, 0, 65549, 0, 0, 65550, 0, 0, 131072, 0, 0, 131073, 0, 0, 131074, 0, 0, 131075, 0, 0, 131076, 0, 0, 131077, 0, 0, 131078, 0, 0, 131079, 0, 0, 131080, 0, 0, 131081, 0, 0, 131082, 0, 0, 131083, 0, 0, 131084, 0, 0, 131085, 0, 0, 131086, 0, 0, 196608, 0, 0, 196609, 0, 0, 196610, 0, 0, 196611, 0, 0, 196612, 0, 0, 196613, 0, 0, 196614, 0, 0, 196615, 0, 0, 196616, 0, 0, 196617, 0, 0, 196618, 0, 0, 196619, 0, 0, 196620, 0, 0, 196621, 0, 0, 196622, 0, 0, 262144, 0, 0, 262145, 0, 0, 262146, 0, 0, 262147, 0, 0, 262148, 0, 0, 262149, 0, 0, 262150, 0, 0, 262151, 0, 0, 262152, 0, 0, 262153, 0, 0, 262154, 0, 0, 262155, 0, 0, 262156, 0, 0, 262157, 0, 0, 262158, 0, 0, 327680, 0, 0, 327681, 0, 0, 327682, 0, 0, 327683, 0, 0, 327684, 0, 0, 327685, 0, 0, 327686, 0, 0, 327687, 0, 0, 327688, 0, 0, 327689, 0, 0, 327690, 0, 0, 327691, 0, 0, 327692, 0, 0, 327693, 0, 0, 327694, 0, 0, 393216, 0, 0, 393217, 0, 0, 393218, 0, 0, 393219, 0, 0, 393220, 0, 0, 393221, 0, 0, 393222, 0, 0, 393223, 0, 0, 393224, 0, 0, 393225, 0, 0, 393226, 0, 0, 393227, 0, 0, 393228, 0, 0, 393229, 0, 0, 393230, 0, 0, 458752, 0, 0, 458753, 0, 0, 458754, 0, 0, 458755, 0, 0, 458756, 0, 0, 458757, 0, 0, 458758, 0, 0, 458759, 0, 0, 458760, 0, 0, 458761, 0, 0, 458762, 0, 0, 458763, 0, 0, 458764, 0, 0, 458765, 0, 0, 458766, 0, 0, 524288, 0, 0, 524289, 0, 0, 524290, 0, 0, 524291, 0, 0, 524292, 0, 0, 524293, 0, 0, 524294, 0, 0, 524295, 0, 0, 524296, 0, 0, 524297, 0, 0, 524298, 0, 0, 524299, 0, 0, 524300, 0, 0, 524301, 0, 0, 524302, 0, 0, 589824, 0, 0, 589825, 0, 0, 589826, 0, 0, 589827, 0, 0, 589828, 0, 0, 589829, 0, 0, 589830, 0, 0, 589831, 0, 0, 589832, 0, 0, 589833, 0, 0, 589834, 0, 0, 589835, 0, 0, 589836, 0, 0, 589837, 0, 0, 589838, 0, 0 )
script = ExtResource( 3 )

[node name="Border" type="Area2D" parent="."]

[node name="CollisionPolygon2D" type="CollisionPolygon2D" parent="Border"]
polygon = PoolVector2Array( 320, 64, 320, 320, 480, 320, 480, 0, 0, 0, 0, 320, 320, 320, 320, 224, 160, 224, 160, 64 )

[node name="ItemBlock" parent="." instance=ExtResource( 2 )]
position = Vector2( 224, 128 )
          GDSC            �      ���ׄ�   ��������ƶ��   �����������¶���   ��������   ������Ŷ   ���������ض�   ���۶���   �����϶�   ������¶   ���������¶�   ���������ƶ�   ����������Ҷ   ��������������¶   �������¶���   ����¶��   ��������ζ��   ��������������������ض��   �����������ζ���   ���������Ҷ�   �����������������������ض���   �������ض���   ����������ڶ   ���ƶ���   ��������������������Ŷ��   ���Ӷ���   
   clicked_on        _on_ItemBlock_clicked_on                                dropped!                                                    	      
   )      *      0      4      5      ;      ?      @      K      Q      Y      a      g      k      o      v      w      }      �      �      �      3YY;�  Y;�  �  T�  Y;�  YYB�  P�  QYY0�  PQV�  �  PR�	  PQR�  QYY0�
  PQV�  �  �  �  Y0�  PQV�  �  �  YY0�  P�  R�  R�  QV�  &�  4�  V�  &�  T�  �  V�  &�  T�  PQV�  �  �  PQ�  �  �  �  �  �  �  �  PRQYY0�  PQV�  &T�  PQT�  PQ�  V�  �  �  �  �?  P�  QY`           [gd_scene load_steps=2 format=2]

[ext_resource path="res://BagItem.gd" type="Script" id=1]

[node name="ItemBlock" type="Area2D"]
script = ExtResource( 1 )

[node name="Sprite" type="Sprite" parent="."]
centered = false

[node name="Collision" type="CollisionPolygon2D" parent="."]
position = Vector2( 16, 16 )
polygon = PoolVector2Array( -15, -15, 15, -15, 15, 15, -15, 15 )

[connection signal="input_event" from="." to="." method="_on_input_event"]
           GDST                 A  PNG �PNG

   IHDR           szz�   sRGB ���  �IDATX�ŗ�O�P�?�&I�� \ �Q4��1z�#��d�E���+<y��H��1�p1����� �ؒ�D��e�l����]����/i��^���~�{}�eyQ�?F  �d��N�|����@SM9!8#��E��$�MaLKeU�v; ��q'kh�KI���	�[�����kpp�?z�"Z��UK��O��TW��g x����!���\n:���.p�P���O��X�Y�z&�,�ު[;n(Z82I�6L�6L82�qCѸ�$N5�	�I��,�R��)W��,�Ƽ�p�����E���o\�+3�߽b7Ndh���#�ro����Z|ɕ��B.7Y�/݌�S���W�Y��-)$�i+��BU���HW`1j�W�"Q/6�HB���6���g��$��;0��"bT�p#���%��m	���h	�{�iE'!�DWJ8*P��S����~ x�R�^���DZ�����������:�}hm?�����.鉀����q<�V��l�Z�'���:`�C��a�@�a����S8��bzΨ����"n��ca$�@5��}�i�~��_:�p,�z��o���P
��Z����]��N��x��/w����j�� �Q�B*�A%�VI`|"�w��6�[%��JLoogH/?$>�liH+^��}�ZE���:���l��pc���ʦ0f�h�8}[7s�RM���d�TS���-�p9�&���$vuN�����A��Fd�7��&    IEND�B`�   [remap]

importer="texture"
type="StreamTexture"
path="res://.import/Bag_Potion.png-aa8cca30d5f685058b7551f651e4154b.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://Bag_Potion.png"
dest_files=[ "res://.import/Bag_Potion.png-aa8cca30d5f685058b7551f651e4154b.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=false
svg/scale=1.0
            GDSC            r      ���ׄ�   �����������Ҷ���   ���۶���   �Ҷ�   ���������Ķ�   �����Ӷ�   �����Ӷ�   ��������������¶   �������¶���   ����¶��   ��������ζ��   ������Ҷ   ��������������������ض��   �����������ζ���   ���������Ҷ�   ����������ڶ   ��������������������ض��   �����������ڶ���   ���������������۶���      generic_item                   item_clicked      HOVER         enabled                          	      
                           	      
   (      +      1      9      A      H      N      S      `      c      p      3YYB�  P�  QYY;�  Y;�  �  YY5;�  W�  YY0�  P�  R�	  R�
  QV�  ;�  �  &�	  4�  V�  &�	  T�  �  V�  &�	  T�  PQV�  �  P�  RQ�  '�	  4�  V�  �?  P�  Q�  �  T�  PQT�  P�  R�  Q�  (V�  �  T�  PQT�  P�  R�  QY`       [gd_scene load_steps=6 format=2]

[ext_resource path="res://GroundItem.gd" type="Script" id=1]
[ext_resource path="res://Bag_Potion.png" type="Texture" id=2]

[sub_resource type="RectangleShape2D" id=1]
extents = Vector2( 16, 16 )

[sub_resource type="Shader" id=2]
code = "shader_type canvas_item;

uniform bool enabled;

void fragment()
{
	vec4 sprite_color = texture(TEXTURE, UV);
	float alpha = -4.0 * sprite_color.a;
	alpha += texture(TEXTURE, UV + vec2(1.0, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(-1.0, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, 1.0)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, -1.0)).a;
	
	COLOR = vec4(1.0, 1.0, 1.0, alpha);
}"

[sub_resource type="ShaderMaterial" id=3]
shader = SubResource( 2 )
shader_param/enabled = true

[node name="GroundItem" type="Area2D"]
script = ExtResource( 1 )

[node name="Collision" type="CollisionShape2D" parent="."]
visible = false
shape = SubResource( 1 )

[node name="Sprite" type="Sprite" parent="."]
material = SubResource( 3 )
texture = ExtResource( 2 )

[connection signal="input_event" from="." to="." method="_on_input_event"]
        GDST                 �   PNG �PNG

   IHDR           szz�   sRGB ���   eIDATX�c4��cH������,�:[�������Ζb�Q���8��U-�<F0�Q�:`��u��F��MH�Ӏ�������tPa�w� ���#�@�    IEND�B`�     [remap]

importer="texture"
type="StreamTexture"
path="res://.import/Tile.png-234d274035d91a842071fd1b6df51f5f.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://Tile.png"
dest_files=[ "res://.import/Tile.png-234d274035d91a842071fd1b6df51f5f.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=false
svg/scale=1.0
              [gd_scene load_steps=2 format=2]

[ext_resource path="res://GroundItem.tscn" type="PackedScene" id=1]

[node name="World" type="Node2D"]

[node name="Map" type="TileMap" parent="."]
cell_size = Vector2( 32, 32 )
format = 1

[node name="GroundItem" parent="Map" instance=ExtResource( 1 )]
position = Vector2( 201, 154 )
 [gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

[resource]
background_mode = 2
background_sky = SubResource( 1 )
             GDST@   @            9  PNG �PNG

   IHDR   @   @   �iq�   sRGB ���  �IDATx�ݜytTU��?��WK*�=���%�  F����0N��݂:���Q�v��{�[�����E�ӋH���:���B�� YHB*d_*�jyo�(*M�JR!h��S�T��w�߻���ro���� N�\���D�*]��c����z��D�R�[�
5Jg��9E�|JxF׵'�a���Q���BH�~���!����w�A�b
C1�dB�.-�#��ihn�����u��B��1YSB<%�������dA�����C�$+(�����]�BR���Qsu][`
�DV����у�1�G���j�G͕IY! L1�]��� +FS�IY!IP ��|�}��*A��H��R�tQq����D`TW���p\3���M���,�fQ����d��h�m7r�U��f������.��ik�>O�;��xm��'j�u�(o}�����Q�S�-��cBc��d��rI�Ϛ�$I|]�ơ�vJkZ�9>��f����@EuC�~�2�ym�ش��U�\�KAZ4��b�4������;�X婐����@Hg@���o��W�b�x�)����3]j_��V;K����7�u����;o�������;=|��Ŗ}5��0q�$�!?��9�|�5tv�C�sHPTX@t����w�nw��۝�8�=s�p��I}�DZ-̝�ǆ�'�;=����R�PR�ۥu���u��ǻC�sH`��>�p�P ���O3R�������۝�SZ7 �p��o�P!�
��� �l��ހmT�Ƴێ�gA��gm�j����iG���B� ܦ(��cX�}4ۻB��ao��"����� ����G�7���H���æ;,NW?��[��`�r~��w�kl�d4�������YT7�P��5lF�BEc��=<�����?�:]�������G�Μ�{������n�v��%���7�eoݪ��
�QX¬)�JKb����W�[�G ��P$��k�Y:;�����{���a��&�eפ�����O�5,;����yx�b>=fc�* �z��{�fr��7��p���Ôִ�P����t^�]͑�~zs.�3����4��<IG�w�e��e��ih�/ˆ�9�H��f�?����O��.O��;!��]���x�-$E�a1ɜ�u�+7Ȃ�w�md��5���C.��\��X��1?�Nغ/�� ��~��<:k?8��X���!���[���꩓��g��:��E����>��꩓�u��A���	iI4���^v:�^l/;MC��	iI��TM-$�X�;iLH���;iI1�Zm7����P~��G�&g�|BfqV#�M������%��TM��mB�/�)����f����~3m`��������m�Ȉ�Ƽq!cr�pc�8fd���Mۨkl�}P�Л�汻��3p�̤H�>+���1D��i�aۡz�
������Z�Lz|8��.ִQ��v@�1%&���͏�������m���KH�� �p8H�4�9����/*)�aa��g�r�w��F36���(���7�fw����P��&�c����{﹏E7-f�M�).���9��$F�f r �9'1��s2).��G��{���?,�
�G��p�µ�QU�UO�����>��/�g���,�M��5�ʖ�e˃�d����/�M`�=�y=�����f�ӫQU�k'��E�F�+ =΂���
l�&���%%�������F#KY����O7>��;w���l6***B�g)�#W�/�k2�������TJ�'����=!Q@mKYYYdg��$Ib��E�j6�U�,Z�鼌Uvv6YYYԶ��}( ���ߠ#x~�s,X0�����rY��yz�	|r�6l����cN��5ϑ��KBB���5ϡ#xq�7�`=4A�o�xds)�~wO�z�^��m���n�Ds�������e|�0�u��k�ٱ:��RN��w�/!�^�<�ͣ�K1d�F����:�������ˣ����%U�Ą������l{�y����)<�G�y�`}�t��y!��O@� A� Y��sv:K�J��ՎۣQ�܃��T6y�ǯ�Zi
��<�F��1>�	c#�Ǉ��i�L��D�� �u�awe1�e&')�_�Ǝ^V�i߀4�$G�:��r��>h�hݝ������t;)�� &�@zl�Ұր��V6�T�+����0q��L���[t���N&e��Z��ˆ/����(�i啝'i�R�����?:
P].L��S��E�݅�Á�.a6�WjY$F�9P�«����V^7���1Ȓ� �b6�(����0"�k�;�@MC���N�]7 �)Q|s����QfdI���5 ��.f��#1���G���z���>)�N�>�L0T�ۘ5}��Y[�W뿼mj���n���S?�v��ْ|.FE"=�ߑ��q����������p����3�¬8�T�GZ���4ݪ�0�L�Y��jRH��.X�&�v����#�t��7y_#�[�o��V�O����^�����paV�&J�V+V��QY����f+m��(�?/������{�X��:�!:5�G�x���I����HG�%�/�LZ\8/����yLf�Æ>�X�Єǣq���$E������E�Ǣ�����gێ��s�rxO��x孏Q]n���LH����98�i�0==���O$5��o^����>6�a� �*�)?^Ca��yv&���%�5>�n�bŜL:��y�w���/��o�褨A���y,[|=1�VZ�U>,?͑���w��u5d�#�K�b�D�&�:�����l~�S\���[CrTV�$����y��;#�������6�y��3ݸ5��.�V��K���{�,-ւ� k1aB���x���	LL� ����ңl۱������!U��0L�ϴ��O\t$Yi�D�Dm��]|�m���M�3���bT�
�N_����~uiIc��M�DZI���Wgkn����C��!xSv�Pt�F��kڨ��������OKh��L����Z&ip��
ޅ���U�C�[�6��p���;uW8<n'n��nͽQ�
�gԞ�+Z	���{���G�Ĭ� �t�]�p;躆 ��.�ۣ�������^��n�ut�L �W��+ ���hO��^�w�\i� ��:9>3�=��So�2v���U1z��.�^�ߋěN���,���� �f��V�    IEND�B`�           [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=[ "res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=false
svg/scale=1.0
              [remap]

path="res://Bag.gdc"
  [remap]

path="res://BagItem.gdc"
              [remap]

path="res://GroundItem.gdc"
           �PNG

   IHDR   @   @   �iq�   sRGB ���  �IDATx��ytTU��?�ի%���@ȞY1JZ �iA�i�[P��e��c;�.`Ow+4�>�(}z�EF�Dm�:�h��IHHB�BR!{%�Zߛ?��	U�T�
���:��]~�������-�	Ì�{q*�h$e-
�)��'�d�b(��.�B�6��J�ĩ=;���Cv�j��E~Z��+��CQ�AA�����;�.�	�^P	���ARkUjQ�b�,#;�8�6��P~,� �0�h%*QzE� �"��T��
�=1p:lX�Pd�Y���(:g����kZx ��A���띊3G�Di� !�6����A҆ @�$JkD�$��/�nYE��< Q���<]V�5O!���>2<��f��8�I��8��f:a�|+�/�l9�DEp�-�t]9)C�o��M~�k��tw�r������w��|r�Ξ�	�S�)^� ��c�eg$�vE17ϟ�(�|���Ѧ*����
����^���uD�̴D����h�����R��O�bv�Y����j^�SN֝
������PP���������Y>����&�P��.3+�$��ݷ�����{n����_5c�99�fbסF&�k�mv���bN�T���F���A�9�
(.�'*"��[��c�{ԛmNު8���3�~V� az
�沵�f�sD��&+[���ke3o>r��������T�]����* ���f�~nX�Ȉ���w+�G���F�,U�� D�Դ0赍�!�B�q�c�(
ܱ��f�yT�:��1�� +����C|��-�T��D�M��\|�K�j��<yJ, ����n��1.FZ�d$I0݀8]��Jn_� ���j~����ցV���������1@M�)`F�BM����^x�>
����`��I�˿��wΛ	����W[�����v��E�����u��~��{R�(����3���������y����C��!��nHe�T�Z�����K�P`ǁF´�nH啝���=>id,�>�GW-糓F������m<P8�{o[D����w�Q��=N}�!+�����-�<{[���������w�u�L�����4�����Uc�s��F�륟��c�g�u�s��N��lu���}ן($D��ת8m�Q�V	l�;��(��ڌ���k�
s\��JDIͦOzp��مh����T���IDI���W�Iǧ�X���g��O��a�\:���>����g���%|����i)	�v��]u.�^�:Gk��i)	>��T@k{'	=�������@a�$zZ�;}�󩀒��T�6�Xq&1aWO�,&L�cřT�4P���g[�
p�2��~;� ��Ҭ�29�xri� ��?��)��_��@s[��^�ܴhnɝ4&'
��NanZ4��^Js[ǘ��2���x?Oܷ�$��3�$r����Q��1@�����~��Y�Qܑ�Hjl(}�v�4vSr�iT�1���f������(���A�ᥕ�$� X,�3'�0s����×ƺk~2~'�[�ё�&F�8{2O�y�n�-`^/FPB�?.�N�AO]]�� �n]β[�SR�kN%;>�k��5������]8������=p����Ցh������`}�
�J�8-��ʺ����� �fl˫[8�?E9q�2&������p��<�r�8x� [^݂��2�X��z�V+7N����V@j�A����hl��/+/'5�3�?;9
�(�Ef'Gyҍ���̣�h4RSS� ����������j�Z��jI��x��dE-y�a�X�/�����:��� +k�� �"˖/���+`��],[��UVV4u��P �˻�AA`��)*ZB\\��9lܸ�]{N��礑]6�Hnnqqq-a��Qxy�7�`=8A�Sm&�Q�����u�0hsPz����yJt�[�>�/ޫ�il�����.��ǳ���9��
_
��<s���wT�S������;F����-{k�����T�Z^���z�!t�۰؝^�^*���؝c
���;��7]h^
��PA��+@��gA*+�K��ˌ�)S�1��(Ե��ǯ�h����õ�M�`��p�cC�T")�z�j�w��V��@��D��N�^M\����m�zY��C�Ҙ�I����N�Ϭ��{�9�)����o���C���h�����ʆ.��׏(�ҫ���@�Tf%yZt���wg�4s�]f�q뗣�ǆi�l�⵲3t��I���O��v;Z�g��l��l��kAJѩU^wj�(��������{���)�9�T���KrE�V!�D���aw���x[�I��tZ�0Y �%E�͹���n�G�P�"5FӨ��M�K�!>R���$�.x����h=gϝ�K&@-F��=}�=�����5���s �CFwa���8��u?_����D#���x:R!5&��_�]���*�O��;�)Ȉ�@�g�����ou�Q�v���J�G�6�P�������7��-���	պ^#�C�S��[]3��1���IY��.Ȉ!6\K�:��?9�Ev��S]�l;��?/� ��5�p�X��f�1�;5�S�ye��Ƅ���,Da�>�� O.�AJL(���pL�C5ij޿hBƾ���ڎ�)s��9$D�p���I��e�,ə�+;?�t��v�p�-��&����	V���x���yuo-G&8->�xt�t������Rv��Y�4ZnT�4P]�HA�4�a�T�ǅ1`u\�,���hZ����S������o翿���{�릨ZRq��Y��fat�[����[z9��4�U�V��Anb$Kg������]������8�M0(WeU�H�\n_��¹�C�F�F�}����8d�N��.��]���u�,%Z�F-���E�'����q�L�\������=H�W'�L{�BP0Z���Y�̞���DE��I�N7���c��S���7�Xm�/`�	�+`����X_��KI��^��F\�aD�����~�+M����ㅤ��	SY��/�.�`���:�9Q�c �38K�j�0Y�D�8����W;ܲ�pTt��6P,� Nǵ��Æ�:(���&�N�/ X��i%�?�_P	�n�F�.^�G�E���鬫>?���"@v�2���A~�aԹ_[P, n��N������_rƢ��    IEND�B`�       ECFG      application/config/name         Godot      application/run/main_scene         res://World.tscn   application/config/icon         res://icon.png     display/window/size/width      �     display/window/size/height      @     display/window/size/test_width      �     display/window/size/test_height      �     display/window/stretch/mode         2d     display/window/stretch/aspect         keep   importer_defaults/texture\              compress/bptc_ldr                compress/hdr_mode                compress/lossy_quality    ffffff�?      compress/mode                compress/normal_map           	   detect_3d                flags/anisotropic                flags/filter             flags/mipmaps                flags/repeat          
   flags/srgb              process/HDR_as_SRGB              process/fix_alpha_border            process/invert_color             process/premult_alpha             
   size_limit               stream            	   svg/scale        �?   input/mouse_select�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           button_mask           position              global_position               factor       �?   button_index         pressed           doubleclick           script      )   physics/common/enable_pause_aware_picking         $   rendering/quality/driver/driver_name         GLES2   )   rendering/environment/default_environment          res://default_env.tres         