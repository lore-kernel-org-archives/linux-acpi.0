From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: S3 suspend no longer works with 2.6.0-test3
Date: Sun, 10 Aug 2003 22:58:08 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1060549076.742.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

the system is Sony Vaio Z600TEK. Since 2.6.0-test3 the kernel locks when
suspending to S3 via echo 3 > /proc/acpi/sleep. Console then shows:

hda: start_power_step (Step: 0)
hda: start_power_step (Step: 1)
hda: complete_power_step (step: 1, stat: 50, err: 0)
hda: completing PM request, suspend

Thats it. I put a dump_stack () into ide_complete_pm_request and got the
following:

[<c02762d9>] ide_complete_pm_request +0x39/0x240
[<c027dd0c>] task_no_data_intr +0xac/0xc0
[<c0278643>] ide_intr 0x2c3/0x5d0
[<c011321c>] timer_interrupt +0x8c/0x260
[<c0131126>] update_process_times +0x46/0x50
[<c027dc60>] task_no_data_intr +0x0/0xc0
[<c010cbcb>] handle_IRQ_even +0x3b/0x70
[<c010d1e0>] do_IRQ +0x140/0x3a0

With some printks I found that it does return from the first three, but
I could not trace it further. Especially I can not see it returning from
the second task_no_data_intr...but to be honest I have no further idea
where to look at. 

Can anyone else observe this?

-Knut

-- 
Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Physikalische Grundpraktika - Heinrich-Heine Universitaet Duesseldorf
Raum 25.33.01.63  -   Universitaetsstrasse 1   -  D-40225 Duesseldorf
fon: +49-211-81-11314                           fax: +49-211-81-13105











-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
