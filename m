From: Michael Notforyou <sqfreak-goaWJWIt5zpWk0Htik3J/w@public.gmane.org>
Subject: Re: Lockup at boottime on Compaq Presario 730US --
  Please help!!
Date: Tue, 27 Aug 2002 22:24:32 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5.1.0.14.0.20020827222213.032dfdc0@pop-server.triad.rr.com>
References: <5.1.0.14.0.20020823173454.03293e68@pop-server.triad.rr.com>
 <5.1.0.14.0.20020823075547.032699f8@pop-server.triad.rr.com>
 <5.1.0.14.0.20020822143358.0321eb10@pop-server.triad.rr.com>
 <5.1.0.14.0.20020822073524.03215dd8@pop-server.triad.rr.com>
 <5.1.0.14.0.20020821193844.030509b0@pop-server.triad.rr.com>
 <5.1.0.14.0.20020821193844.030509b0@pop-server.triad.rr.com>
 <5.1.0.14.0.20020822073524.03215dd8@pop-server.triad.rr.com>
 <5.1.0.14.0.20020822143358.0321eb10@pop-server.triad.rr.com>
 <5.1.0.14.0.20020823075547.032699f8@pop-server.triad.rr.com>
 <5.1.0.14.0.20020823173454.03293e68@pop-server.triad.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020827120154.GF30943-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It's really OK now. The problem was that I was compiling an SMP kernel 
which automatically enables Local APIC which crashes the system. Compiling 
all ACPI elements into the kernel worked - as long as there was no SMP 
support. Everything (except sleep and swsusp - which won't compile, long 
story) works. I have easy battery ratings.

Thanks for your help!


At 01:01 PM 8/27/2002 +0100, you wrote:
>Michael Notforyou [sqfreak-goaWJWIt5zpWk0Htik3J/w@public.gmane.org] wrote:
> > I think I need to patch my DSDT as well. I have no battery rating with the
> > unpatched kernel (meaning the SourceForge ACPI not applied). Nor do I have
> > performance.
> >
> > The command you gave me to export my DSDT did nothing but spit out garbage
> > and corrupt my terminal display.
>
>Sounds like you forgot to put the redirect which would cause it to get
>saved to a file the "> dsdt.txt" was part of the command.  It's not junk
>it's just 'compiled' - computer readable, rather than source - human
>readable.
>
>You need to use pacpidump on that file and then use iasl to find errors
>and fix them.
>
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.19/kernel/drivers/acpi/MODULENAME.o
> > depmod: acpi_ut_debug_print
> > depmod: acpi_ut_value_exit
> > depmod: acpi_ut_exit
> > depmod: acpi_ut_trace
>
>It's possible there is a problem with the build for making these things
>as modules, I have only ever made them as built-in because I can't think
>of a time when I would ever want them not to be loaded.
>
>
>Faye
>
>--
>Faye Pearson,
>Software Development Manager,
>ClaraNET Ltd.       Tel 020 7903 3000
>
>The faster we go, the rounder we get.
>                 -- The Grateful Dead

*Michael Notforyou*

"My God, I'm full of stars!"
Darmok and Jalad at Tanagra!



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
