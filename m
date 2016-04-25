From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v3 0/2] Support ACPI 6.1 update in NFIT Control Region Structure
Date: Mon, 25 Apr 2016 15:34:57 -0600
Message-ID: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, dan.j.williams@intel.com
Cc: robert.moore@intel.com, elliott@hpe.com, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure as
follows.
 - Valid Fields, Manufacturing Location, and Manufacturing Date
   are added from reserved range.  No change in the structure size.
 - IDs (SPD values) are stored as arrays of bytes (i.e. big-endian
   format).  The spec clarifies that they need to be represented
   as arrays of bytes as well.

Patch 1 changes the NFIT driver to comply with ACPI 6.1.
Patch 2 adds a new sysfs file "id" to show NVDIMM ID defined in ACPI 6.1.

The patch-set applies on linux-pm.git acpica.

link: http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf

---
v3:
 - Need to coordinate with ACPICA update (Bob Moore, Dan Williams)
 - Integrate with ACPICA changes in struct acpi_nfit_control_region.
   (commit 138a95547ab0)

v2:
 - Remove 'mfg_location' and 'mfg_date'. (Dan Williams)
 - Rename 'unique_id' to 'id' and make this change as a separate patch.
   (Dan Williams)

---
Toshi Kani (3):
 1/2 acpi/nfit: Update nfit driver to comply with ACPI 6.1
 2/3 acpi/nfit: Add sysfs "id" for NVDIMM ID

---
 drivers/acpi/nfit.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)
