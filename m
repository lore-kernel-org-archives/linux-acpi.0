From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: About dsdt of clevo 5600N
Date: Sat, 17 May 2003 13:05:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030517110512.GA3820@dutidad.twi.tudelft.nl>
References: <20030516021732.69eca85d.XaRz69@terra.es> <20030516035605.18dc60b8.XaRz69@terra.es> <Pine.LNX.4.53.0305160752340.5724@dynast.gaugusch.at> <1053074691.1189.6.camel@dutidad> <20030516230144.GB22394@hell.org.pl> <20030516231823.GB2355@dutidad.twi.tudelft.nl> <20030517085410.GA13867@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030517085410.GA13867-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, May 17, 2003 at 10:54:10AM +0200, Karol Kozimor wrote:
> Thus wrote Charl P. Botha:
> > acpi_sleep=s3_bios is one way to repost and comes down to exactly what Ole
> > Rohne did with the int10 module of XFree86.  This does not work on all
> > implementations.  The Right Way is to have the necessary specifications for
> > the chip for correct wake-up from device D3 state, or whatever is relevant
> > for system S3.  These specs are NOT available for the Radeon M7.
> 
> Did you check the newer radeonfb driver versions? There is some power
> management code in there, but apparently only meant for Apple laptops.
> Maybe it would be possible to use that code? Disclaimer: I know virtually
> nothing about PCI power management, so there is a chance I don't have any
> clue on what I am talking about.
> Best regards,

A while back I posted a link to this code (by Benjamin Herrenschmidt and ATI
engineers) to the acpi-devel list.  The code supports device D2 and not D3.
Even Ben has his doubts (as posted to mailing lists) about sleep support on
graphics chips.

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
