From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Date: Thu, 6 Feb 2003 22:05:42 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030206210542.GW1205@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com> <20030204221003.GA250@elf.ucw.cz> <1044477704.1648.19.camel@laptop-linux.cunninghams> <20030206101645.GO1205@poup.poupinou.org> <1044560486.1700.13.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1044560486.1700.13.camel-udXHSmD1qAz9bBlWBkG5g4WQyAnV0byH@public.gmane.org>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 07, 2003 at 08:41:27AM +1300, Nigel Cunningham wrote:
> On Thu, 2003-02-06 at 23:16, Ducrot Bruno wrote:
> > On Thu, Feb 06, 2003 at 09:41:44AM +1300, Nigel Cunningham wrote:
> > > Whether its slower depends on the hardware; on my 128MB Celeron 933
> > > laptop (17MB/s HDD), I can write an image of about 120MB, reboot and get
> > > back up and running in around a minute and a half. That's about the same
> > > as far as I remember, but has (as you say) the advantage of not still
> > > having to get things swapped back in.
> > 
> > The problem is the speed of the suspending process, not the whole suspend/resume
> > sequence,  especially in case of emergency suspending due to thermal condition,
> > etc.
> 
> Sorry. Perhaps I should have been clearer. I haven't spent a lot of time
> doing timings, but there doesn't seem to be any significant difference.
> In both versions, the amount of time varies with the amount of memory in

Ah ok.  I understand now.  S4bios is completely different from swsusp.
It's just as if we were comparing APM suspend-to-disk and swsusp (and no, S4bios
is *not* APM suspend-to-disk either).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
