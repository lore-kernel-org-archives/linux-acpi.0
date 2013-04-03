From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Wed, 3 Apr 2013 10:04:16 +0800
Message-ID: <CAC=cRTP+VHZrzELDgJTZw6hykPD4FR9xzB2BR2TwCUcPGCmGsg@mail.gmail.com>
References: <2282655.IicBMMa6jN@vostro.rjw.lan>
	<CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com>
	<51548C9E.9090703@fold.natur.cuni.cz>
	<2990024.LMTIBUbM3d@vostro.rjw.lan>
	<51564804.9000700@fold.natur.cuni.cz>
	<CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com>
	<515AF312.1010507@fold.natur.cuni.cz>
	<CAErSpo6EAkSniVF7NnDVsR=H_x0dHK=xQNbdKf67WDW=o1D+_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:50815 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760246Ab3DCCES (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Apr 2013 22:04:18 -0400
Received: by mail-bk0-f53.google.com with SMTP id e19so509096bku.40
        for <linux-acpi@vger.kernel.org>; Tue, 02 Apr 2013 19:04:16 -0700 (PDT)
In-Reply-To: <CAErSpo6EAkSniVF7NnDVsR=H_x0dHK=xQNbdKf67WDW=o1D+_Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

On Wed, Apr 3, 2013 at 12:30 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Apr 2, 2013 at 9:02 AM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
>> Hi Ying,
>>
>> huang ying wrote:
>
>>> And please give me the full dmesg for boot and incremental dmesg for
>>> operations.
>>
>>
>> The incremental bits here, the full dmesg will send only directly to your email, due to its size.
>
> Is there a bugzilla for this issue?  Please attach the complete dmesg
> there or somewhere similar so we can all benefit.
>
> I think we have two problems that may be relevant to this discussion.
>
> 1) The _OSC "PCI Express Capability Structure control" bit.  I don't
> think Linux pays attention to whether the BIOS has granted us control
> over the capability, so we may do things to it that the BIOS doesn't
> expect.
>
> 2) acpiphp currently uses the presence of _ADR/_EJ0/_RMV to detect
> hotplug slots.  I don't think this is sufficient (see
> https://bugzilla.kernel.org/show_bug.cgi?id=54981 for details).
> Therefore, I don't think pci_bus_has_hotplug_slots() in port_dbg.patch
> can be accurate.  I think it returns "false" for some buses where it
> should return "true," such as the ExpressCard slot on Chris Clayton's
> system (see bug 54981).

Yes. pci_bus_has_hotplug_slots() is not accurate.  But I still think
it can be used in port runtime PM.  Because if there is no hotplug
slots registered, the hotplug itself can not work properly, with or
without port runtime PM enabled.  And we should add necessary
pm_runtime_get_sync/put_sync into pci_scan_bus to deal with "rescan".
What do you think about that?

pci_dev->is_hotplug_bridge is not accurate too.  It reports a internal
port of my X220 as a hotplug-able port.  But it appears that it will
report more instead of less.  It can report correctly for port in bug
54981.  Do you think that is a good choice for port runtime PM
filtering?

Best Regards,
Huang Ying
