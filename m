From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Date: Mon, 23 May 2005 17:57:08 -0700
Message-ID: <20050523175706.A12032@unix-os.sc.intel.com>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1> <20050523161507.GN16164@wotan.suse.de>
Reply-To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050523161507.GN16164-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>; from ak-l3A5Bk7waGM@public.gmane.org on Mon, May 23, 2005 at 06:15:07PM +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, May 23, 2005 at 06:15:07PM +0200, Andi Kleen wrote:
> On Fri, May 20, 2005 at 05:42:41PM -0700, rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org wrote:
> > This patch reads and stores host bridge resources reported by
> > ACPI BIOS for x86_64 systems. This is needed since ACPI hotplug
> > code now uses the PCI core for resource management. This patch
> > simply adds the boot parameter (acpi=root_resources) to enable
> > the functionality that is implemented in arch/i386.
> > 
> 
> This means all hot plug users have to pass this strange parameter?
> That does not sound very user friendly. Especially since you usually
> only need pci hotplug in emergencies, and then you likely didnt pass it.
> 
> Cant you find a way to do this without parameters? Any reason
> to not make it default?
> 
I found several systems in which the host bridge was decoding 6+
resource ranges. In the pci_bus structure, I only have room for 4,
so I'm forced to drop some ranges that are in fact being passed
down. For such cases, if I enable this by default, I see boot time
failures for devices that attempted to claim these dropped resources.
These devices were otherwise properly configured by BIOS, and work
fine with today's (incorrect) assumption that all host bridges
decode all unclaimed resources. I didn't want the patch to break
existing systems, hence the boot parameter.

Another option I'd thought of but never really pursued was to
implement this as a late_initcall. I'll look into that some more.
In that case, we'd continue to think that all host bridges decode
all unclaimed resources at boot time and depend on BIOS to program
resources for boot time devices correctly. Later, we'd collect the
more accurate host bridge resource picture to make hotplug work
correctly. Kind of hackish, but I can't think of another way to
avoid the boot parameter.

Rajesh



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
