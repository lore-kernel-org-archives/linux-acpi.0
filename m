From: tmc-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org (Tomasz Ciolek)
Subject: Re: Mandrake 10 weird acpi behaviour
Date: Wed, 17 Mar 2004 00:44:56 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040316134456.GA1396@dreamcraft.com.au>
References: <1079031999.3679.1.camel@darkstar> <20040311230047.GA20345@stikine.ucs.sfu.ca> <Pine.LNX.4.58.0403121055010.1203@frog.athome> <20040312193716.GC25056@stikine.ucs.sfu.ca> <Pine.LNX.4.58.0403131152490.1228@frog.athome> <1079429336.10065.8.camel@skinnerup.mip.sdu.dk> <20040316132759.GA12230@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040316132759.GA12230-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 it would appear that it (re)starts thet script in /etc/init.d/ called
 acpid. this in turn turns on the acpi even monitoring daemon.

 At least thats what it does on my P2120 Debian/Testing machine.

 TMC

On Tue, Mar 16, 2004 at 02:27:59PM +0100, Karol Kozimor wrote:
> Thus wrote Mads Paulin:
> > If I issue a 'service acpid restart? to restart the acpid daemon, the
> > applications assigned to the hotkeys are launched as supposed. However,
> > in this case when I hit the powerbutton, the laptop immediately calls
> > acpi_power_off and shuts down uncleanly without unmounting file systems
> > or anything.
> 
> See what this 'service acpid restart' does, this must be a script of some
> sort.
> Best regards,
> 
> -- 
> Karol 'sziwan' Kozimor
> sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- 
Tomasz M. Ciolek	
*******************************************************************************
 tmc at dreamcraft dot com dot au or tmc at goldweb dot com dot au 	
*******************************************************************************
	GPG Key ID: 0x41C4C2F0  Key available on www.pgp.net	
*******************************************************************************
  Everything falls under the law of change;	
  Like a dream, a phantom, a bubble, a shadow,
  like dew of flash of lightning.
  You should contemplate like this. 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
