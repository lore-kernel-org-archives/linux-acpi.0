From: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] [suspend/resume] wrong wakeup address
Date: Sun, 17 Oct 2004 08:55:05 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OFBCE9478A.AFF06BED-ON49256F2F.0081C196-49256F2F.0082ED15@jp.ibm.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575546CFA@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	Boundary="0__=C6BBE5BCDF1247068f9e8a93df938690918cC6BBE5BCDF124706"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575546CFA-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--0__=C6BBE5BCDF1247068f9e8a93df938690918cC6BBE5BCDF124706
Content-type: text/plain; charset=US-ASCII





Hi, Shaohua-san,

I checked acpi_wakeup_address and
*acpi_gbl_common.fACS.firmware_waking_vector after virt_to_phys().
Both values are 0xC0002000 (width=32bit) on my ThinkPad. This means BIOS
must call the wakeup entry in big-real mode?

If so, the following comment in wakeup.S seems to be strange.
# If physical address of wakeup_code is 0x12345, BIOS should call us with
# cs = 0x1234, eip = 0x05

Hiroshi Itoh
hiroit-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org


                                                                           
             "Li, Shaohua"                                                 
             <shaohua.li@intel                                             
             .com>                                                      To 
             Sent by:                  <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>  
             acpi-devel-admin@                                          cc 
             lists.sourceforge         "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 
             .net                      "Pavel Machek" <pavel-+ZI9xUNit7I@public.gmane.org>       
                                                                   Subject 
                                       [ACPI] [PATCH] [suspend/resume]     
             2004/10/15 18:21          wrong wakeup address                
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




Hi,
acpi_wakeup_address is returned by 'alloc_bootmem_low', so it's a
virtual address, but 'acpi_set_firmware_wakeing_vector' requires a
physical address. But what makes me confused is my Toshiba works (S3)
with/without the patch. Hope this patch (against 2.6.9-rc4) fixes some
systems which can't resume.

Thanks,
Shaohua

Signed-off-by Li Shaohua <Shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

===== drivers/acpi/sleep/main.c 1.40 vs edited =====
--- 1.40/drivers/acpi/sleep/main.c         2004-08-17 23:15:34 +08:00
+++ edited/drivers/acpi/sleep/main.c             2004-10-15 16:58:33 +08:00
@@ -12,6 +12,7 @@
 #include <linux/irq.h>
 #include <linux/dmi.h>
 #include <linux/device.h>
+#include <asm/io.h>
 #include <linux/suspend.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -56,7 +57,8 @@ static int acpi_pm_prepare(u32 pm_state)
                         if (!acpi_wakeup_address)
                                     return -EFAULT;
                         acpi_set_firmware_waking_vector(
-                                    (acpi_physical_address)
acpi_wakeup_address);
+                                    (acpi_physical_address) virt_to_phys(
+                                    (void *)acpi_wakeup_address));
             }
             ACPI_FLUSH_CPU_CACHE();
             acpi_enable_wakeup_device_prep(acpi_state);
(See attached file: wakeup_addr.patch)
--0__=C6BBE5BCDF1247068f9e8a93df938690918cC6BBE5BCDF124706
Content-type: application/octet-stream;
	name="wakeup_addr.patch"
Content-Disposition: attachment; filename="wakeup_addr.patch"
Content-transfer-encoding: base64

PT09PT0gZHJpdmVycy9hY3BpL3NsZWVwL21haW4uYyAxLjQwIHZzIGVkaXRlZCA9PT09PQotLS0g
MS40MC9kcml2ZXJzL2FjcGkvc2xlZXAvbWFpbi5jCTIwMDQtMDgtMTcgMjM6MTU6MzQgKzA4OjAw
CisrKyBlZGl0ZWQvZHJpdmVycy9hY3BpL3NsZWVwL21haW4uYwkyMDA0LTEwLTE1IDE2OjU4OjMz
ICswODowMApAQCAtMTIsNiArMTIsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2lycS5oPgogI2luY2x1
ZGUgPGxpbnV4L2RtaS5oPgogI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgorI2luY2x1ZGUgPGFz
bS9pby5oPgogI2luY2x1ZGUgPGxpbnV4L3N1c3BlbmQuaD4KICNpbmNsdWRlIDxhY3BpL2FjcGlf
YnVzLmg+CiAjaW5jbHVkZSA8YWNwaS9hY3BpX2RyaXZlcnMuaD4KQEAgLTU2LDcgKzU3LDggQEAg
c3RhdGljIGludCBhY3BpX3BtX3ByZXBhcmUodTMyIHBtX3N0YXRlKQogCQlpZiAoIWFjcGlfd2Fr
ZXVwX2FkZHJlc3MpCiAJCQlyZXR1cm4gLUVGQVVMVDsKIAkJYWNwaV9zZXRfZmlybXdhcmVfd2Fr
aW5nX3ZlY3RvcigKLQkJCShhY3BpX3BoeXNpY2FsX2FkZHJlc3MpIGFjcGlfd2FrZXVwX2FkZHJl
c3MpOworCQkJKGFjcGlfcGh5c2ljYWxfYWRkcmVzcykgdmlydF90b19waHlzKAorCQkJKHZvaWQg
KilhY3BpX3dha2V1cF9hZGRyZXNzKSk7CiAJfQogCUFDUElfRkxVU0hfQ1BVX0NBQ0hFKCk7CiAJ
YWNwaV9lbmFibGVfd2FrZXVwX2RldmljZV9wcmVwKGFjcGlfc3RhdGUpOwo=

--0__=C6BBE5BCDF1247068f9e8a93df938690918cC6BBE5BCDF124706--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
