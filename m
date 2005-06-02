From: rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Subject: [patch 0/2] Collecting host bridge resources - take 2
Date: Thu, 02 Jun 2005 15:41:47 -0700
Message-ID: <20050602224147.177031000@csdlinux-1>
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
To: gregkh-l3A5Bk7waGM@public.gmane.org, ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org, ak-l3A5Bk7waGM@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

ACPI hotplug code now uses the PCI core to allocate and manage
resources for hot-plug devices. To work correctly, this requires
all bridges to report resources they are decoding in their
pci_bus structure. We already do this for PCI-PCI bridges, but
not for host bridges. This patchset reads and stores host bridge
resources reported by ACPI BIOS for i386 and x86_64 systems.

This is the 2nd version of this patchset. The major change is
that it increases the number of resource pointers in the pci_bus
structure and eliminates the need to have a boot time parameter
to enable the code.

Andrew, if you add this to the next -mm, please also drop the
previous version this patchset (i386-collect-host-bridge-resources.patch
and x86_64-collect-host-bridge-resources.patch).

Rajesh
--


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
