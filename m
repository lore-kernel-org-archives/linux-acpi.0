From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [ACPI] RE: [patch] 2.4.x ACPI updates
Date: Tue, 2 Sep 2003 16:37:57 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030902143756.GH1358@openzaurus.ucw.cz>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCCA@hdsmsx402.hd.intel.com> <Pine.LNX.4.55L.0308231826470.5824@freak.distro.conectiva> <20030823223340.GA7129@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030823223340.GA7129-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "J.A. Magallon" <jamagallon-cer70A47DaU@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=106146576326309&w=2
> 
> Hi,
> This is probably a BIOS / hardware bug, a rare occurence actually.
> The logs show:
> #v+
> acpi_power-0363 [64] acpi_power_transition : Error transitioning device [CFAN] to D0
> acpi_bus-0496 [63] acpi_bus_set_power    : Error transitioning device [CFAN] to D0
> acpi_thermal-0549 [62] acpi_thermal_active   : Unable to turn cooling device [c12d2528] 'on'
> Unable to handle kernel paging request at virtual address 876c33c4
> [...]
> #v-
> (sometimes there's D3 in place of D0, depending on the trip points /
> temperature readings), and then the oops follows. Unfortunately, I
> can't provide the ksymoops output, as the kernel which the oops was logged
> on has been gone long since.
> 
> Anyway, this is by no means reproducible, occurs quasi-randomly (more often

You should be able to do echo ? > /proc/acpi/*/fan/state to stress this manually...
				Pavel

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...
