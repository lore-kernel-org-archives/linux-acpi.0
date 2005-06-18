From: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
Subject: oops with asus_acpi on P30/P35
Date: Sat, 18 Jun 2005 02:45:06 +0200
Message-ID: <20050618004506.GE3690@orest.greek0.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--J5MfuwkIyy7RmF4Q
Content-Type: multipart/mixed; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've read the other thread about this problem on acpi-devel, and I'm
running into the same thing here.

The oops and ksymoops output is attatched.

I went to debug the problem.

The oops occurs in asus_acpi.c, line 1016:
    hotk->model = END_MODEL;
	if (strncmp(model->string.pointer, "L3D", 3) == 0) // <-- OOPS
		hotk->model = L3D;

Some added debug printk's later it turned out that:
model->type == ACPI_TYPE_INTEGER
model->integer.value == 56

This is why the problem wasn't fixed by your patch, since that
resided in the if (model->type == ACPI_TYPE_STRING) code-path.
I've attatched a patch that works for me, but IMHO it's ugly and
only fixes the sympthoms. Why do we get an integer here in the first
place?

Please mail me if you have more questions, stuff for me to try out,
or eventually figure out what's going on here.

Cheers,
Christian Aichinger

PS: Please CC: me, I'm not subscribed to acpi-devel.

--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"
Content-Transfer-Encoding: quoted-printable

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
e1a833ae
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT=20
Modules linked in: asus_acpi acpi_cpufreq freq_table pcmcia thermal fan but=
ton processor ac battery af_packet eth1394 ohci1394 yenta_socket rsrc_nonst=
atic pcmcia_core 8139too mii snd_intel8x0m snd_intel8x0 snd_ac97_codec i2c_=
i801 ehci_hcd usbhid uhci_hcd usbcore shpchp pci_hotplug mousedev joydev nl=
s_utf8 ntfs cpuid sbp2 scsi_mod ieee1394 psmouse genrtc evdev
CPU:    0
EIP:    0060:[<e1a833ae>]    Not tainted VLI
EFLAGS: 00010203   (2.6.12-rc6r20050617d)=20
EIP is at asus_hotk_get_info+0x1b7/0x7a4 [asus_acpi]
eax: 00000000   ebx: dd05ff38   ecx: 00000002   edx: 00000003
esi: 00000000   edi: e1a9aaf4   ebp: def70840   esp: dd05fefc
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 3997, threadinfo=3Ddd05e000 task=3Ddf5a0060)
Stack: 00000000 00000002 dff52700 c14dcf34 c0453898 c01cf6d0 c0453898 00000=
000=20
       dd05ff20 00000000 df994100 dff52700 00000000 00005105 dd7b8000 00000=
010=20
       def70840 dfe0b000 e1a9aeb4 dfe0b084 00000000 e1a839cf e1a83a63 dfe0b=
000=20
Call Trace:
 [<c01cf6d0>] idr_get_new_above_int+0x90/0x130
 [<e1a839cf>] asus_hotk_check+0x34/0x35 [asus_acpi]
 [<e1a83a63>] asus_hotk_add+0x93/0x158 [asus_acpi]
 [<c0216436>] acpi_bus_driver_init+0x2c/0x8a
 [<c02164f9>] acpi_driver_attach+0x65/0xab
 [<e1a83b6a>] asus_acpi_init+0x42/0x6e [asus_acpi]
 [<c0137704>] sys_init_module+0x154/0x200
 [<c0103245>] syscall_call+0x7/0xb
Code: e1 e8 b7 7b 69 de 5e 5f a1 90 ce a9 e1 ba 03 00 00 00 bf f4 aa a9 e1 =
89 d1 c7 40 14 12 00 00 00 8b 45 08 89 c6 89 04 24 49 78 08 <ac> ae 75 08 8=
4 c0 75 f5 31 c0 eb 04 19 c0 0c 01 85 c0 75 11 a1=20
=20

