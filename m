From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: new DRI resume binary snapshots and patches available
Date: Wed, 4 Dec 2002 21:49:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021204204950.GA7013@dutidad.twi.tudelft.nl>
References: <20021203232507.GA1723@dutidad.twi.tudelft.nl> <1039010406.31730.53.camel@debian.Debian-beast> <1039011070.4773.36.camel@dutidad> <1039030887.15651.11.camel@debian.Debian-beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1039030887.15651.11.camel-XpXrOaFReG1A+pMbq6XI4y5m1MAxIYdN@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pere =?iso-8859-1?Q?Casta=F1er_Sard=E0?= <XaRz69-pCzzcW6XgXY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 04, 2002 at 08:41:27PM +0100, Pere Castañer Sardà wrote:
> Compiling...
> ERROR: Kernel modules did not compile
> 
> The DRI drivers can not be installed without the latest kernel modules.
> Installation will be aborted. See the dri.log file for information on
> what went wrong.

Could you attach the dri.log file please.  It would help very much to know
why the compilation failed. :)

> PD: I haven't be able to install swsusp(beta16)-vainilla
> +acpi20021126-2.4.20-rc3.diff with linux-2.4.20 final release of the
> kernel, and because of this, your resume-patch doesn't have any sense
> for my hardware (at this moment).

I'm still happily running 2.4.18 + acpi 20020918 + swsuspv12.  This is
rocksolid on my Clevo 5600, with the only caveat that I have to re-set the
MTRRs at resume in my suspend.sh script as swsuspv12 doesn't look after
MTRRs yet.  I believe v14 does... I'm sticking to this combination until I
_know_ that the ext3 corruption rumours about 2.4.20 are false and that the
ACPI + latest swsusp patches work on 2.4.20.

Thanks very much for the report!

Regards,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
