From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: SYM53c8xx 2.6.0-test1-ac3 ACPI IRQ mismatch?
Date: Sun, 27 Jul 2003 22:47:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030727214729.GV1485@parcelfarce.linux.theplanet.co.uk>
References: <20030725203921.GA13042@phobe.internal.pelicanmanufacturing.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030725203921.GA13042-1eOMRhGqMgJKbeVm7HAN69qV54RzO4zVaO4olKTeY8PqSFzvm+Tz3BCuuivNXqWP@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: James Bromberger <james-Q/PxBS77Xz0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jul 26, 2003 at 04:39:22AM +0800, James Bromberger wrote:
> I've been trying to get the SMB53C5XX scsi driver to detect my 
> LSI 1010-66 scsi adapter, and found that it fails to detect it completely
> under 2.6.0-test1-ac3 with the SMB53C8XX driver and ACPI turned on,
> however, it appears to work with ACPI disabled. Would anyone like any
> specific information from the card/logs? The controller has my root
> filesystem on an attached disk, so when it fails, I get an obvious
> kernel panic with root FS not found.

fwiw, the sym53c8xx driver is deprecated; can you try sym2 instead?

not that i think this will fix the problem ... so can you send the
output of cat /proc/interrupts with acpi enabled and disabled?  you may
wish to use NFS root to get to userspace ;-)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
