From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [ACPI] PaceBlade broken acpi/memory map
Date: Wed, 26 Feb 2003 10:39:12 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030226093911.GC30845@atrey.karlin.mff.cuni.cz>
References: <20030220172144.GA15016@elf.ucw.cz> <20030224164209.GD13404@poup.poupinou.org> <20030224183955.GC517@atrey.karlin.mff.cuni.cz> <20030225143505.GH13404@poup.poupinou.org> <3E5B835E.7050601@symplon.com> <20030225151341.GI13404@poup.poupinou.org> <20030225174449.GD12028@atrey.karlin.mff.cuni.cz> <20030225200907.GJ13404@poup.poupinou.org> <20030225204911.GK13404@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030225204911.GK13404-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Robert <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > I've received it after I made my patch, and I think that more machine
> > > with broken tables will be created in future...
> > > 
> > 
> > That it not the answer I expected.  To be more clear: you report errors
> > on _STA and _INI.  I don't know why.  But with my previous patch, it seems
> > that there is no such errors (but it is with 2.4).
> > And one of the suspect(s) for what I know is your mem= option patch.
> 
> Ok.  Found your patch in LKML.  Soon like to be OK.  Will see then what
> hapens, but I need your dmesg.

Sorry, I no longer have access to that machine :-(.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
