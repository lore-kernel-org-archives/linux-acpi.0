From: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] GDT table patch for resume only reboots problem
Date: Mon, 18 Oct 2004 05:17:21 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OFC0526CFC.7FFB98D1-ON49256F30.0068372D-49256F30.006EF530@jp.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	Boundary="0__=C6BBE5A3DFFBB1BD8f9e8a93df938690918cC6BBE5A3DFFBB1BD"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--0__=C6BBE5A3DFFBB1BD8f9e8a93df938690918cC6BBE5A3DFFBB1BD
Content-type: text/plain; charset=US-ASCII





Hi,

Using 2.6.9 RC4 kernel + Shaohua-san's wakeup patch, my test machine
resumes just before
ljmpl $__KERNEL_CS,$wakeup_pmode_return in wakeup.S.
(This is confirmed by parallel port(0x3bc) out like BIOS steping number.)

The code would not come back to wakeup_pmode_return entry and goes to
reboot. After fairly tough debugging, it is found that the original GDT
pointed by GDTR cannot be accessed from real mode. (This may occurr
especially when CR4 PSE bit is on.)

The following patch will partially copy the GDT into low memory to be
addressable.
(See attached file: wakeup_gdt.patch)

I hope most of machines can resume with;

Kernel 2.6.9 RC4
+wakeup_addr.patch
+wakeup_gdt.patch

If you cannot see the screen normally after resume, "acpi_sleep=s3_bios"
boot option is available to reset the video mode.
(My ThinkPad is still in trouble with HDD access after resume because of
unknown reason. :-)

Regards, Hiro.
--0__=C6BBE5A3DFFBB1BD8f9e8a93df938690918cC6BBE5A3DFFBB1BD
Content-type: application/octet-stream;
	name="wakeup_gdt.patch"
Content-Disposition: attachment; filename="wakeup_gdt.patch"
Content-transfer-encoding: base64

LS0tIGEvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL3dha2V1cC5TCTIwMDQtMDgtMTQgMTQ6MzY6MzEu
MDAwMDAwMDAwICswOTAwCisrKyBiL2FyY2gvaTM4Ni9rZXJuZWwvYWNwaS93YWtldXAuUwkyMDA0
LTEwLTE4IDA0OjMwOjUzLjY4NDk4NzAxNiArMDkwMApAQCAtNjcsNiArNjcsMTMgQEAKIAltb3Z3
CSQweDBlMDAgKyAnaScsICVmczooMHgxMikKIAkKIAkjIG5lZWQgYSBnZHQKKwkjIHVzZSB0aGUg
Z2R0IGNvcGllZCBpbiB0aGlzIGxvdyBtZW0KKwlsZWEgICAgIHRlbXBfZ2R0X3RhYmxlIC0gd2Fr
ZXVwX2NvZGUsICVlYXgKKwl4b3IgICAgICVlYngsICVlYngKKwltb3Z3ICAgICVkcywgJWJ4CisJ
c2hsbCAgICAkNCwgJWVieAorCWFkZGwgICAgJWVieCwgJWVheAorCW1vdmwgICAgJWVheCwgcmVh
bF9zYXZlX2dkdCArIDIgLSB3YWtldXBfY29kZQogCWxnZHQJcmVhbF9zYXZlX2dkdCAtIHdha2V1
cF9jb2RlCiAKIAltb3ZsCXJlYWxfc2F2ZV9jcjAgLSB3YWtldXBfY29kZSwgJWVheApAQCAtODks
NiArOTYsNyBAQAogcmVhbF9tYWdpYzoJLmxvbmcgMAogdmlkZW9fbW9kZToJLmxvbmcgMAogdmlk
ZW9fZmxhZ3M6CS5sb25nIDAKK3RlbXBfZ2R0X3RhYmxlOiAuZmlsbCBHRFRfRU5UUklFUywgOCwg
MAogCiBib2d1c19yZWFsX21hZ2ljOgogCW1vdncJJDB4MGUwMCArICdCJywgJWZzOigweDEyKQpA
QCAtMjMxLDYgKzIzOSwxNCBAQAogCW1vdmwJJWVkeCwgcmVhbF9zYXZlX2NyMCAtIHdha2V1cF9z
dGFydCAoJWVheCkKIAlzZ2R0ICAgIHJlYWxfc2F2ZV9nZHQgLSB3YWtldXBfc3RhcnQgKCVlYXgp
CiAKKwkjIGdkdCBib2R5IG11c3QgYmUgYWRkcmVzc2FibGUgZnJvbSByZWFsIG1vZGUgYnkKKwkj
IHBhcnRpYWxseSBjb3B5aW5nIGl0IHRvIHRoZSBsb3dlciBtZW0KKwl4b3IgICAgICVlY3gsICVl
Y3gKKwltb3Z3ICAgIHNhdmVkX2dkdCwgJWN4CisJbW92bCAgICBzYXZlZF9nZHQgKyAyLCAlZXNp
CisJbGVhICAgICB0ZW1wX2dkdF90YWJsZSAtIHdha2V1cF9zdGFydCAoJWVheCksICVlZGkKKwly
ZXAgbW92c2IKKwogCW1vdmwJc2F2ZWRfdmlkZW9tb2RlLCAlZWR4CiAJbW92bAklZWR4LCB2aWRl
b19tb2RlIC0gd2FrZXVwX3N0YXJ0ICglZWF4KQogCW1vdmwJYWNwaV92aWRlb19mbGFncywgJWVk
eAo=

--0__=C6BBE5A3DFFBB1BD8f9e8a93df938690918cC6BBE5A3DFFBB1BD--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
