From: Alexander Malysh <a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org>
Subject: [BUG] acpi_hw_[enable|disable]_non_wakeup_gpe_block
Date: Sat, 14 Feb 2004 23:17:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402142317.41033.a.malysh@centrium.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi all,

I have found a bug? in linux acpi that values within gpe_register_info are 
overwritten. Please see these values (note: only system_io gpe_register were 
dumped):

	1) system go into S1
Feb 14 23:01:08 rose kernel: 
acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef335c8) 
gpe_register_info(0xcefec548) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1022 gpe_register_info->enable=0x11
Feb 14 23:01:08 rose kernel: 
acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef335c8) 
gpe_register_info(0xcefec564) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1023 gpe_register_info->enable=0x5d
Feb 14 23:01:08 rose kernel: 
acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef33568) 
gpe_register_info(0xcefec4c8) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1032 gpe_register_info->enable=0x0
Feb 14 23:01:08 rose kernel: 
acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef33568) 
gpe_register_info(0xcefec4e4) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1033 gpe_register_info->enable=0x0

	2) system wakeup
Feb 14 23:01:08 rose kernel: 
acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef335c8) 
gpe_register_info(0xcefec548) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1022 gpe_register_info->enable=0x0
Feb 14 23:01:08 rose kernel: 
acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef335c8) 
gpe_register_info(0xcefec564) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1023 gpe_register_info->enable=0x0
Feb 14 23:01:08 rose kernel: 
acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef33568) 
gpe_register_info(0xcefec4c8) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1032 gpe_register_info->enable=0x0
Feb 14 23:01:08 rose kernel: 
acpi_hw_disable_non_wakeup_gpe_block:gpe_block(0xcef33568) 
gpe_register_info(0xcefec4e4) gpe_register_info->wake_enable=0x0 
gpe_register_info->enable_address=0x1033 gpe_register_info->enable=0x0

As you can see, io_addr 0x1022 and 0x1023 were restored with wrong values.

any thoughts or patches to try?

-- 
Please avoid sending me Word, Excel or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
