From: Jan De Luyck <lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org>
Subject: Badness in remove_proc_entry  when 'rmmod battery'
Date: Mon, 17 May 2004 08:54:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405170854.14987.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This showed up in my logs today when rmmod'ing the battery module:

Badness in remove_proc_entry at fs/proc/generic.c:685
Call Trace:
 [<c017964a>] remove_proc_entry+0x10a/0x150
 [<e1a09a4d>] acpi_battery_remove_fs+0x1d/0x2d [battery]
 [<e1a09bc5>] acpi_battery_remove+0x32/0x41 [battery]
 [<c02674d5>] acpi_driver_detach+0x39/0x7c
 [<c0267589>] acpi_bus_unregister_driver+0x12/0x51
 [<e1a09bde>] acpi_battery_exit+0xa/0x1e [battery]
 [<c012bace>] sys_delete_module+0x13e/0x180
 [<c014063a>] do_munmap+0x14a/0x190
 [<c010411b>] syscall_call+0x7/0xb

Badness in remove_proc_entry at fs/proc/generic.c:685
Call Trace:
 [<c017964a>] remove_proc_entry+0x10a/0x150
 [<e1a09a4d>] acpi_battery_remove_fs+0x1d/0x2d [battery]
 [<e1a09bc5>] acpi_battery_remove+0x32/0x41 [battery]
 [<c02674d5>] acpi_driver_detach+0x39/0x7c
 [<c0267589>] acpi_bus_unregister_driver+0x12/0x51
 [<e1a09bde>] acpi_battery_exit+0xa/0x1e [battery]
 [<c012bace>] sys_delete_module+0x13e/0x180
 [<c014063a>] do_munmap+0x14a/0x190
 [<c010411b>] syscall_call+0x7/0xb

Jan

-- 
Bennett's Laws of Horticulture:
	(1) Houses are for people to live in.
	(2) Gardens are for plants to live in.
	(3) There is no such thing as a houseplant.


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
