From: Adam Kessel <adam-/J5p37YCQWYytDrLOV7HaA@public.gmane.org>
Subject: Re: Handler for [EmbeddedControl] returned AE_TIME in 2.6.1/20040116
Date: Wed, 4 Feb 2004 15:40:55 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040204204055.GA8434@joehill.bostoncoop.net>
References: <20040203172413.GA1299@joehill.bostoncoop.net> <20040203143906.B33512@root.org> <20040203234141.GA8327@bostoncoop.net> <20040204103226.GI882@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040204103226.GI882-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 04, 2004 at 11:32:26AM +0100, Bruno Ducrot wrote:
> > > We moved to a 100 ms timeout on EC requests for FreeBSD because some
> > > devices just couldn't respond quicker.  But I think there's a larger issue
> #define ACPI_EC_UDELAY_COUNT	10000

I tried this patch, and it does prevent the AE_TIME error. 

The battery charge indicator now seems unreliable, however, after
switching from AC to battery and back.  For example, it will drop from
70%-80% down to 2% fairly quickly, but I can still run the machine for
quite a while at 2%.  It also has jumped from 80% up to 100% in a couple
of minutes, much faster than it could actually charge.

I'm not sure if any of this is related to the AE_TIME problem, but I'm
putting it out here to see if there are any ideas.
-- 
Adam Kessel
http://bostoncoop.net/adam


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
