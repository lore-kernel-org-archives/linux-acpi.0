From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: ACPI Status
Date: Fri, 13 Sep 2002 15:02:45 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE63@orsmsx119.jf.intel.com>
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
To: 'Matthew Wilcox' <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: 'Marc Giger' <gigerstyle-OI3hZJvNYWs@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Matthew Wilcox [mailto:willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org] 
> One thing I'm not clear about is status of support for ACPI 2.0.
> The FAQ on intel's website claims support for ACPI 1.0b only with 2.0
> "in development", but it seems rather out of date.

ACPI 2.0 introduced new objects as well as AML grammar elements.

The interpreter is ACPI 2.0 grammar compliant (modulo bugs). A separate
matter is writing the code to take advantage of new objects.

We only take advantage of some ACPI 2.0 objects currently. (Indeed, we don't
take advantage of all ACPI 1.0 objects.)

Examples of some ACPI 1.0 objects we use: thermal zones, battery, embedded
controller
Examples of some ACPI 1.0 objects we don't use (yet): device power
management, smart battery

Examples of some ACPI 2.0 objects we use: XSDT, ECDT, processor performance
state objects
Examples of some ACPI 2.0 objects we don't use (yet): _PXM, _CST, _HPP

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
