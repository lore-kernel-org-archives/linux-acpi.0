From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: Problems installing ACPI
Date: Tue, 21 Jan 2003 17:04:50 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030121170450.GA2586@clara.net>
References: <1043083690.1702.15.camel@localhost.localdomain> <3E2C43D3.3020307@gmx.net> <3E2C70FB.1090905@gmx.net> <1043147191.1205.8.camel@gregers.imsb.au.dk> <3E2D372F.5040500@gmx.net> <1043161338.1284.14.camel@gregers.imsb.au.dk> <3E2D722C.5090508@gmx.net> <1043167032.1763.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1043167032.1763.4.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Brix Folsted Andersen <folsted-TJNDrJVYK8B/SzgSGea1oA@public.gmane.org>
Cc: Heiko Ettelbrueck <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Christian Brix Folsted Andersen [folsted-TJNDrJVYK8B/SzgSGea1oA@public.gmane.org] wrote:
> Hi Heiko
> 
> I have both the files:
> 
> /proc/acpi/battery/state:
> /proc/acpi/battery/info:I

> > > Your computer seems to have a partial ACPI installation
> > > probably ACPI was enabled, but some of the sub-option
> > > were not enabled - you need to enable at least 'AC Adaptor'
> > > and 'Control Method Battery' and rebuild your kernel

Alternatives are to patch klaptopdaemon for the right paths or
upgrade to KDE3.1 where it has been fixed.

You may prefer to put up with it until KDE3.1 has been officially
released (expected soon).

There is a patch on my website which I have used previously, although it
is not well written.  I found it by digging around the web.

http://dude.noc.clara.net/~faye/


Faye



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
