From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: PCI power state mapping
Date: Mon, 16 Aug 2004 11:04:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040816090436.GA2064@openzaurus.ucw.cz>
References: <410528F5.1060104@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <410528F5.1060104-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> As far as I know the kernel has three different power modes. The ACPI 
> ones (S0-S5), the linux ones (PM_SUSPEND_*) and the PCI ones (D0-D3). 
> Mapping between the first two is done by the ACPI routines. But 
> mapping between kernel power states and PCI is not done at all. The 
> PM-enumerations are propagated all the way down to 
> pci_set_power_state(). I.e. the function expects PCI states but gets 

I have patch that converts all this to enums, and introduces
to_pci_state() function. That should solve part of confusion.


> Now for the problem. Most PCI devices do not support state D1 and D2 
> (which would be called when entering PM_SUSPEND_STANDBY or 
> PM_SUSPEND_MEM). This causes the pci_set_power_state() to fail and 
> the suspend to be aborted. I haven't found any good documentation 
> about the PCI power states but from what I can gather D0 is full 
> power, D1-D2 are used during normal operation to conserve some power 
> (when the device is idle I guess) and D3 when it enters some form of 
> suspend. So PM_SUSPEND_MEM should probably put the devices in D3, not 
> D2. Microsoft seem to increase the state until it finds on the device 
> supports:

Okay, to_pci_state will have to be fixed.

> Windows has something called system-to-device (SxD) mapping which 
> seems to handle most of this. I can't find the equivalent in linux 
> ACPI implementation. To me, this looks like a rather crucial part of 
> the system.

Someone will need to write that one...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
