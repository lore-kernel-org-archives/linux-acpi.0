From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Date: Fri, 07 Feb 2003 08:41:27 +1300
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1044560486.1700.13.camel@laptop-linux.cunninghams>
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com>
 <20030204221003.GA250@elf.ucw.cz>
 <1044477704.1648.19.camel@laptop-linux.cunninghams>
 <20030206101645.GO1205@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20030206101645.GO1205-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2003-02-06 at 23:16, Ducrot Bruno wrote:
> On Thu, Feb 06, 2003 at 09:41:44AM +1300, Nigel Cunningham wrote:
> > Whether its slower depends on the hardware; on my 128MB Celeron 933
> > laptop (17MB/s HDD), I can write an image of about 120MB, reboot and get
> > back up and running in around a minute and a half. That's about the same
> > as far as I remember, but has (as you say) the advantage of not still
> > having to get things swapped back in.
> 
> The problem is the speed of the suspending process, not the whole suspend/resume
> sequence,  especially in case of emergency suspending due to thermal condition,
> etc.

Sorry. Perhaps I should have been clearer. I haven't spent a lot of time
doing timings, but there doesn't seem to be any significant difference.
In both versions, the amount of time varies with the amount of memory in
use. When not much memory is in use, both are fast because there's not
much to do anyway. When lots of memory is in use, both are slower. The
old version is slower because it eats as much memory as it can, and this
can take significant amounts of time, then makes a copy of every page
remaining, before saving those pages to disk. The new version doesn't
usually eat any memory, and when it does, not much is eaten. It then
saves all the pages that aren't needed for the suspend process directly
to disk; always more than half, sometimes all but about a few thousand
pages. It then uses this memory for the copy & save of remaining pages.
Thus, in one version, the major portion of time is taken in eating
memory (and post resume, loading pages back in) whereas in the 'new'
version, the time taken is almost purely a function of IO speed.

If you like, I'll do some timings on my 320MB desktop machine and post
them later in the day.

Regards,

Nigel
