From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [ACPI] [2.6.0-test5-mm1] Suspend to RAM problems
Date: Wed, 10 Sep 2003 16:38:37 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030910143837.GC2589@elf.ucw.cz>
References: <20030910103142.GA1053@rootdir.de> <20030910111312.GA847@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030910111312.GA847-YJlxJerscEeELgA04lAiVw@public.gmane.org>
To: Claas Langbehn <claas-YJlxJerscEeELgA04lAiVw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew de Quincey <adq-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I also tried to suspend with ACPI in single user mode:
> 
> echo 3 >/proc/acpi/sleep
> 
> makes the system sleep within a second.
> 
> After waking it up by pressing a key or the power button
> the VGA Bios shows up for a second and afterwards I get
> this message:
> 
> APIC error on CPU0: 08(08)
> 
> ...and it repeats endlessly :(
> 
> my keyboard is dead afterwards.

Can you test on -test3 kernel?
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
