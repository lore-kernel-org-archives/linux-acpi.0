From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [ACPI] Re: mem= option for broken bioses
Date: Thu, 27 Feb 2003 17:12:04 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030227161203.GF12434@atrey.karlin.mff.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com> <20030226224450.GD15455@atrey.karlin.mff.cuni.cz> <3E5E2061.2060807@paceblade.com> <20030227151907.GC12434@atrey.karlin.mff.cuni.cz> <20030227154922.GY13404@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030227154922.GY13404-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Robert Woerle Paceblade/Support <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > >>OK, looks reasonable. Can you also gen up a patch documenting this in
> > > >>kernel-parameters.txt?
> > > >>   
> > > >>
> > > >
> > > >You can, assuming you took the patch ;-).
> > > > 
> > > >
> > > well how can i find the correct value`s to put in ??
> > 
> > Well, similar method to how you use mem=123@456 parameters. You just
> > guess them. [Given kernel messages, it is actually quite easy.]
> > 
> 
> If I understand you,  you then just have to mem= with the correct
> value reported via, for example:
> 
> ducrot@novae:~$ dmesg | grep 'ACPI data'
>  BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)

Well, for you bios map is okay and you don't need mem= parameter.

> But big problem though.  It is really really strange that the
> BIOS mainteners have broken e820 call, are you sure you have
> enabled acpi in BIOS, and/or power management ?

Yes, what I needed was bios update. If you downgrade your bios you can
provoke same bug I saw.

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
