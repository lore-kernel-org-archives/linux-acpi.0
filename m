From: Ole Myren Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>
Subject: Re: resource for S3 suspend/resume of Radeon
Date: 17 Mar 2003 17:23:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3hea29d2d.fsf@pcpenn04.cern.ch>
References: <1047912152.28830.32.camel@dutidad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1047912152.28830.32.camel-1Jw6Eky0yc0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

"Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org> writes:

> benh and ATI seem to have fixed the suspension code of the radeon.

It is certainly encouraging to see that someone is working on the
radeon resume! The following comment calls however for some caution
when it comes to hoping that a direct port to an ACPI-based system
will work:

	* only supports the mobile chips in D2 mode, that is typically what
	* is used on Apple laptops,

If I'm guessing correctly, D2 is "clocks off, static registers
preserved" while ACPI/S3 certainly means D3 (power off) -> even more
device state to be restored.

> I don't have time to look at this right now, but will do so as soon as
> another lazy weekend comes up.

If you haven't already done so, you might want get access to the ATI
docs *before* your lazy weekend...

> If someone else has the time and inclination (Ole Rohne? ;), please
> go ahead!

I've resolved not to waste more time on it - at least for the
moment. And I'm quite happy with the POST-hack - dirty as it might
be...

Ole

PS: I've updated the patches at
<http://home.cern.ch/mrohne/P2120/P2120_Linux_S3.html> to
linux-2.5.64-bk11 and XFree86-4.3.0. I hope they're OK this time...


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
