From: Gabor FLEISCHER <swsusp-XNofHPEhfVgNocND/f+tbZP2KDSNp7ea@public.gmane.org>
Subject: Re: [Swsusp-devel] hibernate when battery is low ?
Date: Fri, 1 Aug 2003 10:31:08 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030801083108.GA11535@jcc.hu>
References: <200307312204.h6VM4xTD029148@anubis.mchp.siemens.de> <200307312306.h6VN6RI16016@popa.gsfc.nasa.gov> <20030731230848.GB9011@jcc.hu> <200307312336.h6VNapI21536@popa.gsfc.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200307312336.h6VNapI21536-D9AVUHqm8KsT64QOZzyjW+1ftBKYq+Ku@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: jm-E0REtxwXDqY@public.gmane.org, ACPI-devel List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 31, 2003 at 07:36:51PM -0400, Jan Merka <jm-E0REtxwXDqY@public.gmane.org> wrote:
> > ACPI_B=`acpi -b`
> > BAT=`echo "$ACPI_B" | sed -e "s/.*,\(.*\)%.*/\1/"`
> > CHARGE=`echo "$ACPI_B" | sed -e "s/.*:\([^,]*\),.*/\1/"`

> I will test it once I get to my developer box. I would recomend you to look 
> at wmab project. The source code might be an inspiration how to poll the 
> battery status.

I think you misunderstood something. This script goes to the place where
acpid calls it. I'm not polling anything, 'cause I get called when needed.
The only thing I do is reading the battery status. But to do this I use the
acpi program, which is included in the debian, and hopefully updated, so
that if there's any change in /proc/acpi, I won't have to know about it,
because `acpi -b` will give me the same output.

The another thing is, that it's true that I think most WMs have some kind of
APM/ACPI daemon. Unfortunatelly they probably are reading the relevant
status informations in every X second. The ideal would be if they could
register themselves to acpid as a callback function for Y event. This way
they could also set the behaviour of acpid. Currently I don't really know
what's happening: battery is getting down. Depending on how acpid,
klaptopdaemon (or another WM's daemon) is set maybe acpid will call
hibernate, maybe the WM's daemon...

But let's continue this on acpi-dev list!

Gavriel


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
