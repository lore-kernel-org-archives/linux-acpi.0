From: Yaroslav Rastrigin <yarick-343whMTK1pU@public.gmane.org>
Subject: ACPI and 3c556 - another attempt to get some help
Date: Sun, 13 Jul 2003 17:45:11 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F116267.1000504@relex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi everybody once again .

I've posted my problem here some time ago, but nobody was able to help, 
maybe,because I haven't provided enough info. I'm returning to this problem 
from time to time,with different results. So, another attempt:

First, I have some more questions:
1. How could I correlate device with it's respective description in DSDT ?
ACPI spec says it must be done via _ADR or _HID. How could I obtain _HID for 
particular device (the device in question is MiniPCI 3c556 network card). What 
kind of _ADR could I expect from MiniPCI devices ? Will it be just like 
ordinary PCI devices ("%04X04X", device, function), or something different ? 
I'm seeing _ADRs for every other PCI devices on this machine, except sound 
device (CS46XX) and MiniPCI's, modem and NIC. Is it correct ?
2. Looking at lspci outputs , I've noticed that the only device who's settings 
  are changed between boots with acpi and acpi=off is this NIC. Does it means 
it's _STA or _INI is just plain wrong in DSTD ? (WinXP works fine, however, 
could it be that DSDT is specifically tuned for Windows ? (I've found various 
codepaths for specific "optimisations" for various MS OS'es, but using 
acpi_os_name="Some MS Product" gave me nothing (useful)).
3. Could it be that this device description is simply missing from DSDT ? What 
will ACPI do when undescribed device is found ? Will ACPI attempt to manage it 
? Could I remove device completely from DSDT and hope it's configuration will 
remain unchanged from BIOS POST settings ?

Well, and one more question:
what should I do now ? Right now I'm working with acpi=off, but acpi gives me
lots of advantages in control of my machine. On which ml should I ask ?
Where to dig ?

All data gathered uptodate could be found at:
http://www.relex.ru/~yarick/acpi

With all the best, yarick at relex dot ru



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
