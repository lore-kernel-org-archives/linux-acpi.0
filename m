From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: Tell user when ACPI is killing machine
Date: Sat, 6 Dec 2003 12:14:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031206111400.GA403@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8401720BFD@pdsmsx403.ccr.corp.intel.com> <20031204095454.GC6911@atrey.karlin.mff.cuni.cz> <1070532076.1645.42.camel@golgoth01> <20031204105621.GE11044@atrey.karlin.mff.cuni.cz> <yw1x8ylsltb3.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <yw1x8ylsltb3.fsf-UNjuZkX4dYU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: M?ns Rullg?rd <mru-UNjuZkX4dYU@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >> I have a similar problem since test10 and test11 (2.4.23 is ok, test9 is
> >> ok too). ACPI reports bogus temperatures and powers the machine
> >> down.
> >
> >> If you have a patch that could fix that problem, I'm ready to try it and
> >> report success or failure ;)
> >
> > I have ugly workaround ("if temperature reported is > 200Celsius,
> > ignore it").
> 
> I'm just curious, are these (and other ACPI related) problems caused
> by bugs in Linux, or by hardware/firmware bugs?

Its hard to tell one from another without extensive debugging...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
