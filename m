From: Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
Subject: RE: [patch] 2.4.x ACPI updates
Date: Wed, 20 Aug 2003 15:15:43 -0300 (BRT)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.55L.0308201514140.617@freak.distro.conectiva>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC7F@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC7F-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "J.A. Magallon" <jamagallon-cer70A47DaU@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



On Tue, 19 Aug 2003, Brown, Len wrote:

> Andy/Jeff/Marcelo,
>
> At Jeff's request, I've back ported ACPICA 20030813 from
> http://linux-acpi.bkbits.net/linux-acpi-2.4 into a new tree for 2.4.22:
> http://linux-acpi.bkbits.net/linux-acpi-2.4.22
>
> I've restored acpitable.[ch], which was deleted too late for this
> release cycle; and will live on until 2.4.23 -- as well as restored
> CONFIG_ACPI_HT_ONLY under CONFIG_ACPI; restored the 8-bit characters
> that got expanded to 16-bits in a previous merge; and deleted some dmesg
> verbiage that Jeff didn't think was appropriate for the baseline kernel.
>
> I exported this a patch and then imported onto a clone of Marcelo's
> tree, so it appears as a single cset where the changes that got un-done
> never happened.  I've done some sanity tests on it, and will test it
> some more tomorrow.  Take a look at it and let me know if I missed
> anything.  When Andy is happy with it I'll leave it to him to re-issue a
> pull request from Marcelo.

Cool!!

Ill try to take a look at the patch now (having serious conectivity issues
:()
