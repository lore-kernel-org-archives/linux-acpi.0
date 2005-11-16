From: Nishanth Aravamudan <nacc-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: [UPDATE PATCH] acpi/video: check brightness is non-NULL before writing
Date: Wed, 16 Nov 2005 12:43:39 -0800
Message-ID: <20051116204339.GK3122@us.ibm.com>
References: <20050912184401.GC25471@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050912184401.GC25471-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 12.09.2005 [11:44:01 -0700], Nishanth Aravamudan wrote:
> Hi Len, acpi-devel,
> 
> An easy to reproduce oops:
> 
> if
> 
> cat /proc/acpi/video/VID/LCD0/brightness
> 
> reports <not supported>
> 
> and then one does
> 
> echo 1 > /proc/acpi/video/VID/LCD0/brightness
> 
> the following oops will occur every time.
> 
> Sep 12 11:39:27 joust kernel: [4606058.981000]  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
> Sep 12 11:39:27 joust kernel: [4606313.261000] c024a542
> Sep 12 11:39:27 joust kernel: [4606313.261000] PREEMPT 
> Sep 12 11:39:27 joust kernel: [4606313.261000] Modules linked in: dummy wlan_wep ath_pci ath_rate_sample wlan ath_hal
> Sep 12 11:39:27 joust kernel: [4606313.261000] CPU:    0
> Sep 12 11:39:27 joust kernel: [4606313.261000] EIP:    0060:[acpi_video_device_write_brightness+91/140]    Tainted: P      VLI
> Sep 12 11:39:27 joust kernel: [4606313.261000] EFLAGS: 00010246   (2.6.13) 
> Sep 12 11:39:27 joust kernel: [4606313.261000] EIP is at acpi_video_device_write_brightness+0x5b/0x8c
> Sep 12 11:39:27 joust kernel: [4606313.261000] eax: 00000001   ebx: 00000001   ecx: 00000000   edx: 00000000
> Sep 12 11:39:27 joust kernel: [4606313.261000] esi: c1b62ec0   edi: 00000002   ebp: de191f74   esp: de191f64
> Sep 12 11:39:27 joust kernel: [4606313.261000] ds: 007b   es: 007b   ss: 0068
> Sep 12 11:39:27 joust kernel: [4606313.261000] Process bash (pid: 406, threadinfo=de190000 task=e3012a80)
> Sep 12 11:39:27 joust kernel: [4606313.261000] Stack: 00000a31 c050e8e0 ea258e80 080eec08 de191f94 c015ff6c de191fa0 c050e8e0 
> Sep 12 11:39:27 joust kernel: [4606313.261000]        00000000 ea258e80 fffffff7 080eec08 de191fb4 c01600d1 de191fa0 00000000 
> Sep 12 11:39:27 joust kernel: [4606313.261000]        00000000 00000000 00000001 00000002 de190000 c0103165 00000001 080eec08 
> Sep 12 11:39:27 joust kernel: [4606313.261000] Call Trace:
> Sep 12 11:39:27 joust kernel: [4606313.261000]  [show_stack+122/144] show_stack+0x7a/0x90
> Sep 12 11:39:27 joust kernel: [4606313.261000]  [show_registers+342/448] show_registers+0x156/0x1c0
> Sep 12 11:39:27 joust kernel: [4606313.261000]  [die+224/368] die+0xe0/0x170
> Sep 12 11:39:27 joust kernel: [4606313.261000]  [do_page_fault+831/1674] do_page_fault+0x33f/0x68a
> Sep 12 11:39:27 joust kernel: [4606313.261000]  [error_code+79/84] error_code+0x4f/0x54
> Sep 12 11:39:27 joust kernel: [4606313.261000]  [vfs_write+172/352] vfs_write+0xac/0x160
> Sep 12 11:39:27 joust kernel: [4606313.261000]  [sys_write+65/112] sys_write+0x41/0x70
> Sep 12 11:39:27 joust kernel: [4606313.261000]  [syscall_call+7/11] syscall_call+0x7/0xb
> Sep 12 11:39:27 joust kernel: [4606313.261000] Code: ff 85 c0 b9 f2 ff ff ff 75 4a 8d 45 f0 31 c9 31 d2 c6 04 07 00 e8 9f 29 fd ff 83 f8 64 89 c3 b9 f2 ff ff ff 77 2e 8b 56 1c 31 c9 <3b> 4a 04 7d 22 8b 42 08 3b 1c 88 75 14 89 da 89 f0 e8 51 f8 ff 
> 
> The following patch fixes the issue for me.

Haven't heard anything for the past few months.  Here's an updated patch
for 2.6.15-rc1.

Thanks,
Nish

Description: acpi_video_device_brightness_seq_show() checks for both dev
and dev->brightness to be non-NULL, but
acpi_video_device_write_brightness() only checks if dev is non-NULL,
leading to an easily reproducible oops. Checking for dev->brightness in
the write routine fixes the problem.

Signed-off-by: Nishanth Aravamudan <nacc-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

---

 drivers/acpi/video.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN 2.6.15-rc1/drivers/acpi/video.c 2.6.15-rc1-dev/drivers/acpi/video.c
--- 2.6.15-rc1/drivers/acpi/video.c	2005-11-11 20:32:50.000000000 -0800
+++ 2.6.15-rc1-dev/drivers/acpi/video.c	2005-11-16 12:40:42.000000000 -0800
@@ -812,7 +812,7 @@ acpi_video_device_write_brightness(struc
 
 	ACPI_FUNCTION_TRACE("acpi_video_device_write_brightness");
 
-	if (!dev || count + 1 > sizeof str)
+	if (!dev || !dev->brightness || count + 1 > sizeof str)
 		return_VALUE(-EINVAL);
 
 	if (copy_from_user(str, buffer, count))


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
