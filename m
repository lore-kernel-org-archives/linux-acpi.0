From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Date: Mon, 10 Feb 2003 08:42:13 +1300
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1044819732.1815.25.camel@laptop-linux.cunninghams>
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com>
 <20030204221003.GA250@elf.ucw.cz>
 <1044477704.1648.19.camel@laptop-linux.cunninghams>
 <20030206101645.GO1205@poup.poupinou.org>
 <1044560486.1700.13.camel@laptop-linux.cunninghams>
 <20030206210542.GW1205@poup.poupinou.org>
 <1044590241.1649.41.camel@laptop-linux.cunninghams>
 <20030207160055.GA485@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20030207160055.GA485-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Swsusp <swsusp-LcL5texQODR2DW0IdvIQ2g@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi

On Sat, 2003-02-08 at 05:00, Pavel Machek wrote: 
> > 1  2  3           4     5
> > --
> > 1  1  25655/30592  1562 0:07
> > 1  2  26246/30592  4302 0:05
> 
> You can suspend and resume your notebook within 5 seconds? Wow!

As requested, these were just the times for suspending.

> Well, if all the memory is in disk-backed clean pages, it should be
> faster to discard then write out...

Yes, I would think so too. Perhaps the differences would probably
disappear if I made the algorithm more like your original (ie simplifed
eat_memory back to the original), but I do remember lots of disk
activity when using the original code as well - perhaps the cause might
be worth further investigation? (Not that I'm volunteering)

> Anyway... So your method is faster. Good. Now, how much more
> complicated is it?

As I've said above, I'm not sure it is right to say it is faster - I
didn't compare your current method with the new one, but rather mine
with parameters making the algorithm as close to yours as possible. My
point was more that if the new method is slower, its not significantly
slower.

Nevertheless, you do have a good point - it is more complicated. But I
think it's worth it and its not a lot more complicated. People who are
using the new method at the moment appreciate the changes. Don't think
for a moment that I don't value your work, Pavel. I couldn't have done
any of my additions without it and consider mine tweaking. This has
simply been a quest to get a more responsive system on resume.

Regards,

Nigel
