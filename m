From: Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>
Subject: Re: Mandrake 10 weird acpi behaviour
Date: Tue, 16 Mar 2004 14:47:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079444879.10067.19.camel@skinnerup.mip.sdu.dk>
References: <1079031999.3679.1.camel@darkstar>
	 <20040311230047.GA20345@stikine.ucs.sfu.ca>
	 <Pine.LNX.4.58.0403121055010.1203@frog.athome>
	 <20040312193716.GC25056@stikine.ucs.sfu.ca>
	 <Pine.LNX.4.58.0403131152490.1228@frog.athome>
	 <1079429336.10065.8.camel@skinnerup.mip.sdu.dk>
	 <20040316132759.GA12230@hell.org.pl>
	 <20040316134456.GA1396@dreamcraft.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040316134456.GA1396-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tomasz Ciolek <tmc-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

- Correct - it just shuts down acpid and then starts it over again. I
will look at the script and compare it to the old mandrake 9.1 scipt
(which worked). My guess is that this is not a problem if the script,
but rather the acpid daemon (if it has changed lately) or the newer
version of acpi used in my new kernel..

Mads

On Tue, 2004-03-16 at 14:44, Tomasz Ciolek wrote:
>  it would appear that it (re)starts thet script in /etc/init.d/ called
>  acpid. this in turn turns on the acpi even monitoring daemon.
> 
>  At least thats what it does on my P2120 Debian/Testing machine.
> 
>  TMC
> 
> On Tue, Mar 16, 2004 at 02:27:59PM +0100, Karol Kozimor wrote:
> > Thus wrote Mads Paulin:
> > > If I issue a 'service acpid restart? to restart the acpid daemon, the
> > > applications assigned to the hotkeys are launched as supposed. However,
> > > in this case when I hit the powerbutton, the laptop immediately calls
> > > acpi_power_off and shuts down uncleanly without unmounting file systems
> > > or anything.
> > 
> > See what this 'service acpid restart' does, this must be a script of some
> > sort.
> > Best regards,
> > 
> > -- 
> > Karol 'sziwan' Kozimor
> > sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials
> > Free Linux tutorial presented by Daniel Robbins, President and CEO of
> > GenToo technologies. Learn everything from fundamentals to system
> > administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
