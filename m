From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
Date: Tue, 16 Sep 2003 22:06:55 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030916200655.GG602@elf.ucw.cz>
References: <Pine.GSO.4.21.0309150835480.3191-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309150835480.3191-100000-Q9iLAqk50tFNk+PO8Cj175kigfUh6rMo@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Development <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> With 2.4.22, my Sony Vaio PCG-Z600TEK (s/600/505/ in US/JP) shows a regression
> w.r.t. power management:
>   - It doesn't poweroff anymore (screen contents are still there after the
>     powering down message)
>   - It doesn't reboot anymore (screen goes black, though)
>   - It accidentally suspended to RAM once while I was actively working on it (I
>     never managed to get suspend working, except for this `accident'). I didn't
>     see any messages about this in the kernel log.

It suspended to RAM... Did it also *resume* correctly?
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
