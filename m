From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/9] libnvdimm, label: namespace specification v1.2 support
Date: Thu, 08 Jun 2017 22:08:50 -0700
Message-ID: <149698493023.11651.13036549892428981091.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14157 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751479AbdFIFPT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Jun 2017 01:15:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The recently released UEFI 2.7 Specification [1], includes an updated
version (v1.2) of the NVDIMM Namespace Label Specification that was previously
published on pmem.io [2] (v1.1).

In the process of moving to a UEFI standard definition the v1.2 updates
adds several features for improved cross-OS and pre-OS (EFI driver)
compatibility and safety. The major highlights include:

1/ Support for an "address abstraction guid" so that implementations can
   uniquely identify personalities layered on top of a namespace. A
   standard address abstraction definition example is the BTT (Block
   Translation Table for sector atomicity) layout. A private / local
   abstraction definition example is the Linux device-DAX personality.

2/ Checksums for individual label slots

3/ Additional safety and self-consistency properties like an updated
   interleave-set-cookie algorithm and recording the NFIT address-type-guid
   in the namespace.

UEFI mandates that these labels be accessed through new ACPI methods
_LSI, _LSR, and _LSW (Label Storage {Info,Read,Write}), however support
for those is saved for a later patch series once the ACPICA enabling for
ACPI 6.2 lands in an immutable form in the acpi tree.

These updates pass a run through the nvdimm unit tests and an updated
version of the tests targeting the address-abstraction guid. This set is
based on the 'uuid-types' branch of git.infradead.org/users/hch/uuid.git
which includes Christoph's and Andy's revamp of the kernel's uuid + guid
helper routines.

[1]: http://www.uefi.org/sites/default/files/resources/UEFI_Spec_2_7.pdf
[2]: http://pmem.io/documents/NVDIMM_Namespace_Spec.pdf

---

Dan Williams (9):
      libnvdimm, label: add v1.2 nvdimm label definitions
      libnvdimm, label: add v1.2 interleave-set-cookie algorithm
      libnvdimm, label: honor the lba size specified in v1.2 labels
      libnvdimm, label: populate the type_guid property for v1.2 namespaces
      libnvdimm, label: populate 'isetcookie' for blk-aperture namespaces
      libnvdimm, label: update 'nlabel' and 'position' handling for local namespaces
      libnvdimm, label: add v1.2 label checksum support
      libnvdimm, label: add address abstraction identifiers
      libnvdimm, label: switch to using v1.2 labels by default


 drivers/acpi/nfit/core.c        |   67 +++++++++--
 drivers/nvdimm/btt_devs.c       |    8 +
 drivers/nvdimm/claim.c          |   28 ++++
 drivers/nvdimm/core.c           |    3 
 drivers/nvdimm/dax_devs.c       |    8 +
 drivers/nvdimm/label.c          |  244 +++++++++++++++++++++++++++++++++++----
 drivers/nvdimm/label.h          |   20 +++
 drivers/nvdimm/namespace_devs.c |  211 +++++++++++++++++++++++++++++-----
 drivers/nvdimm/nd.h             |   13 ++
 drivers/nvdimm/pfn_devs.c       |    8 +
 drivers/nvdimm/pmem.c           |    1 
 drivers/nvdimm/region_devs.c    |   43 ++++++-
 include/linux/libnvdimm.h       |    8 +
 include/linux/nd.h              |   12 ++
 14 files changed, 596 insertions(+), 78 deletions(-)
