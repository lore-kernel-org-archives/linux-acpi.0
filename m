From: Manuel J.Galan <mjgalan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: What is CFGD for?
Date: Mon, 16 May 2005 00:46:43 +0000 (UTC)
Message-ID: <loom.20050516T022519-56@post.gmane.org>
References: <42820E57.7030309@altern.org> <loom.20050514T041524-961@post.gmane.org> <4287CB22.6070306@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

DJAX <djax@...> writes:

> 
> --------------------------8<-------------------------
> ACPI: Processor [CPU0] (supports 8 throttling states)
> acpi_processor-0484 [07] acpi_processor_get_inf: Error getting cpuindex
> for acpi
> id 0x1
> ACPI: Thermal Zone [THRM] (41 C)
> -------------------------->8-------------------------

Hello,

Mine is a Travelmate 8104WLMi and I see this on booting.
----------------------------------------------------
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (54 C)
----------------------------------------------------

I am using kernel 2.6.11-1.1312_FC3 from
http://people.redhat.com/davej/kernels/Fedora/FC4/SRPMS.kernel/
compiled for FC3 and also including the two patches that are needed to include
DSDT.aml into the initrd (urls are broken in two lines...)

http://gaugusch.at/acpi-dsdt-initrd-patches/
acpi-dsdt-initrd-patch-v0.7d-2.6.9.patch

http://gaugusch.at/acpi-dsdt-initrd-patches/
acpi-dsdt-initramfs-fix-2.6.10-cleanup.patch

Following the instructions in the page 

http://gaugusch.at/kernel.shtml

to create the initrd.

Your error seems to me that is due to the acpi implementation of the 
kernel that you are using...

You can get and compare the dsl that I am using from

http://acpi.sourceforge.net/dsdt/tables/ACER/
Travelmate_8100/ACER-Travelmate_8100-3C22-custom.asl.gz

The only thing that I cannot make work is the O2micro memorycard reader :-(

Rgds.



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
