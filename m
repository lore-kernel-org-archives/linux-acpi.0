From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ASL fixing questions
Date: Sat, 21 Feb 2004 18:15:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040221171557.GA247@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8401CBB6AF@PDSMSX403.ccr.corp.intel.com> <20040213044014.GG13262@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040213044014.GG13262-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Martijn Pieters <mj-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > >         Name (_PSS, Package (0x03) // 102 (206)
> > > >         {
> > > >             Package (0x06)
> > > >             {
> > > >                 0x08070000,
> > > >                 0xB36A0000,
> > > >                 0x7D000000,
> > > >                 0x09000000,
> > > >                 0x8A2920E0,
> > > >                 0x8A010000
> > >                   ^^^^^^^^^^
> > > 		  I think that all of those
> > > 		  values are broken, because
> > > 		  they are stored in a little bit
> > > 		  order.
> > > 		  It should be in fact, at least for the that
> > > 		  first package:
> > 
> > I'm curious how you can get such conclusion. ACPI spec
> > just state there should be 6 DWordConst for each Performance
> > State Definition Package.  
> > 
> 
> The first one is 0x08070000 which means that this processor can
> run at 134676480 MHz, which (I think) is a little bit to high.

Well, if Athlon64 can work at 134THz... Intel has a *big* problem ;-).

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