--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops.txt"
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.9 on i686 2.6.12-rc6r20050617d.  Options used
     -V (default)
     -k /tmp/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.12-rc6r20050617d/ (default)
     -m /boot/System.map-2.6.12-rc6r20050617d (default)

Warning (read_ksyms): no kernel symbols in ksyms, is /tmp/kallsyms a valid =
ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
ehci_hcd 0000:00:1d.7: debug port 1
8139too Fast Ethernet driver 0.9.27
Unable to handle kernel NULL pointer dereference at virtual address 00000000
e1a833ae
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<e1a833ae>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203   (2.6.12-rc6r20050617d)=20
eax: 00000000   ebx: dd05ff38   ecx: 00000002   edx: 00000003
esi: 00000000   edi: e1a9aaf4   ebp: def70840   esp: dd05fefc
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 00000002 dff52700 c14dcf34 c0453898 c01cf6d0 c0453898 00000=
000=20
       dd05ff20 00000000 df994100 dff52700 00000000 00005105 dd7b8000 00000=
010=20
       def70840 dfe0b000 e1a9aeb4 dfe0b084 00000000 e1a839cf e1a83a63 dfe0b=
000=20
Call Trace:
 [<c01cf6d0>] idr_get_new_above_int+0x90/0x130
 [<e1a839cf>] asus_hotk_check+0x34/0x35 [asus_acpi]
 [<e1a83a63>] asus_hotk_add+0x93/0x158 [asus_acpi]
 [<c0216436>] acpi_bus_driver_init+0x2c/0x8a
 [<c02164f9>] acpi_driver_attach+0x65/0xab
 [<e1a83b6a>] asus_acpi_init+0x42/0x6e [asus_acpi]
 [<c0137704>] sys_init_module+0x154/0x200
 [<c0103245>] syscall_call+0x7/0xb
Code: e1 e8 b7 7b 69 de 5e 5f a1 90 ce a9 e1 ba 03 00 00 00 bf f4 aa a9 e1 =
89 d1 c7 40 14 12 00 00 00 8b 45 08 89 c6 89 04 24 49 78 08 <ac> ae 75 08 8=
4 c0 75 f5 31 c0 eb 04 19 c0 0c 01 85 c0 75 11 a1=20


>>EIP; e1a833ae <pg0+216123ae/3fb8d400>   <=3D=3D=3D=3D=3D

>>ebx; dd05ff38 <pg0+1cbeef38/3fb8d400>
>>edi; e1a9aaf4 <pg0+21629af4/3fb8d400>
>>ebp; def70840 <pg0+1eaff840/3fb8d400>
>>esp; dd05fefc <pg0+1cbeeefc/3fb8d400>

Trace; c01cf6d0 <idr_get_new_above_int+90/130>
Trace; e1a839cf <pg0+216129cf/3fb8d400>
Trace; e1a83a63 <pg0+21612a63/3fb8d400>
Trace; c0216436 <acpi_bus_driver_init+2c/8a>
Trace; c02164f9 <acpi_driver_attach+65/ab>
Trace; e1a83b6a <pg0+21612b6a/3fb8d400>
Trace; c0137704 <sys_init_module+154/200>
Trace; c0103245 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  e1a83383 <pg0+21612383/3fb8d400>
00000000 <_EIP>:
Code;  e1a83383 <pg0+21612383/3fb8d400>
   0:   e1 e8                     loope  ffffffea <_EIP+0xffffffea>
Code;  e1a83385 <pg0+21612385/3fb8d400>
   2:   b7 7b                     mov    $0x7b,%bh
Code;  e1a83387 <pg0+21612387/3fb8d400>
   4:   69 de 5e 5f a1 90         imul   $0x90a15f5e,%esi,%ebx
Code;  e1a8338d <pg0+2161238d/3fb8d400>
   a:   ce                        into  =20
Code;  e1a8338e <pg0+2161238e/3fb8d400>
   b:   a9 e1 ba 03 00            test   $0x3bae1,%eax
Code;  e1a83393 <pg0+21612393/3fb8d400>
  10:   00 00                     add    %al,(%eax)
