From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Instability without ACPI
Date: Fri, 11 Jul 2003 20:46:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030711184648.GN22636@poupinou.org>
References: <200307110022.29512.adq_dvb@lidskialf.net> <200307111356.22376.adq_dvb@lidskialf.net> <20030711140227.GF22636@poupinou.org> <200307111806.57883.adq_dvb@lidskialf.net> <20030711172639.GL22636@poupinou.org> <1057947446.1451.51.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1057947446.1451.51.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?S=E9rgio?= Monteiro Basto <sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org>
Cc: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 11, 2003 at 07:17:25PM +0100, Sérgio Monteiro Basto wrote:
> On Fri, 2003-07-11 at 18:26, Ducrot Bruno wrote:
> > 
> > You probably need acpi due to power states for the cpu.  Common problem
> > with laptop shipped with athlon in general (there is a tool called
> > lvcool though if you do not have acpi).
> 
> sounds cool
> I have one athlon 4 on one KT133.
> but after reading 
> http://cip.uni-trier.de/nofftz/linux/Athlon-Powersaving-HOWTO.html
> 
> in 2.5
> This is the only solution which does not use the ACPI system of the
> Linux kernel. 

This one will do exactly what ACPI does (that is, in the main loop,
read LVL2 register).  So the exact same issue will likely happens.

...

> 2.1. The Command-line Hack
> you can enable/disable the power-saving right from the command-line
> without any need for rebooting.
> 
> on KT133/133A, KX133, KL/KLE133, KM/KN133, ...:
> enable: setpci -v -H1 -s 0:0.0 52=$(printf %x $((0x$(setpci -H1 -s 0:0.0
> 52) | 0x80)))
> disable: setpci -v -H1 -s 0:0.0 52=$(printf %x $((0x$(setpci -H1 -s
> 0:0.0 52) & 0x7f))) 
> 
> How I know if it enable or disable ?

setpci -H1 -s 0:0.0 52
then look if bit 8 is set (enable) or not (disable).

> is it safe try this commands?

I don't know.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
