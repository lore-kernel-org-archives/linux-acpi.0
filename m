From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: b44 -- Re: No network after S3
Date: 24 Feb 2004 17:00:24 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077660024.3036.56.camel@dhcppc4>
References: <BF1FE1855350A0479097B3A0D2A80EE0025A6344@hdsmsx402.hd.intel.com>
	 <1077000806.2515.46.camel@dhcppc4> <200402170856.42059.t.zachmann@zagge.de>
	 <200402240741.30530.t.zachmann@zagge.de>  <1077640877.5369.12.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1077640877.5369.12.camel-0dCjsm2Eg2I@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Peter Meier <crazy-b-Mmb7MZpHnFY@public.gmane.org>
Cc: Thorsten Zachmann <t.zachmann-c61pB8mzqkY@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, pp-YuCZbdju05vHOG6cAo2yLw@public.gmane.org, davem-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-02-24 at 11:41, Peter Meier wrote:
> <snip>
> 
> I'm having the same problem that my network is dead after I resume
> from
> S3, but I'm getting some kind of (maybe?) helpfull error message:
> 
> b44: eth0: BUG!  Timeout waiting for bit 80000000 of register 428 to
> clear.
> b44: eth0: BUG!  Timeout waiting for bit 80000000 of register 428 to
> clear.

from b44.h:

#define B44_CAM_CTRL    0x0428UL /* EMAC CAM Control */
#define  CAM_CTRL_BUSY          0x80000000 /* CAM Busy */

looks like this bit is polled after writing to the CAM.
I have no idea what would cause the CAM busy bit to stay set forever.

> I can rmmod b44 then, and modprobe it again, which leads to the
> following:
> 
> b44.c:v0.92 (Nov 4, 2003)
> PCI: Enabling device 0000:02:02.0 (0000 -> 0002)
> PCI: Setting latency timer of device 0000:02:02.0 to 64
> eh0: Broadcom 4400 10/100BaseT Ethernet ff:ff:ff:ff:ff:ff
> eth0: PHY Reset would not complete.
> b44: eth0: BUG!  Timeout waiting for bit 80000000 of register 428 to
> clear. (several times)
> 
> So, somehow, the MAC address is incorrect. I can ping my local IP
> address, but nothing else. There is no way to get the network card
> back
> to live, except rebooting. If I rmmod b44 *before* going to sleep, and
> modprobing it after I resume, I'm getting the same faulty MAC address
> and no network.

apparently, the hardware is in a broken state, and re-loading the driver
doesn't seem to clear it.

It would be interesting to know if you can unload the driver before
going to S3, and then load it after resuming from S3.  ie. can the b44
hardware survive the S3 transition if it is quiescent?

> Kernel is 2.6.3-mm3; I have IO-APIC enabled. cat /proc/interrupts
> gives
> me the idea that the network card uses PIC.

system will be in XT-PIC mode or IO-APIC mode -- can't be both.  I
assume that /proc/interrupts shows this device receiving no interrupts
after the S3 resume?

thanks,
-Len





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
