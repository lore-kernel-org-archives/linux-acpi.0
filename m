From: Alexander Malysh <a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org>
Subject: [PATCH] Re: [BUG] acpi_hw_[enable|disable]_non_wakeup_gpe_block
Date: Sun, 15 Feb 2004 16:47:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402151647.21826.a.malysh@centrium.de>
References: <200402142317.41033.a.malysh@centrium.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JS5LAzL+yZrhBZU"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200402142317.41033.a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_JS5LAzL+yZrhBZU
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,

after some more testing, I have found a cause for this.
We disable non wakeup gpes (and store those values) with interrupts disabled, 
but enable those with interrupts enabled which were already overwritten while 
handling of wakeup interrupt[1]. So we must restore non wakeup gpes as long 
interrupts are disabled. Attached patch should fix it.

P.S. With patch attached sleep button works after S1 resume...

[1] Debug log w/o a patch:
Feb 15 15:49:24 rose kernel: acpi_enter_sleep_state
Feb 15 15:49:24 rose kernel: 
acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef335c8) 
gpe_register_info(0xcefec548) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1022 gpe_register_info->enable=0x11
Feb 15 15:49:24 rose kernel: 
acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef335c8) 
gpe_register_info(0xcefec564) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1023 gpe_register_info->enable=0x5d
Feb 15 15:49:24 rose kernel: 
acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef33568) 
gpe_register_info(0xcefec4c8) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1032 gpe_register_info->enable=0x0
Feb 15 15:49:24 rose kernel: 
acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef33568) 
gpe_register_info(0xcefec4e4) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1033 gpe_register_info->enable=0x0
Feb 15 15:49:24 rose kernel: Back to C!
Feb 15 15:49:24 rose kernel:  evevent-0229 [20] ev_fixed_event_detect : Fixed 
Event Block: Enable 00000120 Status 00008100
Feb 15 15:49:24 rose kernel:    evgpe-0191 [20] ev_gpe_detect         : GPE 
pair: Status 0000000000001020 = 80, Enable 0000000000001022 = 00
Feb 15 15:49:24 rose kernel:    evgpe-0191 [20] ev_gpe_detect         : GPE 
pair: Status 0000000000001021 = 00, Enable 0000000000001023 = 00
Feb 15 15:49:24 rose kernel:    evgpe-0191 [20] ev_gpe_detect         : GPE 
pair: Status 0000000000001030 = F8, Enable 0000000000001032 = 00
Feb 15 15:49:24 rose kernel:    evgpe-0191 [20] ev_gpe_detect         : GPE 
pair: Status 0000000000001031 = A7, Enable 0000000000001033 = 00
Feb 15 15:49:24 rose kernel: acpi_leave_sleep_state
acpi_hw_enable_non_wakeup_gpe_block:gpe_block(0xcef335c8) 
gpe_register_info(0xcefec548) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1022 gpe_register_info->enable=0x0
Feb 15 15:49:24 rose kernel: 
acpi_hw_enable_non_wakeup_gpe_block:gpe_block(0xcef335c8) 
gpe_register_info(0xcefec564) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1023 gpe_register_info->enable=0x0


On Saturday 14 February 2004 23:17, Alexander Malysh wrote:
> Hi all,
>
> I have found a bug? in linux acpi that values within gpe_register_info are
> overwritten. Please see these values (note: only system_io gpe_register
> were dumped):
>
> 	1) system go into S1
> Feb 14 23:01:08 rose kernel:
> acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef335c8)
> gpe_register_info(0xcefec548) gpe_register_info->wake_enable=0x0
> gpe_register_info->enable_address=0x1022 gpe_register_info->enable=0x11
> Feb 14 23:01:08 rose kernel:
> acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef335c8)
> gpe_register_info(0xcefec564) gpe_register_info->wake_enable=0x0
> gpe_register_info->enable_address=0x1023 gpe_register_info->enable=0x5d
> Feb 14 23:01:08 rose kernel:
> acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef33568)
> gpe_register_info(0xcefec4c8) gpe_register_info->wake_enable=0x0
> gpe_register_info->enable_address=0x1032 gpe_register_info->enable=0x0
> Feb 14 23:01:08 rose kernel:
> acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef33568)
> gpe_register_info(0xcefec4e4) gpe_register_info->wake_enable=0x0
> gpe_register_info->enable_address=0x1033 gpe_register_info->enable=0x0
>
> 	2) system wakeup
> Feb 14 23:01:08 rose kernel:
> acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef335c8)
> gpe_register_info(0xcefec548) gpe_register_info->wake_enable=0x0
> gpe_register_info->enable_address=0x1022 gpe_register_info->enable=0x0
> Feb 14 23:01:08 rose kernel:
> acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef335c8)
> gpe_register_info(0xcefec564) gpe_register_info->wake_enable=0x0
> gpe_register_info->enable_address=0x1023 gpe_register_info->enable=0x0
> Feb 14 23:01:08 rose kernel:
> acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef33568)
> gpe_register_info(0xcefec4c8) gpe_register_info->wake_enable=0x0
> gpe_register_info->enable_address=0x1032 gpe_register_info->enable=0x0
> Feb 14 23:01:08 rose kernel:
> acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef33568)
> gpe_register_info(0xcefec4e4) gpe_register_info->wake_enable=0x0
> gpe_register_info->enable_address=0x1033 gpe_register_info->enable=0x0
>
> As you can see, io_addr 0x1022 and 0x1023 were restored with wrong values.
>
> any thoughts or patches to try?

-- 
Please avoid sending me Word, Excel or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

--Boundary-00=_JS5LAzL+yZrhBZU
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="acpi_hw_enable_non_wakeup_gpes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi_hw_enable_non_wakeup_gpes.diff"

--- linux-2.6.2-linus/drivers/acpi/hardware/hwsleep.c~orig	2004-02-15 16:31:50.928455040 +0100
+++ linux-2.6.2-linus/drivers/acpi/hardware/hwsleep.c	2004-02-15 16:35:30.030146520 +0100
@@ -342,6 +342,12 @@
 
 	} while (!in_value);
 
+	/* Enable non_wakeup_gpes as long interrupts are disabled */
+	status = acpi_hw_enable_non_wakeup_gpes ();
+	if (ACPI_FAILURE (status)) {
+		return_ACPI_STATUS (status);
+	}
+
 	return_ACPI_STATUS (AE_OK);
 }
 
@@ -496,11 +502,6 @@
 
 	/* _WAK returns stuff - do we want to look at it? */
 
-	status = acpi_hw_enable_non_wakeup_gpes ();
-	if (ACPI_FAILURE (status)) {
-		return_ACPI_STATUS (status);
-	}
-
 	/* Enable BM arbitration */
 
 	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);

--Boundary-00=_JS5LAzL+yZrhBZU--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