Code;  e1a83395 <pg0+21612395/3fb8d400>
  12:   bf f4 aa a9 e1            mov    $0xe1a9aaf4,%edi
Code;  e1a8339a <pg0+2161239a/3fb8d400>
  17:   89 d1                     mov    %edx,%ecx
Code;  e1a8339c <pg0+2161239c/3fb8d400>
  19:   c7 40 14 12 00 00 00      movl   $0x12,0x14(%eax)
Code;  e1a833a3 <pg0+216123a3/3fb8d400>
  20:   8b 45 08                  mov    0x8(%ebp),%eax
Code;  e1a833a6 <pg0+216123a6/3fb8d400>
  23:   89 c6                     mov    %eax,%esi
Code;  e1a833a8 <pg0+216123a8/3fb8d400>
  25:   89 04 24                  mov    %eax,(%esp)
Code;  e1a833ab <pg0+216123ab/3fb8d400>
  28:   49                        dec    %ecx
Code;  e1a833ac <pg0+216123ac/3fb8d400>
  29:   78 08                     js     33 <_EIP+0x33>

This decode from eip onwards should be reliable

Code;  e1a833ae <pg0+216123ae/3fb8d400>
00000000 <_EIP>:
Code;  e1a833ae <pg0+216123ae/3fb8d400>   <=3D=3D=3D=3D=3D
   0:   ac                        lods   %ds:(%esi),%al   <=3D=3D=3D=3D=3D
Code;  e1a833af <pg0+216123af/3fb8d400>
   1:   ae                        scas   %es:(%edi),%al
Code;  e1a833b0 <pg0+216123b0/3fb8d400>
   2:   75 08                     jne    c <_EIP+0xc>
Code;  e1a833b2 <pg0+216123b2/3fb8d400>
   4:   84 c0                     test   %al,%al
Code;  e1a833b4 <pg0+216123b4/3fb8d400>
   6:   75 f5                     jne    fffffffd <_EIP+0xfffffffd>
Code;  e1a833b6 <pg0+216123b6/3fb8d400>
   8:   31 c0                     xor    %eax,%eax
Code;  e1a833b8 <pg0+216123b8/3fb8d400>
   a:   eb 04                     jmp    10 <_EIP+0x10>
Code;  e1a833ba <pg0+216123ba/3fb8d400>
   c:   19 c0                     sbb    %eax,%eax
Code;  e1a833bc <pg0+216123bc/3fb8d400>
   e:   0c 01                     or     $0x1,%al
Code;  e1a833be <pg0+216123be/3fb8d400>
  10:   85 c0                     test   %eax,%eax
Code;  e1a833c0 <pg0+216123c0/3fb8d400>
  12:   75 11                     jne    25 <_EIP+0x25>
Code;  e1a833c2 <pg0+216123c2/3fb8d400>
  14:   a1                        .byte 0xa1


1 warning issued.  Results may not be reliable.

--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="asus_acpi.c-p35-fix.diff"
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -993,6 +993,7 @@ static int __init asus_hotk_get_info(voi
 	/* Samsung P30 has a device with a valid _HID whose INIT does not=20
 	 * return anything. Catch this one and any similar here */
 	if (buffer.pointer =3D=3D NULL) {
+try_p30:
 		if (asus_info && /* Samsung P30 */
 		    strncmp(asus_info->oem_table_id, "ODEM", 4) =3D=3D 0) {
 			hotk->model =3D P30;
@@ -1012,6 +1013,9 @@ static int __init asus_hotk_get_info(voi
 		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
 	}
=20
+	if (model->type !=3D ACPI_TYPE_STRING)
+		goto try_p30;
+
 	hotk->model =3D END_MODEL;
 	if (strncmp(model->string.pointer, "L3D", 3) =3D=3D 0)
 		hotk->model =3D L3D;

--p2kqVDKq5asng8Dg--

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCs26SxsP1RlTwJHsRAspBAJ43PHEG8sfO2GUZEe4b+ai+lVOvlwCeMwLd
qqD4GDhR+a86ZfT0jc4ozj8=
=djOh
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
