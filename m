From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] Add CONFIG_ACPI_RELAXED_AML option
Date: Fri, 13 Dec 2002 14:31:18 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A597@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Craig Whitmore' <lennon-q3Ck4f9/EBK9koe0gwxAeg@public.gmane.org>, Matthew Tippett <matthew-+XluyfkzffvQT0dZR+AlfA@public.gmane.org>, chbm-tNiY1ywYjSU@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Craig Whitmore [mailto:lennon-q3Ck4f9/EBK9koe0gwxAeg@public.gmane.org] 
> > > distributed in windows drivers.
> >
> > Continuing with this thread, would it make sense to be ACPI 
> compliant
> > but allow 'custom' dsdts to be passed to the acpi subsystem to allow
> > users to work around less than perfect implementations from
> > manufacturers.
> >
> 
> Just 1 question. What do the manufacturer's say when you tell 
> them they have
> a "broken" dsdt? Do they normally fix it? or give some excuse 
> in a reason
> why they won't fix it?

It varies. BIOS bugs exposed by Linux may be prioritized lower due to
Linux's market position in laptops. They also may not get attention if they
are on end-of-lifed machines, or rolled into a BIOS update only when enough
other bugs are fixed to justify a new BIOS's validation and release. (We may
*say* to them it is a trivial fix, but the only way to know if it breaks
Windows is for them to test it!)

There also isn't always a clear way to report BIOS bugs from end users.

On the upside, the things we're seeing are almost always obviously wrong and
easy to fix - it's just getting them to make the trivial change.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
