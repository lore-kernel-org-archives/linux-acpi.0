From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [2.6.0-test4][ACPI] STR, STD returns immidiately
Date: Sat, 30 Aug 2003 13:11:24 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030830111124.GC386@elf.ucw.cz>
References: <200308241537.54494.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200308241537.54494.fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
To: Fedor Karpelevitch <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> when I do 
> echo mem > /sys/power/state
> or
> echo disk > /sys/power/state
> 
> it returns in a second without any effect and in sysslog I get this:

Patrick broke whole powermanagment in -test4. It is not worth even
trying.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
