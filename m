From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: RE: ACPI Thermal Shutdown on Boot
Date: Tue, 10 Feb 2004 22:01:32 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040210215906.H85854@root.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB690@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB690-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Chris Jensen <c-acpi-s2nexXcBJu3PC4JL755TaA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 11 Feb 2004, Yu, Luming wrote:
> > I'm trying to install kernel 2.6.2. However, as soon  as the
> > kernel starts
> > init, I get a message along the lines of "Critical
> > Temperature reached - 57C,
> > shutting down" and init switches to runlevel 0.
>
> -57C is an obvious error. Maybe there are something wrong with _TMP.

I think he just meant 57C.  In any case, we decided to set the _TMP poll
interval to 10 seconds.  After 2 readings above _CRT/_HOT, userland
receives an event and a message is logged saying the temperature is too
high.  On the 3rd one, we shutdown/power off the system.  I think Linux
chose something similar or at least I saw patches for that.

But 57C (or even 67C) is pretty low for _CRT.  We should probably add an
override.

-Nate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
