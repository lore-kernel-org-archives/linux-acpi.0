From: rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Subject: [patch 0/2] Collecting host bridge resources
Date: Fri, 20 May 2005 17:42:39 -0700
Message-ID: <20050521004239.581618000@csdlinux-1>
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
To: ak-l3A5Bk7waGM@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

ACPI hotplug code now uses the PCI core to allocate and manage
resources for hot-plug devices. To work correctly, this requires
all bridges to report resources they are decoding in their
pci_bus structure. We already do this for PCI-PCI bridges, but
not for host bridges. This patchset reads and stores host bridge
resources reported by ACPI BIOS for i386 and x86_64 systems.
Without this, we currently assume that all host bridges decode
all unused resources in iomem_resource and ioport_resource.
This patchset also adds a boot parameter (acpi=root_resources),
and the code to collect resources does not trigger unless it
is enabled via this boot option. This fixes hotplug failures
on some IBM (xseries) systems, and has been previously discussed
on the pci hotplug mailing list.

The current pci_bus structure can only store 4 resource
descriptors for a bus, but many host bridges decode more than 4
ranges. Storing incomplete host bridges resource ranges could
lead to resource-not-available errors for devices that were
otherwise properly configured by BIOS. Hence, this code triggers
only when it is explicitly enabled using the acpi=root_resources
boot option. For now, I expect that only systems that have PCI
hotplug slots directly under a host bridge will enable this option.

Rajesh

--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
