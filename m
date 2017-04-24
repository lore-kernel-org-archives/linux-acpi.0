From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 0/2] libnvdimm: export wpq flush interface
Date: Mon, 24 Apr 2017 16:49:51 -0700
Message-ID: <149307779085.7155.436029631521340565.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:64148 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S979267AbdDXXzo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Apr 2017 19:55:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, linux-acpi@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Changes since v1 [1]:
* Clean up the changelog to clarify how this capability is expected to
  be used (Jeff)
* Make the attribute read / write to separate detection and flush
  triggering (Masayoshi)
* Add the flush hint detection crash fix

[1]: https://lists.01.org/pipermail/linux-nvdimm/2017-April/009898.html

---

Quoting the changelog from patch2:

The nvdimm_flush() mechanism helps to reduce the impact of an ADR
(asynchronous-dimm-refresh) failure. The ADR mechanism handles flushing
platform WPQ (write-pending-queue) buffers when power is removed. The
nvdimm_flush() mechanism performs that same function on-demand.

When a pmem namespace is associated with a block device, an
nvdimm_flush() is triggered with every block-layer REQ_FUA, or REQ_FLUSH
request. These requests are typically associated with filesystem
metadata updates. However, when a namespace is in device-dax mode,
userspace (think database metadata) needs another path to perform the
same flushing. In other words this is not required to make data
persistent, but in the case of metadata it allows for a smaller failure
domain in the unlikely event of an ADR failure.

---

Dan Williams (2):
      libnvdimm, region: fix flush hint detection crash
      libnvdimm, region: sysfs trigger for nvdimm_flush()


 drivers/nvdimm/region_devs.c |   52 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)
