From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Compilation error acpi-20020725-2.4.18
Date: Fri, 26 Jul 2002 10:22:50 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <59885C5E3098D511AD690002A5072D3C07990D8A@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "'Charl P. Botha'" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>, =?iso-8859-1?Q?Birge?= =?iso-8859-1?Q?r_Peer_K=FCpper?= <kuepper-juygj+9FDkuELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Charl P. Botha [mailto:c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org] 
> > dswload.c: In function `acpi_ds_load2_end_op':
> > dswload.c:451: structure has no member named `name'
> > make[4]: *** [dswload.o] Error 1
> > make[4]: Leaving directory `/usr/src/linux/drivers/acpi/dispatcher'
> > make[3]: *** [first_rule] Error 2
> > make[3]: Leaving directory `/usr/src/linux/drivers/acpi/dispatcher'
> > make[2]: *** [_subdir_dispatcher] Error 2
> > make[2]: Leaving directory `/usr/src/linux/drivers/acpi'
> > make[1]: *** [_subdir_acpi] Error 2
> > make[1]: Leaving directory `/usr/src/linux/drivers'
> > make: *** [_dir_drivers] Error 2
> 
> There's a problem with a define.  I fixed it on my box but 
> I'm now getting
> an oops on bootup; this oops might be due to some other 
> problem with ACPI on
> my system.  You could TRY to add #define ACPI_DISASSEMBLER to 
> the top of
> drivers/acpi/include/platform/acenv.h and rebuild, but I 
> would not recommend
> it, at least not until some of the experienced ACPI kids have 
> looked at it.

It's in a debug message, so turning off acpi debug should get things at
least compiling again.

I'm sure it's an easy fix, so I'll get on it, and post again when it's
fixed. Turning on ACPI_DISASSEMBLER is *not* the correct solution.

/me dons a brown paper bag

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
