From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Dell D600: teaching radeonfb how to wake up...
Date: Mon, 24 Nov 2003 12:30:45 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1069637444.703.114.camel@gaston>
References: <20031119180119.GB22307@tate.loria.fr>
	 <20031120111315.GB432@openzaurus.ucw.cz> <1069370504.705.32.camel@gaston>
	 <20031120234708.GA431@elf.ucw.cz> <1069374272.723.44.camel@gaston>
	 <20031121123239.GB9973@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031121123239.GB9973-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2003-11-21 at 23:32, Karol Kozimor wrote:
> Thus wrote Benjamin Herrenschmidt:
> > My point is that he can probably NOT do the work, POSTing such a
> > chip is hell. I'm trying to figure out how we are supposed to do,
> 
> Then how is Xfree86 doing that? I'm not sure if it's the whole chip that
> gets POSTed, or only the 3D engine, but something definitely is done at
> VT switch for the radeon driver (note: DRM module must be at least 1.9.0
> and the XFree part must also be recent).
> Best regards,

It's the whole chip, and I think an XFree based solution isn't an option
as the kernel own console would die on a non-POSTed chip before XFree
has a chance to kick in anyway.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
