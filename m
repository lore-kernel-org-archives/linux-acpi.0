From: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] GDT table patch for resume only reboots problem
Date: Tue, 19 Oct 2004 05:38:09 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OFD3267728.221C77BC-ON49256F31.006D2ECA-49256F31.0070E4AF@jp.ibm.com>
References: <20041017210052.GB23733@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	Boundary="0__=C6BBE5A2DFFEA85A8f9e8a93df938690918cC6BBE5A2DFFEA85A"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041017210052.GB23733-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--0__=C6BBE5A2DFFEA85A8f9e8a93df938690918cC6BBE5A2DFFEA85A
Content-type: text/plain; charset=US-ASCII





Pavel,

You wrote.

>What you do at resume time is some computation based on %ds. You can
>do it during suspend time as well, %ds is same as %cs during resume,
>and that should be known during suspend... its the address you set to
>wakeup_vector >> 4.

You are right and I agree gdtr save area can be modified via
acpi_copy_wakeup_routine() with its FASTCALL argument added. This is the
second version of gdt table patch. Also I changed temp_gdt... to
real_gdt... because temp_gdt... looks like temporary fix.

Thanks, Hiro.

=================================================================================================
diff -Nru a/arch/i386/kernel/acpi/sleep.c b/arch/i386/kernel/acpi/sleep.c
--- a/arch/i386/kernel/acpi/sleep.c 2004-10-15 11:29:15.000000000 +0900
+++ b/arch/i386/kernel/acpi/sleep.c 2004-10-19 00:59:32.000000000 +0900
@@ -17,7 +17,7 @@

 extern void zap_low_mappings(void);

-extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned long));
+extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned
long,unsigned long));

 static void init_low_mapping(pgd_t *pgd, int pgd_limit)
 {
@@ -41,7 +41,8 @@
            return 1;
      init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
      memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end -
&wakeup_start);
-     acpi_copy_wakeup_routine(acpi_wakeup_address);
+     acpi_copy_wakeup_routine(acpi_wakeup_address,
+                        virt_to_phys((void *)acpi_wakeup_address));

      return 0;
 }
diff -Nru a/arch/i386/kernel/acpi/wakeup.S b/arch/i386/kernel/acpi/wakeup.S
--- a/arch/i386/kernel/acpi/wakeup.S      2004-08-14 14:36:31.000000000
+0900
+++ b/arch/i386/kernel/acpi/wakeup.S      2004-10-19 05:24:42.000000000
+0900
@@ -89,6 +89,7 @@
 real_magic:      .long 0
 video_mode:      .long 0
 video_flags:     .long 0
+real_gdt_table: .fill GDT_ENTRIES, 8, 0

 bogus_real_magic:
      movw  $0x0e00 + 'B', %fs:(0x12)
@@ -213,6 +214,7 @@
 #
 # Parameters:
 # %eax:    place to copy wakeup routine to
+# %edx: the second argument (physical address)
 #
 # Returned address is location of code in low memory (past data and stack)
 #
@@ -223,6 +225,9 @@
      sldt  saved_ldt
      str   saved_tss

+     # save wakeup_start physical address in ecx
+     movl  %edx, %ecx
+
      movl    %cr3, %edx
      movl    %edx, real_save_cr3 - wakeup_start (%eax)
      movl    %cr4, %edx
@@ -231,6 +236,16 @@
      movl  %edx, real_save_cr0 - wakeup_start (%eax)
      sgdt    real_save_gdt - wakeup_start (%eax)

+     # gdt body must be addressable from real mode by
+     # copying it to the lower mem
+     lea     real_gdt_table - wakeup_start (%ecx), %ecx
+     movl    %ecx, real_save_gdt + 2 - wakeup_start (%eax)
+     xor     %ecx, %ecx
+     movw    saved_gdt, %cx
+     movl    saved_gdt + 2, %esi
+     lea     real_gdt_table - wakeup_start (%eax), %edi
+     rep movsb
+
      movl  saved_videomode, %edx
      movl  %edx, video_mode - wakeup_start (%eax)
      movl  acpi_video_flags, %edx
