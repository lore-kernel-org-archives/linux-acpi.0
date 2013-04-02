From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Tue, 2 Apr 2013 10:30:54 -0600
Message-ID: <CAErSpo6EAkSniVF7NnDVsR=H_x0dHK=xQNbdKf67WDW=o1D+_Q@mail.gmail.com>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com>
 <51548C9E.9090703@fold.natur.cuni.cz> <2990024.LMTIBUbM3d@vostro.rjw.lan>
 <51564804.9000700@fold.natur.cuni.cz> <CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com>
 <515AF312.1010507@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:41059 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758858Ab3DBQbP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Apr 2013 12:31:15 -0400
Received: by mail-ob0-f169.google.com with SMTP id oi10so545302obb.0
        for <linux-acpi@vger.kernel.org>; Tue, 02 Apr 2013 09:31:14 -0700 (PDT)
In-Reply-To: <515AF312.1010507@fold.natur.cuni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: huang ying <huang.ying.caritas@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

On Tue, Apr 2, 2013 at 9:02 AM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> Hi Ying,
>
> huang ying wrote:

>> And please give me the full dmesg for boot and incremental dmesg for
>> operations.
>
>
> The incremental bits here, the full dmesg will send only directly to your email, due to its size.

Is there a bugzilla for this issue?  Please attach the complete dmesg
there or somewhere similar so we can all benefit.

I think we have two problems that may be relevant to this discussion.

1) The _OSC "PCI Express Capability Structure control" bit.  I don't
think Linux pays attention to whether the BIOS has granted us control
over the capability, so we may do things to it that the BIOS doesn't
expect.

2) acpiphp currently uses the presence of _ADR/_EJ0/_RMV to detect
hotplug slots.  I don't think this is sufficient (see
https://bugzilla.kernel.org/show_bug.cgi?id=54981 for details).
Therefore, I don't think pci_bus_has_hotplug_slots() in port_dbg.patch
can be accurate.  I think it returns "false" for some buses where it
should return "true," such as the ExpressCard slot on Chris Clayton's
system (see bug 54981).

Bjorn
