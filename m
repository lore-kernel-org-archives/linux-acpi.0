From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi OOPS
Date: Mon, 16 Jun 2003 12:37:17 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96F7C@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3343E.B21FCC31"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jes Sorensen <jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3343E.B21FCC31
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Does this fix it?

Thanks -- Regards -- Andy

> -----Original Message-----
> From: Jes Sorensen [mailto:jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org]=20
> Sent: Monday, June 16, 2003 12:23 PM
> To: Grover, Andrew
> Subject: acpi OOPS
>=20
>=20
> Hi Andy,
>=20
> I tested the 20030523 release for 2.4.21-rc3 against 2.4.21=20
> and got this
> oops when I did 'echo "5" > /proc/acpi/sleep' on a Sony VAIO=20
> R505 laptop.
>=20
> Cheers,
> Jes
>=20
> Unable to handle kernel NULL pointer dereference at virtual=20
> address 00000000
> c0111aab
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c0111aab>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010002
> eax: 00000000   ebx: 00000005   ecx: c13753e0   edx: 00000000
> esi: 00000005   edi: 00000005   ebp: 00000002   esp: d1af7ef8
> ds: 0018   es: 0018   ss: 0018
> Process bash (pid: 1324, stackpage=3Dd1af7000)
> Stack: c018dbd0 00000005 00000001 c018ddab 00000005 00000005=20
> 00000005 00000005=20
>        00000002 d3ccec60 d1af7f2c c018e286 00000005 00000a35=20
> 00000000 00000000=20
>        c013ff78 00000000 d1aa81a0 ffffffea c014e871 d1aa81a0=20
> 080cd40c 00000002=20
> Call Trace:    [<c018dbd0>] [<c018ddab>] [<c018e286>]=20
> [<c013ff78>] [<c014e871>]
>   [<c01342d6>] [<c0133d9d>] [<c0106d93>]
> Code: 89 02 0f 20 d8 0f 22 d8 a1 24 b7 27 c0 31 d2 e9 41 d0 01 00=20
>=20
> >>EIP; c0111aab <acpi_restore_pmd+b/20>   <=3D=3D=3D=3D=3D
> Trace; c018dbd0 <acpi_system_restore_state+10/70>
> Trace; c018ddab <acpi_suspend+9b/b0>
> Trace; c018e286 <acpi_system_write_sleep+76/90>
> Trace; c013ff78 <locate_fd+d8/110>
> Trace; c014e871 <proc_file_write+31/40>
> Trace; c01342d6 <sys_write+96/f0>
> Trace; c0133d9d <filp_close+4d/60>
> Trace; c0106d93 <system_call+33/38>
> Code;  c0111aab <acpi_restore_pmd+b/20>
> 00000000 <_EIP>:
> Code;  c0111aab <acpi_restore_pmd+b/20>   <=3D=3D=3D=3D=3D
>    0:   89 02                     mov    %eax,(%edx)   =
<=3D=3D=3D=3D=3D
> Code;  c0111aad <acpi_restore_pmd+d/20>
>    2:   0f 20 d8                  mov    %cr3,%eax
> Code;  c0111ab0 <acpi_restore_pmd+10/20>
>    5:   0f 22 d8                  mov    %eax,%cr3
> Code;  c0111ab3 <acpi_restore_pmd+13/20>
>    8:   a1 24 b7 27 c0            mov    0xc027b724,%eax
> Code;  c0111ab8 <acpi_restore_pmd+18/20>
>    d:   31 d2                     xor    %edx,%edx
> Code;  c0111aba <acpi_restore_pmd+1a/20>
>    f:   e9 41 d0 01 00            jmp    1d055 <_EIP+0x1d055>=20
> c012eb00 <free_pages+0/30>
>=20
>=20

------_=_NextPart_001_01C3343E.B21FCC31
Content-Type: application/octet-stream;
	name="Jes.diff"
Content-Transfer-Encoding: base64
Content-Description: Jes.diff
Content-Disposition: attachment;
	filename="Jes.diff"

PT09PT0gZHJpdmVycy9hY3BpL3N5c3RlbS5jIDEuOCB2cyBlZGl0ZWQgPT09PT0KLS0tIDEuOC9k
cml2ZXJzL2FjcGkvc3lzdGVtLmMJRnJpIE1hciAyMSAxMToyODoxMiAyMDAzCisrKyBlZGl0ZWQv
ZHJpdmVycy9hY3BpL3N5c3RlbS5jCU1vbiBKdW4gMTYgMTI6MzQ6NDQgMjAwMwpAQCAtMjc3LDYg
KzI3Nyw3IEBACiAKIAlzd2l0Y2ggKHN0YXRlKSB7CiAJY2FzZSBBQ1BJX1NUQVRFX1MxOgorCWNh
c2UgQUNQSV9TVEFURV9TNToKIAkJYmFycmllcigpOwogCQlzdGF0dXMgPSBhY3BpX2VudGVyX3Ns
ZWVwX3N0YXRlKHN0YXRlKTsKIAkJYnJlYWs7Cg==

------_=_NextPart_001_01C3343E.B21FCC31--


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
