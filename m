From: Mark Santcroos <marks-h3GR0owD+wQ@public.gmane.org>
Subject: Re: S3 wakeup code
Date: Fri, 25 Jul 2003 15:38:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030725133800.GB668@laptop.6bone.nl>
References: <20030723162423.GD9013@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0307250755460.2827-100000@puppy.afrinc.com> <20030725.072504.126452882.imp@bsdimp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030725.072504.126452882.imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "M. Warner Losh" <imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org>
Cc: dave-RfZrpLcwWZ/QT0dZR+AlfA@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 25, 2003 at 07:25:04AM -0600, M. Warner Losh wrote:
> In message: <Pine.LNX.4.44.0307250755460.2827-100000-zmH7q5lE+0tBz13eCZem0Q@public.gmane.org>
>             David G Hamblen <dave-RfZrpLcwWZ/QT0dZR+AlfA@public.gmane.org> writes:
> : S3 refrigerates everything and suspends, leaving the display white.
> : Resuming turns the backlight off.  I can retrieve the backlight with the
> : LCD/CRT button.
> 
> I've seen exactly the same problem under FreeBSD which has supported
> S3 state for a long time.  I've seen the problem going back at least 9
> months.

This needs to be handled by the video driver afaik.

Mark

-- 
Mark Santcroos                    RIPE Network Coordination Centre
http://www.ripe.net/home/mark/    New Projects Group/TTM


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
