From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: Performance states
Date: Wed, 16 Jul 2003 08:14:30 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030716061430.GA1173@brodo.de>
References: <1058306533.1488.3.camel@LNX.iNES.RO>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1058306533.1488.3.camel-oUgHV0DytZclPyoCK6TguA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu-6Lf+m/H07rc@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 16, 2003 at 01:02:13AM +0300, Dumitru Ciobarcianu wrote:
> 
> Hello,
> 
> While trying to test 2.6-test1 kernel I found that I don't have anymore
> the performance management for my CPU.
> 
> Is is something I forgot to enable (triplechecked first....) ?
> 
> >From 2.4+acpi patch dmesg: 
> ACPI: Processor [CPU0] (supports C1 C2 C3, 2 performance states)
> 
> >From 2.6-test1 dmesg:
> ACPI: Processor [CPU0] (supports C1 C2 C3)
> 
> Where did the performance states went ? :)

They went to CONFIG_CPU_FREQ and CONFIG_X86_ACPI_CPUFREQ. However, there are
a few bugs in the X86_ACPI_CPUFREQ driver which I'll try to solve the next
few days.

	Dominik


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
