From: Roland Dreier <roland@purestorage.com>
Subject: Re: Regression in 3.10.80 vs. 3.10.79
Date: Fri, 12 Jun 2015 08:01:15 -0700
Message-ID: <CAL1RGDVMwmpB2Gap3HcWzUP6MAr83wtkZLic9dv8Ms6wLEX95A@mail.gmail.com>
References: <CAL1RGDV6hr3_Oa6O-kPzx9EemtOWWtYq+-RkCzN7axNPLz5MJw@mail.gmail.com>
 <25627634.TOSvDFmF1a@vostro.rjw.lan> <CAL1RGDWt8+ZJ3_+xKnYcDMs+D0Ta289Y6sqTPvBLLmPEMovTnw@mail.gmail.com>
 <1903121.bsBlXHXLzb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1903121.bsBlXHXLzb@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, George McCollister <george.mccollister@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 11, 2015 at 1:50 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Changing the ordering between those two routines would work around that problem,
> but in my view that wouldn't be a proper fix.  In fact, the role of reserve_range()
> is to reserve the resources so as to prevent them from being used going forward,
> so they need not be reserved each in one piece.  Instead, we can just check if they
> overlap with the ones reserved by acpi_reserve_resources() and only request the
> non-overlapping parts of them to avoid conflicts.
>
> So I wonder if the patch below makes any difference?

I will give this a try and make sure it fixes my system, although I'm
pretty sure it will.

However I'm not sure I agree that this is a better fix than just
having pnp reserve ranges before acpi.  It already creates a special
relationship between pnp and acpi, and acpi_reserve_region is a bunch
of extra code.  Could we really have a system where the hierarchy of
acpi being a subset of a pnp bus doesn't work?  I looked at a few
other systems I have, and things like the following seem quite common:

supermicro:

03e0-0cf7 : PCI Bus 0000:00
  03f8-03ff : serial
  0400-0453 : pnp 00:0c
    0400-0403 : ACPI PM1a_EVT_BLK
    0404-0405 : ACPI PM1a_CNT_BLK
    0408-040b : ACPI PM_TMR
    0410-0415 : ACPI CPU throttle
    0420-042f : ACPI GPE0_BLK
    0430-0433 : iTCO_wdt
    0450-0450 : ACPI PM2_CNT_BLK

dell:

03e0-0cf7 : PCI Bus 0000:00
  03f8-03ff : serial
  0800-087f : pnp 00:06
    0800-0803 : ACPI PM1a_EVT_BLK
    0804-0805 : ACPI PM1a_CNT_BLK
    0808-080b : ACPI PM_TMR
    0810-0815 : ACPI CPU throttle
    0820-082f : ACPI GPE0_BLK
    0830-0833 : iTCO_wdt
      0830-0833 : iTCO_wdt
    0850-0850 : ACPI PM2_CNT_BLK
    0860-087f : iTCO_wdt
      0860-087f : iTCO_wdt

but I wasn't able to find anything that required more generality...
