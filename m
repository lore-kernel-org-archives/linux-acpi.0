From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Date: Wed, 5 Feb 2003 21:05:21 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030205200521.GN1205@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com> <20030204221003.GA250@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030204221003.GA250-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 04, 2003 at 11:10:04PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > This patch is for s4bios support in 2.5.59 with acpi-20030123.
> > > 
> > > This is the 'minimal' requirement.  Some devices (especially the
> > > IDE part) are not well resumed.  Handle with care..
> > > 
> > > Note also that the resuming part (I mean IDE) was more stable
> > > with an equivalent patch when I tested with 2.5.54 (grumble 
> > > grumble)...
> > > 
> > > I think also that it is a 'good' checker for devices power management
> > > in general...
> > 
> > I'd really rather just have S4OS (aka swsusp) in 2.5 patches -- if the
> > OS can do S4 on its own, that is really preferable to S4bios.
> 
> Well, we already have S4OS, and having S4OS does not mean we can't
> have S4bios.
> 
> Some people apparently want slower suspend/resume but have all caches
> intact when resumed. Thats not easy for swsusp but they can have that
> with S4bios. And S4bios is usefull for testing device support; it
> seems to behave slightly differently to S3 meaning better testing.
> 

Yep, correct.  The problem is that now I have more trouble with s4bios
in general with 2.5.  That worked more reliability with 'older' 2.5 series.
Really don't know why.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
