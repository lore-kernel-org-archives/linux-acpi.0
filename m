From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.5.51: sleep broken
Date: Thu, 12 Dec 2002 14:42:17 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A591@orsmsx119.jf.intel.com>
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
To: "'P. Christeas'" <p_christ-U04EIuiosng@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: P. Christeas [mailto:p_christ-U04EIuiosng@public.gmane.org] 
> > However, /proc/acpi/sleep has all S0 S1 S2 S3 S4 S5
> > When I 'echo 1 >/proc/acpi/sleep', nothing happens.
> > I'll let you know if I have more details..
> I noticed I had some extra dbg code to indicate what's 
> happening in the procfs 
> level.
> Now, it seems that "1" doesn't get written to the acpi/sleep 
> entry. It's a 
> procfs bug.

Look for a msg on 11/30 by Pavel Machek. Apparently the proc code got broken
by the seq_file stuff... supposedly they were going to fix it, but maybe it
would be easier if we all did.

-		entry->write_proc = acpi_system_write_sleep;
+		entry->proc_fops->write = acpi_system_write_sleep;

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
