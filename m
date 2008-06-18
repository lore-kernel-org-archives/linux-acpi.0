From: Daniel Exner <dex@dragonslave.de>
Subject: Re: linux-next Regression: Unable to locate IOAPIC
Date: Wed, 18 Jun 2008 23:14:02 +0200
Message-ID: <200806182314.03577.dex@dragonslave.de>
References: <200806051100.12885.dex@dragonslave.de> <200806182157.04120.dex@dragonslave.de> <86802c440806181341w7c2ac2det817548c68d00040c@mail.gmail.com>
Reply-To: webmaster@dragonslave.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server009.webpack.hosteurope.de ([80.237.130.17]:46802 "EHLO
	server009.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754605AbYFRVOT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jun 2008 17:14:19 -0400
In-Reply-To: <86802c440806181341w7c2ac2det817548c68d00040c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

Yinghai Lu wrote:
> On Wed, Jun 18, 2008 at 12:57 PM, Daniel Exner <dex@dragonslave.de> wrote:
> > Yinghai Lu wrote:
> >> On Sun, Jun 15, 2008 at 12:14 PM, Daniel Exner <dex@dragonslave.de> 
> >> > I guss you no longer need the complete dmesg output?
> >>
> >> still need that... wonder why your irq routing have same entris from
> >> your BIOS/ACPI?
> >
> > Again, sorry for the delay. I raised the Kernel buffer and added an
> > output, done using rc6.

> > Local APIC disabled by BIOS -- you can enable it with "lapic"
>
> sound interesting...
Tried that numerous times before. This gives me:

Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffb000 (fee00000)

But nothing else happens. I guess the chipset doesnt support IOAPIC so a local 
APIC doesnt give any benefit. (And thats the deeper cause of the regression I 
originaly reported)

--
Greetings
Daniel Exner