=================================================================================================
(See attached file: wakeup_gdt2.patch)
--0__=C6BBE5A2DFFEA85A8f9e8a93df938690918cC6BBE5A2DFFEA85A
Content-type: application/octet-stream;
	name="wakeup_gdt2.patch"
Content-Disposition: attachment; filename="wakeup_gdt2.patch"
Content-transfer-encoding: base64

ZGlmZiAtTnJ1IGEvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL3NsZWVwLmMgYi9hcmNoL2kzODYva2Vy
bmVsL2FjcGkvc2xlZXAuYwotLS0gYS9hcmNoL2kzODYva2VybmVsL2FjcGkvc2xlZXAuYwkyMDA0
LTEwLTE1IDExOjI5OjE1LjAwMDAwMDAwMCArMDkwMAorKysgYi9hcmNoL2kzODYva2VybmVsL2Fj
cGkvc2xlZXAuYwkyMDA0LTEwLTE5IDAwOjU5OjMyLjAwMDAwMDAwMCArMDkwMApAQCAtMTcsNyAr
MTcsNyBAQAogCiBleHRlcm4gdm9pZCB6YXBfbG93X21hcHBpbmdzKHZvaWQpOwogCi1leHRlcm4g
dW5zaWduZWQgbG9uZyBGQVNUQ0FMTChhY3BpX2NvcHlfd2FrZXVwX3JvdXRpbmUodW5zaWduZWQg
bG9uZykpOworZXh0ZXJuIHVuc2lnbmVkIGxvbmcgRkFTVENBTEwoYWNwaV9jb3B5X3dha2V1cF9y
b3V0aW5lKHVuc2lnbmVkIGxvbmcsdW5zaWduZWQgbG9uZykpOwogCiBzdGF0aWMgdm9pZCBpbml0
X2xvd19tYXBwaW5nKHBnZF90ICpwZ2QsIGludCBwZ2RfbGltaXQpCiB7CkBAIC00MSw3ICs0MSw4
IEBACiAJCXJldHVybiAxOwogCWluaXRfbG93X21hcHBpbmcoc3dhcHBlcl9wZ19kaXIsIFVTRVJf
UFRSU19QRVJfUEdEKTsKIAltZW1jcHkoKHZvaWQgKikgYWNwaV93YWtldXBfYWRkcmVzcywgJndh
a2V1cF9zdGFydCwgJndha2V1cF9lbmQgLSAmd2FrZXVwX3N0YXJ0KTsKLQlhY3BpX2NvcHlfd2Fr
ZXVwX3JvdXRpbmUoYWNwaV93YWtldXBfYWRkcmVzcyk7CisJYWNwaV9jb3B5X3dha2V1cF9yb3V0
aW5lKGFjcGlfd2FrZXVwX2FkZHJlc3MsCisJCQkJIHZpcnRfdG9fcGh5cygodm9pZCAqKWFjcGlf
d2FrZXVwX2FkZHJlc3MpKTsKIAogCXJldHVybiAwOwogfQpkaWZmIC1OcnUgYS9hcmNoL2kzODYv
a2VybmVsL2FjcGkvd2FrZXVwLlMgYi9hcmNoL2kzODYva2VybmVsL2FjcGkvd2FrZXVwLlMKLS0t
IGEvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL3dha2V1cC5TCTIwMDQtMDgtMTQgMTQ6MzY6MzEuMDAw
MDAwMDAwICswOTAwCisrKyBiL2FyY2gvaTM4Ni9rZXJuZWwvYWNwaS93YWtldXAuUwkyMDA0LTEw
LTE5IDA1OjI0OjQyLjAwMDAwMDAwMCArMDkwMApAQCAtODksNiArODksNyBAQAogcmVhbF9tYWdp
YzoJLmxvbmcgMAogdmlkZW9fbW9kZToJLmxvbmcgMAogdmlkZW9fZmxhZ3M6CS5sb25nIDAKK3Jl
YWxfZ2R0X3RhYmxlOiAuZmlsbCBHRFRfRU5UUklFUywgOCwgMAogCiBib2d1c19yZWFsX21hZ2lj
OgogCW1vdncJJDB4MGUwMCArICdCJywgJWZzOigweDEyKQpAQCAtMjEzLDYgKzIxNCw3IEBACiAj
CiAjIFBhcmFtZXRlcnM6CiAjICVlYXg6CXBsYWNlIHRvIGNvcHkgd2FrZXVwIHJvdXRpbmUgdG8K
KyMgJWVkeDogdGhlIHNlY29uZCBhcmd1bWVudCAocGh5c2ljYWwgYWRkcmVzcykKICMKICMgUmV0
dXJuZWQgYWRkcmVzcyBpcyBsb2NhdGlvbiBvZiBjb2RlIGluIGxvdyBtZW1vcnkgKHBhc3QgZGF0
YSBhbmQgc3RhY2spCiAjCkBAIC0yMjMsNiArMjI1LDkgQEAKIAlzbGR0CXNhdmVkX2xkdAogCXN0
cglzYXZlZF90c3MKIAorCSMgc2F2ZSB3YWtldXBfc3RhcnQgcGh5c2ljYWwgYWRkcmVzcyBpbiBl
Y3gKKwltb3ZsCSVlZHgsICVlY3gKKwogCW1vdmwgICAgJWNyMywgJWVkeAogCW1vdmwgICAgJWVk
eCwgcmVhbF9zYXZlX2NyMyAtIHdha2V1cF9zdGFydCAoJWVheCkKIAltb3ZsICAgICVjcjQsICVl
ZHgKQEAgLTIzMSw2ICsyMzYsMTYgQEAKIAltb3ZsCSVlZHgsIHJlYWxfc2F2ZV9jcjAgLSB3YWtl
dXBfc3RhcnQgKCVlYXgpCiAJc2dkdCAgICByZWFsX3NhdmVfZ2R0IC0gd2FrZXVwX3N0YXJ0ICgl
ZWF4KQogCisJIyBnZHQgYm9keSBtdXN0IGJlIGFkZHJlc3NhYmxlIGZyb20gcmVhbCBtb2RlIGJ5
CisJIyBjb3B5aW5nIGl0IHRvIHRoZSBsb3dlciBtZW0KKwlsZWEgICAgIHJlYWxfZ2R0X3RhYmxl
IC0gd2FrZXVwX3N0YXJ0ICglZWN4KSwgJWVjeAorCW1vdmwgICAgJWVjeCwgcmVhbF9zYXZlX2dk
dCArIDIgLSB3YWtldXBfc3RhcnQgKCVlYXgpCisJeG9yICAgICAlZWN4LCAlZWN4CisJbW92dyAg
ICBzYXZlZF9nZHQsICVjeAorCW1vdmwgICAgc2F2ZWRfZ2R0ICsgMiwgJWVzaQorCWxlYSAgICAg
cmVhbF9nZHRfdGFibGUgLSB3YWtldXBfc3RhcnQgKCVlYXgpLCAlZWRpCisJcmVwIG1vdnNiCisK
IAltb3ZsCXNhdmVkX3ZpZGVvbW9kZSwgJWVkeAogCW1vdmwJJWVkeCwgdmlkZW9fbW9kZSAtIHdh
a2V1cF9zdGFydCAoJWVheCkKIAltb3ZsCWFjcGlfdmlkZW9fZmxhZ3MsICVlZHgK

--0__=C6BBE5A2DFFEA85A8f9e8a93df938690918cC6BBE5A2DFFEA85A--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
