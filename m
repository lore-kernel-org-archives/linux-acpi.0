From: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
Date: Sat, 20 Sep 2003 15:58:35 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030920135835.GB589@alpha.home.local>
References: <20030915224136.GA11666@k3.hellgate.ch> <Pine.GSO.4.21.0309191053140.4488-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309191053140.4488-100000-Q9iLAqk50tFNk+PO8Cj175kigfUh6rMo@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Development <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Sep 20, 2003 at 03:17:37PM +0200, Geert Uytterhoeven wrote:
 
> If I turn off CONFIG_X86_UP_APIC I get:
> 
> | ACPI disabled because your bios is from 00 and too old
> | You can enable it with acpi=force
> | Sony Vaio laptop detected.
> 
> and ACPI is disabled. Halt doesn't work.
> 
> If I then pass `acpi=force' to explicitly enable ACPI, `halt' works again and
> powers off the machine, but `reboot' causes a black screen with IDE disk spun
> down, but no restart.

Strangely, the problem you describe here what I got with local APIC enabled,
on a Vaio PCG-FX705 (athlon 1.3G). I think I will retry with a recent kernel
to be sure these problems vanished.

Regards,
Willy
