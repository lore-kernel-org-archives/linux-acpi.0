From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: S3 wakeup code
Date: Thu, 31 Jul 2003 11:20:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030731092000.GA425@elf.ucw.cz>
References: <20030723152809.GA591@paradigm.rfc822.org> <20030723162423.GD9013@atrey.karlin.mff.cuni.cz> <1059041888.19684.8.camel@bacchus.gpphy.uni-duesseldorf.de> <20030724104518.GA12041@paradigm.rfc822.org> <20030724110048.GA312@elf.ucw.cz> <1059588521.539.3.camel@localhost> <20030730182250.GL10276@atrey.karlin.mff.cuni.cz> <1059607485.535.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1059607485.535.7.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Cc: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Am Mi, 2003-07-30 um 20.22 schrieb Pavel Machek:
> > the code works as expected. Then send me diff -u wakeup.S.old
> 
> Attached. Code works. Still nothing after resume though - I rememeber
> someone debugging S3 via parport/serial so I dont think its still
> powered down. 

Sorry, I do not see anything attached.

On two of my machines, even video is up and running when we enter
acpi_wakeup_vector. Machines differ in these little details :-(.

> Actually changing _set_wakeup_vector ((acpi_physical_address)
> acpi_wakeup_vector)) to _set_wakeup_vector ((acpi_physical_address) 0))
> gives the very same result on resume. 

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
