From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH v2 0/3] ACPI: Support generic initiator proximity domains
Date: Mon, 1 Apr 2019 23:36:00 +0800
Message-ID: <20190401153603.67775-1-Jonathan.Cameron@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mm@kvack.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: keith.busch@intel.com, jglisse@redhat.com, rjw@rjwysocki.net, linuxarm@huawei.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-Id: linux-acpi@vger.kernel.org

Changes since RFC V1.
* Fix incorrect interpretation of the ACPI entry noted by Keith Busch
* Use the acpica headers definitions that are now in mmotm.

It's worth noting that, to safely put a given device in a GI node, may
require changes to the existing drivers as it's not unusual to assume
you have local memory or processor core. There may be futher constraints
not yet covered by this patch.

Original cover letter...

ACPI 6.3 introduced a new entity that can be part of a NUMA proximity domain.
It may share such a domain with the existing options (memory, cpu etc) but it
may also exist on it's own.

The intent is to allow the description of the NUMA properties (particulary
via HMAT) of accelerators and other initiators of memory activity that are not
the host processor running the operating system.

This patch set introduces 'just enough' to make them work for arm64.
It should be trivial to support other architectures, I just don't suitable
NUMA systems readily available to test.

There are a few quirks that need to be considered.

1. Fall back nodes
******************

As pre ACPI 6.3 supporting operating systems do not have Generic Initiator
Proximity Domains it is possible to specify, via _PXM in DSDT that another
device is part of such a GI only node.  This currently blows up spectacularly.

Whilst we can obviously 'now' protect against such a situation (see the related
thread on PCI _PXM support and the  threadripper board identified there as
also falling into the  problem of using non existent nodes
https://patchwork.kernel.org/patch/10723311/ ), there is no way to  be sure
we will never have legacy OSes that are not protected  against this.  It would
also be 'non ideal' to fallback to  a default node as there may be a better
(non GI) node to pick  if GI nodes aren't available.

The work around is that we also have a new system wide OSC bit that allows
an operating system to 'annouce' that it supports Generic Initiators.  This
allows, the firmware to us DSDT magic to 'move' devices between the nodes
dependent on whether our new nodes are there or not.

2. New ways of assigning a proximity domain for devices
*******************************************************

Until now, the only way firmware could indicate that a particular device
(outside the 'special' set of cpus etc) was to be found in a particular
Proximity Domain by the use of _PXM in DSDT.

That is equally valid with GI domains, but we have new options. The SRAT
affinity structure includes a handle (ACPI or PCI) to identify devices
with the system and specify their proximity domain that way.  If both _PXM
and this are provided, they should give the same answer.

For now this patch set completely ignores that feature as we don't need
it to start the discussion.  It will form a follow up set at some point
(if no one else fancies doing it).

Jonathan Cameron (3):
  ACPI: Support Generic Initiator only domains
  arm64: Support Generic Initiator only domains
  ACPI: Let ACPI know we support Generic Initiator Affinity Structures

 arch/arm64/kernel/smp.c        |  8 +++++
 drivers/acpi/bus.c             |  1 +
 drivers/acpi/numa.c            | 62 +++++++++++++++++++++++++++++++++-
 drivers/base/node.c            |  3 ++
 include/asm-generic/topology.h |  3 ++
 include/linux/acpi.h           |  1 +
 include/linux/nodemask.h       |  1 +
 include/linux/topology.h       |  7 ++++
 8 files changed, 85 insertions(+), 1 deletion(-)

-- 
2.18.0
