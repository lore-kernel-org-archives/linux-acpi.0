From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [ACPI] S4bios support for 2.5.63
Date: Tue, 4 Mar 2003 14:23:29 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030304132329.GF618@zaurus.ucw.cz>
References: <20030226211347.GA14903@elf.ucw.cz> <20030227141322.GV13404@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030227141322.GV13404-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!


> > +
> > +	do {
> > +		acpi_os_stall(1000);
> > +		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);
> 
> Please use ACPI_MTX_DO_NOT_LOCK flags.

Is s/MTX_LOCK/MTX_DO_NOT_LOCK/
enough?

				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...
