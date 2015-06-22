From: Gianluca Anzolin <gianluca@sottospazio.it>
Subject: Re: Debugging spurious wakeup
Date: Mon, 22 Jun 2015 21:48:55 +0200
Message-ID: <20150622194855.GA16269@sottospazio.it>
References: <20150513065825.GA10680@sottospazio.it>
 <20150620215441.GA32242@rhlx01.hs-esslingen.de>
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m-r2.th.seeweb.it ([5.144.164.171]:50619 "EHLO
	m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbbFVT4K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2015 15:56:10 -0400
Content-Disposition: inline
In-Reply-To: <20150620215441.GA32242@rhlx01.hs-esslingen.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

Hello,

On Sat, Jun 20, 2015 at 11:54:41PM +0200, Andreas Mohr wrote:
> Hi,
> 
> [managed to gather proper In-Reply-To from spinics.net
> rather than broken lkml.org]
> 
> I'm having a very similar issue with my PCI FireWire card:
> whenever shutting down or even suspending,
> I'm getting immediate spurious wakeup; currently most strongly suspecting
> Firewire PHY-related IRQ event wakeups.

I don't know if the issue is the same as mine. In that case it wouldn't
be driver related. As explained before, for me the spontaneous wakeups
occur after a Wake-on-Lan but not when powering up the system by other
means (i.e. power button).

As suggested I asked on netdev but got no reply at all, so I'm on my own
right now.

Thank you for sharing your experience, the document about GPE and PME
seems useful to pinpoint the issue: as explained in another email, I
found a difference in lspci when the undesired wakeup occurs and it
involves PME signals:

-		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
+		RootSta: PME ReqID 0400, PMEStatus- PMEPending-

The problem is, these difference is not related to the network PCI
device but to the PCI bridge behind which the network device sits.

If I find something useful (unlikely, but never lose the hope) I'll send
an update :)

Thank you,

Gianluca

> 
> I collected the following items so far:
> - asked for help (having the system properly record / retain the actual
>   reason for system-global wakeup):
>     "pm: record / retain actual reason of last system wakeup??"
>       https://lkml.org/lkml/2015/6/2/625
> - figured out that it can be silenced with *general* (ouch)
>   BIOS PCI wakeup disable, yet that if not disabled
>   (which is *very* desirable, obviously, to retain WOL capability etc.)
>   it's actually already in a broken state directly post-BIOS-init,
>   at LILO prompt (i.e., **NOT** in Linux, NOT a Linux driver issue!
>   However perhaps we *might* be able to do something about it in Linux...):
>     "fw-ohci: ALi M52xx unsupported"
>       https://bugzilla.kernel.org/show_bug.cgi?id=10935
>     (contains reference to http://www.tonymacx86.com/general-help/65531-gigabyte-uefi-bios-startech-firewire-pcie-card-sleep-wake-shutdown-restart-issues-thread-8.html
>     where tons of people have issues with various FireWire cards -
>     so it seems that this is an issue that's pretty much inherent
>     to / associated with FireWire hardware behaviour)
> - found 074_GPE_Routing.doc which explains these GPE / PME things
>   (this *is* the stuff that's broken/problematic here, right??)
>   in pretty detailed form
> - "Re: PME# for add-on cards"
>     http://markmail.org/message/7uuzqbtrpswzrezz
>   mentions that probably BIOS forgot to do PME masking
>   directly prior to activating hardware shutdown
>   (well, at least in my case, where wakeup happens completely instantly,
>   as opposed to your case where it will wakeup after a couple seconds)
> 
> No amount of fumbling (~1 hour) with CAP_PM register range
> (PME_EN etc.; "setpci -v -s ${dst} CAP_PM+4.b=XX")
> or e.g. setting the "remove" sysfs attribute of PCI (sub) devices
> (this would then be a nicely controlled i.e. fine-grained manner)
> so far managed to disable this behaviour.
> I suspect that we might be talking
> of simple complete signal level mal-functioning of the card
> irrespective of how it's actually configured
> to generate or not generate events...
> (shutdown --> power change --> floating signals on PME# --> wakeup)
> I also tried to completely mask all FireWire event types in driver-side
> suspend handler, with no success (but given that this is a combo card
> with various USB host controllers FireWire may not be the sub device to
> be blamed after all - here we are again at dearly needing
> system-provided information about the *maximally precise* reason
> of last wakeup - PME ReqID [not available on my Conventional PCI system]
> seems to be a prime candidate). But given that the Mac forum reports issues
> with many FireWire cards, faulty USB sub device seems less likely.
> 
> So, I'm still quite far from possibly(!) being able
> to create a device-specific PCI quirk entry (drivers/pci/quirks.c)
> or to create driver-side workarounds
> for FireWire cards which have this issue.
> 
> HTH,
> 
> Andreas Mohr
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
