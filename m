From: iain d broadfoot <ibroadfo-jbDEWmSD8rMwZN84zEGlPg@public.gmane.org>
Subject: [PATCH] Re: 20030619 broken, or is it me?
Date: Sun, 22 Jun 2003 15:50:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030622145014.GA5346@iain-vaio-fx405>
References: <20030621032659.GA923@iain-vaio-fx405> <3EF3D289.7030400@nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3EF3D289.7030400-P1JKnMZDrucAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Richard L. Mitchell" <rmitchel-P1JKnMZDrucAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

* Richard L. Mitchell (rmitchel-P1JKnMZDrucAvxtiuMwx3w@public.gmane.org) wrote:
> iain d broadfoot wrote:
> >latest acpi seems to not want any of the suboptions to be live (AC,
> >button, etc, etc), i get no boot msgs about acpi at all, and no
> >/proc/acpi exists.
> >
> >I'm not sure if my laptop would have died or not from the heat, i didn't
> >want to take the chance. :D
> >
> >20030522 works fine for me - using a clean 2.4.21 tree for both, except
> >the .config - and the only diff there is the CONFIG_ACPI_* stuff.
> >(i copied the working file into the new tree, and did 'make oldconfig')
> >
> >flames welcome.
> >
> >iain
> 
> I took out the #ifdef/#endif around the CPU Enumeration Only boolean in 
> drivers/acpi/Config.in.  The options then showed up in make xconfig and 
> I enabled them.  Things seemed to be fine after that.

yep, patch attached that works for me.

iain

-- 
wh33, y1p33 3tc.

"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -St. Augustine


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
