From: Casey Harkins <charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org>
Subject: RE: /proc/battery empty on Gateway 400VTX
Date: Wed, 8 Oct 2003 15:25:21 -0500 (CDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0310081507350.31130-100000@data.upl.cs.wisc.edu>
References: <Pine.LNX.4.44.0310081413530.30594-100000@data.upl.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0310081413530.30594-100000-j0XSImJ06nG869pVMd/zofZ8FUJU4vz8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Wed, 8 Oct 2003, Casey Harkins wrote:
>
> On Wed, 8 Oct 2003, Li, Shaohua wrote:
> >
> > Hi,
> >    Your BIOS lacks ECDT. Maybe you should provide an ECDT according to EC device.
> >
> > Thanks,
> > Shaohua
>
>
> How would I go about doing this? I'll google around a bit and see what I
> can figure out.
>

I tried using the pmtools acpidmp tool to dump the ecdt, but obviously
since the bios lacks one it doesn't dump one. I have no clue on how to
provide an ecdt for the ec device. I'm assuming this would involve getting
specs for the ec on this particular machine, writing asl describing the
ec, compiling and patching it into the kernel (similar to replacing bad
dsdt's). Am I on the right track here?

I dug around and found a few more details which may or may not help.

Gateway's specs for this laptop [1] state:

Bios:
        Advanced Configuration and Power Interface 1.0b (ACPI 1.0b)
        support

Battery type:
        Embedded controller inside to support smart battery

Power Management:
        Advanced Configuration and Power Interface 1.0b or later
        (ACPI 1.0b or later) support

I also found this [2] lkml post which suggests that ECDT is a feature of
ACPI 2.0 and that smart batteries are a 1.0 feature that aren't currently
supported in the Linux kernel. This message is from September 2002, so the
support for smart battery objects may have changed.

Anyway, is it possible that this notebook does not support acpi 2.0 and
therefore the only method for retrieving the battery status is through the
smart battery acpi 1.0 object?

I'm pretty much acpi ignorant at this point, so any help is appreciated.
I'll sit down and try to read over the specs this afternoon to see if I
can become less acpi ignorant!


-casey



[1] http://support.gateway.com/s/Mobile/Gateway/400VTX/3501331sp47.shtml
[2] http://www.ussg.iu.edu/hypermail/linux/kernel/0209.1/1566.html



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
