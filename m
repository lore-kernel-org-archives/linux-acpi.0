From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: Invalid PBLK length for athlon XP-M on Asus laptop
Date: Sat, 23 Aug 2003 18:34:23 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030823173423.GQ18834@parcelfarce.linux.theplanet.co.uk>
References: <20030823125812.GC913@renditai.milesteg.arr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030823125812.GC913-NEF1zNAYzIZdX/d59Nv3Af5+YKd4R9zs@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Aug 23, 2003 at 02:58:12PM +0200, Daniele Venzano wrote:
> Since this is a laptop it seemed a bit strange to me 8), so I checked
> dmesg with acpi debugging turned on (full dmesg is attached), and I
> found these:
> 
> [.....]
> ACPI: Fan [FAN0] (on)
> acpi_processor-1626 [30] acpi_processor_get_inf: Invalid PBLK length [5]

This is a bug in your ACPI bios, you need a vendor update.  We tried
fixing this but it broke a number of laptops, so we had to revert it.

> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> acpi_processor_perf-0104 [28] acpi_processor_get_per: Unsupported address space [127] (control_register)
> cpufreq: No CPUs supporting ACPI performance management found.

That means that you need a non-acpi driver for perf throttling.  Did you
try enabling some of the other cpufreq drivers?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
