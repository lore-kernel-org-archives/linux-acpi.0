From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: [Fwd: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume
 on Centrino notebook (contains agp, lapic, swsusp)]
Date: Tue, 10 Feb 2004 11:32:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3oes76x8l.fsf@brain.gnuhh.org>
References: <1076374686.3429.1.camel@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1076374686.3429.1.camel-4/PLUo9XfK8@public.gmane.org> =?iso-8859-1?q?=28S=E9rgio?= Monteiro Basto's message of "Tue, 10 Feb 2004 00:58:06 +0000")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

 || On Tue, 10 Feb 2004 00:58:06 +0000
 || S=E9rgio Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org> wrote:=20

 >> If your laptop is one APIC victim, I think until this problem
 >> isn't resolved, suspend/resume also doesn't work, is my guess.

My laptop definitely experiences the ACPI+APIC troubles, but I'm not
sure whether that is what you refer to as "victim." :)

However: suspend/resume _almost_ work under 2.6.x -- the problem is
the AGP code, it seems.=20

If I disable AGP, DRM/DRI and the intel framebuffer (which depends on
intel AGP! vesa fb is activated and works, though), compile at least
yenta_socket as a module, I can do suspend to disk (swsusp2) on kernel
2.6.2 and resume even while X11 is running.

The moment I enable AGP (no DRM/DRI, no intel fb), things break.

As for S1/S3, it seems that S1 is almost/more or less working, but I
can only wake up the machine with the power button and that creates an
event to shut down the machine. :-/ Oh yeah: and the keyboard is
broken after resume from S1.

On S3, the machine comes back up -- apparently with working keyboard,
although I can't be 100% sure -- and the screen is dead. After typing
"ifup eth0" on the console I can log into it over the network,
though. :)

On the swsusp2 list, someone made a survey and found out that noone
has AGP working on 2.6.x for their Centrino notebooks. So the problem
really seems to be with the graphics/AGP/ACPI support of the Intel
855GM/PM chipsets.

Is there any way people can help to make sure someone finds the time
to look into this?

Regards,
Georg

--=20
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
