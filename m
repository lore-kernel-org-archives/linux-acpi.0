From: Mark Santcroos <marks-h3GR0owD+wQ@public.gmane.org>
Subject: Re: S3 wakeup code
Date: Fri, 25 Jul 2003 19:20:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030725172011.GD668@laptop.6bone.nl>
References: <20030725133800.GB668@laptop.6bone.nl> <Pine.LNX.4.44.0307250936080.3334-100000@puppy.afrinc.com> <20030725153110.GD310@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030725153110.GD310-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: David G Hamblen <dave-RfZrpLcwWZ/QT0dZR+AlfA@public.gmane.org>, "M. Warner Losh" <imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org>, flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 25, 2003 at 05:31:10PM +0200, Pavel Machek wrote:
> I believe you need to use specific kernel fb driver, and write
> suspend/resume code for it :-(.

I did it once for my ATI Radeon 7500, I will look it up and post it here.

Mark

-- 
Mark Santcroos                    RIPE Network Coordination Centre
http://www.ripe.net/home/mark/    New Projects Group/TTM


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
