From: =?iso-8859-1?q?Praveen=20C?= <cpravn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi on r40e
Date: Sat, 21 Feb 2004 13:26:45 +0000 (GMT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040221132645.2884.qmail@web14521.mail.yahoo.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0025A6413@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0025A6413-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello
I have discovered some more info regarding the problems with processor
and thermal modules on R40e. It looks like there is some problem with
processor module and IDE. When I boot kernel 2.6.2 with all acpi
modules inbuilt into the kernel, then the machine hangs while executing
drivers/ide/ide-disk.c

in function idedisk_check_hpa (This checks if the machine has a host
protected area, which is present on r40e)
-----------------------------------------------------------------------------------------------
if(lba48)
        set_max = idedisk_read_native_max_address_ext(drive);
else
        //control reaches here
        set_max = idedisk_read_native_max_address(drive);
        // HANGS, DOES NOT COME OUT OF ABOVE FUNCTION

if(set_max <= capacity)
   return;

printk(KERN_INFO "%s: Host protected area ..........
-----------------------------------------------------------------------------------------------

WIth acpi inbuilt, I see in the boot messages that processor modules
loads and says 8 throttling states found, thermal loads and displays
current temperature; then the ide is probed and it hangs in the
position I indicated above.

If I build the acpi stuff as modules, and try to load them (modprobe)
after full boot, then the machine hangs if I try to modprobe processor
module. I dont get any messages in the log because the processor module
seems to be doing something to IDE.

Can you please tell me what the processor module is doing to IDE ? 
praveen

=====
http://www.cpraveen.tk/

________________________________________________________________________
Yahoo! India Insurance Special: Be informed on the best policies, services, tools and more. 
Go to: http://in.insurance.yahoo.com/licspecial/index.html


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
