From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: hibernate
Date: Tue, 5 Nov 2002 14:36:27 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A4B8@orsmsx119.jf.intel.com>
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
To: 'Chris Howells' <chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Chris Howells [mailto:chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org] 
> On Monday 04 November 2002 2:02 pm, Robert Woerle wrote:
> > btw hibernate is S4 ! S3 is the standby ( suspend to ram )
> Could somebody please explain what S1 and S2 are as well?

>From ACPI 2.0a spec section 2.4:

S1 Sleeping State
The S1 sleeping state is a low wake latency sleeping state. In this state,
no system context is lost (CPU or chip set) and hardware maintains all
system context.

S2 Sleeping State
The S2 sleeping state is a low wake latency sleeping state. This state is
similar to the S1 sleeping state except that the CPU and system cache
context is lost (the OS is responsible for maintaining the caches and CPU
context). Control starts from the processor's reset vector after the wake
event.

(no one uses S2, since it is so similar to S3)

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
