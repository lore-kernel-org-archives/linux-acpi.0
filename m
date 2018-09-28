From: Joe Perches <joe@perches.com>
Subject: Bad MAINTAINERS pattern in section 'ACPI'
Date: Fri, 28 Sep 2018 14:50:53 -0700
Message-ID: <20180928215054.28561-1-joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Keith Busch <keith.busch@intel.com>
List-Id: linux-acpi@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	308	ACPI
	309	M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
	310	M:	Len Brown <lenb@kernel.org>
	311	L:	linux-acpi@vger.kernel.org
	312	W:	https://01.org/linux-acpi
	313	Q:	https://patchwork.kernel.org/project/linux-acpi/list/
	314	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
	315	B:	https://bugzilla.kernel.org
	316	S:	Supported
	317	F:	drivers/acpi/
	318	F:	drivers/pnp/pnpacpi/
	319	F:	include/linux/acpi.h
	320	F:	include/linux/fwnode.h
	321	F:	include/acpi/
	322	F:	Documentation/acpi/
	323	F:	Documentation/ABI/testing/sysfs-bus-acpi
	324	F:	Documentation/ABI/testing/configfs-acpi
	325	F:	drivers/pci/*acpi*
	326	F:	drivers/pci/*/*acpi*
-->	327	F:	drivers/pci/*/*/*acpi*
	328	F:	tools/power/acpi/

Commit that introduced this:

commit 15fd830dd310e6cf589478e5e1e7733caf68e777
 Author: Bjorn Helgaas <bhelgaas@google.com>
 Date:   Wed Jun 26 13:38:37 2013 -0600
 
     MAINTAINERS: Add ACPI folks for ACPI-related things under drivers/pci
     
     Add file patterns so get_maintainers.pl reports both PCI and ACPI folks
     for ACPI-related things in drivers/pci.
     
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
     Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
  MAINTAINERS | 3 +++
  1 file changed, 3 insertions(+)

Last commit with drivers/pci/*/*/*acpi*

commit 256a459370930bed087f92bb763517f8b09407eb
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Jun 8 08:39:45 2018 -0500

    PCI/AER: Squash aerdrv_acpi.c into aerdrv.c
    
    Squash aerdrv_acpi.c into aerdrv.c.  No functional change intended.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Keith Busch <keith.busch@intel.com>

 drivers/pci/pcie/aer/Makefile      |   1 -
 drivers/pci/pcie/aer/aerdrv.c      | 122 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer/aerdrv_acpi.c | 141 -------------------------------------
 3 files changed, 122 insertions(+), 142 deletions(-)
