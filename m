From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Handler for [EmbeddedControl] returned AE_TIME in 2.6.1/20040116
Date: Thu, 5 Feb 2004 10:38:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040205093805.GO882@poupinou.org>
References: <20040203172413.GA1299@joehill.bostoncoop.net> <20040203143906.B33512@root.org> <20040203234141.GA8327@bostoncoop.net> <20040204103226.GI882@poupinou.org> <20040204204055.GA8434@joehill.bostoncoop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040204204055.GA8434-H/G4Yv+sbq78nmnftgJBZjK0Oss5Xsdo@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adam Kessel <adam-/J5p37YCQWYytDrLOV7HaA@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 04, 2004 at 03:40:55PM -0500, Adam Kessel wrote:
> On Wed, Feb 04, 2004 at 11:32:26AM +0100, Bruno Ducrot wrote:
> > > > We moved to a 100 ms timeout on EC requests for FreeBSD because some
> > > > devices just couldn't respond quicker.  But I think there's a larger issue
> > #define ACPI_EC_UDELAY_COUNT	10000
> 
> I tried this patch, and it does prevent the AE_TIME error. 
> 
> The battery charge indicator now seems unreliable, however, after
> switching from AC to battery and back.  For example, it will drop from
> 70%-80% down to 2% fairly quickly, but I can still run the machine for
> quite a while at 2%.  It also has jumped from 80% up to 100% in a couple
> of minutes, much faster than it could actually charge.
> 
> I'm not sure if any of this is related to the AE_TIME problem, but I'm
> putting it out here to see if there are any ideas.

I see 3 possibilities:

1- the EC firmware is somehow broken.  Nobody here then can help you
other than to tell you to go to EOM support, since most EC's are
microcontrollers, requiring a firmware for themself (those firmware
may contain bug, like any other software), and get the latest BIOS (this
EC's firmware may be downloaded at boot time on the chip by the bios),

2- the battery is dying and need to be replaced,

3- or, there is some bug in the current implementation under linux.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
