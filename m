From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Mon, 25 Feb 2008 20:00:35 -0300
Message-ID: <20080225230035.GA14503@khazad-dum.debian.net>
References: <20080225093914.GB4375@ics.muni.cz> <200802251247.30605.rjw@sisk.pl> <20080225200354.GE16513@khazad-dum.debian.net> <20080225204951.GB4432@ics.muni.cz> <20080225210113.GF16513@khazad-dum.debian.net> <20080225220720.GA4523@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60623 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758931AbYBYXAk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 18:00:40 -0500
Content-Disposition: inline
In-Reply-To: <20080225220720.GA4523@ics.muni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Mon, 25 Feb 2008, Lukas Hejtmanek wrote:
> volume keys work. But anything through acpid does not. Even AC/battery switch
> is not signalized. So the bug may be somewhere else?

Yeah, there is an EC-related regression in 2.6.25-rc3 that bites your
thinkpad.  I don't have a link to it right now, but if you look for the
messages to LKML on the last 48h, you will find it.

> [  418.816087] thinkpad_acpi: requested hot key mask 0xffffffff, but firmware forced it to 0x00ffffff

Don't do this.  Just let the driver select the default mask, unless you
*really* know better.

> > Sure, try this one:
> 
> not better.

It wouldn't fix any EC issues.  If you just revert the
6c231bd5eb07ce546517019f334652b9ecfc329a commit entirely (note, I don't mean
revert TO THE COMMIT), by doing something like this:

git checkout v2.6.25-rc3
git show 6c231bd5eb07ce546517019f334652b9ecfc329a | patch -p1 -R

Does it fix anything ?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
