From: trooper ryan <trooper_ryan-QPf0Bz723pkjHdulDSg1yw@public.gmane.org>
Subject: Re: PCI: Cannot allocate resource region 0 of device 0000:00:0d.0
Date: Sun, 25 Apr 2004 16:20:01 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <408BE531.8080503@dmtsystems.net>
References: <408A85DE.8090700@dmtsystems.net> <20040424125753.GJ22558@parcelfarce.linux.theplanet.co.uk> <408AF79C.1050804@dmtsystems.net> <20040424150533.GL22558@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040424150533.GL22558-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The card does work on an XP box I have, so I suspect it might be the PCI 
  riser card I'm using to slot it in to a 1RU box.  I'll try and locate 
another PCI riser to use and let you know how I go.

Thanks for all your help!



Matthew Wilcox wrote:
> On Sat, Apr 24, 2004 at 11:26:20PM +0000, trooper ryan wrote:
> 
>>Anyhow, the info you requested:
>># setpci -s 00:0d.0 BASE_ADDRESS_0=ffffffff
>>setpci -s 00:0d.0 BASE_ADDRESS_0 returns 00d7f008 sometimes and ffffffff 
>>others.
> 
> 
> This is quite suspicious.  ffffffff would indicate this device is not
> connected to the bus [1] .  The other value returned indicates it's a
> 32-bit BAR (entirely plausible) which is prefetchable (seems kosher for
> a video capture card).  The base address would then be 0x00d7f000 which
> is slightly under the 16MB boundary.  Very curious as this is normally
> assigned to system RAM.
> 
> All in all, this looks like a pretty broken piece of hardware to me.
> Possibly something else is going on to cause this, like the system being
> over its power-budget.  I advide you to treat this as a hardware problem
> and try doing some things to narrow it down, like taking all other cards
> out of the machine and seeing if the problem persists; try the card in
> a different slot; check the card connectors for damage, etc.
> 
> It'd also be worth trying a different OS with it, just to be sure it's
> a hardware problem ;-)
> 
> [1] Due to how PCI BARs work, there must be at least one bit clear.
> If it's a memory BAR, bit 0 must be clear, and if it's a port BAR, bit 1
> must be 0.  If there's no reponse from a device, the PCI bus floats high,
> so you get back 0xffffffff.  When you write 0xffffffff to a BAR, the device
> ignores the bits that are less than the size of the aperture so when you
> read it back, you should get only the implemented bits set.
> 


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
