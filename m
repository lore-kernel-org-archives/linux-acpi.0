From: Peter Meier <crazy-b-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: b44 -- Re: No network after S3
Date: Thu, 26 Feb 2004 16:48:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077810525.5332.51.camel@homer>
References: <BF1FE1855350A0479097B3A0D2A80EE0025A6344@hdsmsx402.hd.intel.com>
	 <1077000806.2515.46.camel@dhcppc4> <200402170856.42059.t.zachmann@zagge.de>
	 <200402240741.30530.t.zachmann@zagge.de> <1077640877.5369.12.camel@homer>
	 <1077660024.3036.56.camel@dhcppc4>  <20040224223421.GA6225@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040224223421.GA6225-YuCZbdju05vHOG6cAo2yLw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pekka Pietikainen <pp-YuCZbdju05vHOG6cAo2yLw@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, davem-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

that fix didnt work for me. Here is what I did:
I downloaded the broadcom driver 3.0.7 and installed the modules. I
rebootet, put the machine to sleep, and got follwing error message after
wake-up:

ASSERT failed: b44_LM_sb_coreid(pDevice) == SB_PCI
ASSERT failed: b44_LM_sb_coreid(pDevice) == SB_PCI
SBTMH_SERR; clearing...
ASSERT failed: 0
ASSERT failed: 0

Then, I rebootet, rmmod the driver before going to sleep, and modprobed
it after wake-up. Leads to follwing error message:

Broadcom 4401 Ethernet Driver bcm4400 ver. 3.0.7 (10/31/03)
PCI: Enabling device 0000:02:02.0 (0000 -> 0002)
PCI: Setting latency timer of device 0000:02:02.0 to 64
Get Adapter info failed

I then changed the line 417 in b44lm.c as suggested in bug id 2030.
Still, nothing changed. After playing around, I finally decied to get
back to my "normal" b44 - and had that bug described. Booting into XP
didnt help, and your "fix" described didnt work, too. Only thing that
solved the problem was disconnecting power and shutdown the system.

On Tue, 2004-02-24 at 23:34, Pekka Pietikainen wrote:
> I was recently able to reproduce a bug that sounds related, 
> http://bugme.osdl.org/show_bug.cgi?id=2030 has the details.
> Would be interesting to know whether the "fix" I found (running 
> _only_ the initialization part of the bcm4400 driver) helps in this case too.
> 
> Broadcoms changelog provides some clues about what kind of access patters
> make the chip break.
> 
> Current guesses are ssb_* (maybe ssb_is_core_up returning 1 
> even when it isn't leading to ssb_pci_setup not getting called)
> and b44_setup_phy (where the register access pattern differs slightly).
> It didn't work even after altering the register access patterns to be ~= 
> identical, making sure ssb_pci_setup gets run etc., alas, but I 
> probably missed something.
> 
> Anyway, I'm working on it, but no guarantees on when I'll find the time to
> nail it down.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
