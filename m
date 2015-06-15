From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Regression in 3.10.80 vs. 3.10.79
Date: Tue, 16 Jun 2015 01:00:13 +0200
Message-ID: <2054960.9BJU2lQTPg@vostro.rjw.lan>
References: <CAL1RGDV6hr3_Oa6O-kPzx9EemtOWWtYq+-RkCzN7axNPLz5MJw@mail.gmail.com> <CAL1RGDXak7oCpOQeXqvDxHf2ihZD6jUopKPZMPCLdPfLO38qWg@mail.gmail.com> <CAL1RGDV16N_TngC8gN9ZF9TR-oOu+QkhXp=7rwcM4E_X12BvQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64356 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750960AbbFOWeR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2015 18:34:17 -0400
In-Reply-To: <CAL1RGDV16N_TngC8gN9ZF9TR-oOu+QkhXp=7rwcM4E_X12BvQw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roland Dreier <roland@purestorage.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, George McCollister <george.mccollister@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>

On Monday, June 15, 2015 07:56:05 AM Roland Dreier wrote:
> On Sat, Jun 13, 2015 at 9:56 AM, Roland Dreier <roland@purestorage.com> wrote:
> > Below is a more sophisticated, so to speak, version of it with a changelog and
> > all.  It works for me, but more testing would be much appreciated.
> 
> Yes, the patch works as expected:
> 
> Tested-by: Roland Dreier <roland@purestorage.com>

Awesome, thanks a lot for the confirmation!

I'll send it Linuswards for final 4.1.

> It does change /proc/ioports heirarchy to
> 
>   0400-0403 : ACPI PM1a_EVT_BLK
>   0404-0405 : ACPI PM1a_CNT_BLK
>   0406-0407 : pnp 00:06
>   0408-040b : ACPI PM_TMR
>   040c-041f : pnp 00:06
>     0410-0415 : ACPI CPU throttle
>   0420-042f : ACPI GPE0_BLK
>   0430-044f : pnp 00:06
>     0430-0433 : iTCO_wdt
>       0430-0433 : iTCO_wdt
>   0450-0450 : ACPI PM2_CNT_BLK
>   0451-047f : pnp 00:06
>     0460-047f : iTCO_wdt
>       0460-047f : iTCO_wdt
> 
> where the old kernel had
> 
>   0400-047f : pnp 00:06
>     0400-0403 : ACPI PM1a_EVT_BLK
>     0404-0405 : ACPI PM1a_CNT_BLK
>     0408-040b : ACPI PM_TMR
>     0410-0415 : ACPI CPU throttle
>     0420-042f : ACPI GPE0_BLK
>     0430-0433 : iTCO_wdt
>       0430-0433 : iTCO_wdt
>     0450-0450 : ACPI PM2_CNT_BLK
>     0460-047f : iTCO_wdt
>       0460-047f : iTCO_wdt
> 
> but I don't think that matters.

No, it doesn't.

Thanks,
Rafael

