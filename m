From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Handler for [EmbeddedControl] returned AE_TIME in
 2.6.1/20040116
Date: Tue, 3 Feb 2004 14:40:16 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040203143906.B33512@root.org>
References: <20040203172413.GA1299@joehill.bostoncoop.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040203172413.GA1299-H/G4Yv+sbq78nmnftgJBZjK0Oss5Xsdo@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adam Kessel <adam-/J5p37YCQWYytDrLOV7HaA@public.gmane.org>
Cc: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 3 Feb 2004, Adam Kessel wrote:
> I'm using 2.6.1 with the latest ACPI patch (20040116). When I switch from
> AC to battery or vice-versa, I get the following:
>
> ACPI-0347: *** Error: Handler for [EmbeddedControl] returned AE_TIME
> ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.ISA0.EC0_.SMWR] (Node d7f24f80), AE_TIME
> ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.ISA0.BAT1.CHBP] (Node d7f238e0), AE_TIME
> ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.ISA0.EC0_.SMSL] (Node d7f24f40), AE_TIME
> ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.ISA0.EC0_._Q09] (Node d7f24ea0), AE_TIME
>
> After that, ACPI no longer gives accurate information about the battery
> status (e.g., it will say "discharging" and a fixed amount of battery
> life left regardless of how much it has charged since the switch).

We moved to a 100 ms timeout on EC requests for FreeBSD because some
devices just couldn't respond quicker.  But I think there's a larger issue
somewhere here where interrupts are being lost.

-Nate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
