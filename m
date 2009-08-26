From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: PME# for add-on cards
Date: Wed, 26 Aug 2009 15:50:00 +0300
Message-ID: <1251291000.1791.7.camel@maxim-laptop>
References: <200908240112.39424.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:33169 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932858AbZHZMuF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Aug 2009 08:50:05 -0400
In-Reply-To: <200908240112.39424.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Len Brown <lenb@kernel.org>

On Mon, 2009-08-24 at 01:12 +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> Recently we've had a bug report indicating that WoL doesn't work with e100,
> although the driver does everything needed to support it.  Apparently, the user
> had to echo PCI0 to /proc/acpi/wakeup to make it work.
> 
> After some debugging it turned out that PCI0 is the PCI host bridge
> (no-bus:pci0000:00), so apparently echoing PCI0 to /proc/acpi/wakeup causes
> a wake-up GPE to be set up for the host bridge which triggers wake-up once
> eth0 signals PME#.
> 
> So, it looks like we need to set up wake-up GPE for a host bridge for PME#
> from add-on cards to work, at least on this particular box.
> 
> First, I wonder if that's the case in general (anybody knows?).  Second, if
> that is the case, would it be a good idea to set up the host bridge wake-up GPE
> by default?
> 
> Rafael
>  

This is very known problem (at least for me)

On my desktop, /proc/acpi/wakeup controls all the wakeup sources, and if
disabled, nether addon cards (ethernet) nor internal devices
(usb,ethernet) will wake up the system.

I think that proc/acpi/wakeup should be synced with power/wakeup
attribute.

Also, I would be really happy to see bogus (empty) power/wakeup
attributes be gone.

Also, something is broken in regards to PME from addon cards:
http://www.spinics.net/lists/netdev/msg104460.html


Best regards,
	Maxim Levitsky



