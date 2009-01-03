From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH 2.6.29] fujitsu-laptop: Add BL power, LED control and
Date: Sun, 4 Jan 2009 09:07:41 +1030 (CST)
Message-ID: <200901032237.n03MbfOf018915@mercury.physics.adelaide.edu.au>
References: <1230898211.9451.12.camel@earth.gruber.myown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:53331 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760185AbZACWiR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Jan 2009 17:38:17 -0500
In-Reply-To: <1230898211.9451.12.camel@earth.gruber.myown> from "nokos@gmx.net" at Jan 02, 2009 01:10:11 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: Tony Vroon <tony@linx.net>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Stephen Gildea <stepheng+linux@gildea.com>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org

Hi

> Tested it on the S6410, and works as expected

Thanks for confirming.

> perhaps we should shorten the driver name a little to make it a bit more
> inline with the other acpi drivers:
> # ls /sys/bus/acpi/drivers
> ac       container  Fujitsu laptop FUJ02B1 ACPI brightness driver
> pci_link processor  thermal
> battery  ec         Fujitsu laptop FUJ02E3 ACPI hotkeys driver
> pci_root sbs        video
> button   fan        hpet
> power    smbus_hc
> 
> What do you think?

I assume you're talking about the textual driver name as opposed to the
module name ("fujitsu-laptop").  I have no immediate thoughts regarding
this.  Personally I quite like the extended information the above output
gives since you're left in no doubt where the driver comes from.  Is there a
general convenction that the driver names reported in /sys/bus/acpi/drivers
are restricted to a single word?  If so I'm happy to do up a patch to
comply, but at the same time if there's no thought one way or the other then
perhaps the existing name could stay.

Having said that, there's probably no harm in dropping "FUJ02B1 ACPI" and
"FUJ02E3 ACPI".  The FUJ* isn't really interesting for most users, and
the fact that it's an ACPI driver is self-evident from other things.

Regards
  jonathan
