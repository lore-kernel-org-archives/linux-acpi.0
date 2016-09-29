From: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] misc updates for Address Range Scrub
Date: Wed, 28 Sep 2016 18:10:08 -0600
Message-ID: <1475107811-8880-1-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Patch 1 changes the default behaviour on machine check exceptions to
just adding the error address to badblocks accounting instead of starting
a full ARS. The old behaviour can be enabled via sysfs.

Patch 2 and 3 fix a problem where stale badblocks could show up after an
on-demand ARS or an MCE triggered scrub because when clearing poison, we
didn't clear the internal nvdimm_bus->poison_list.


Vishal Verma (3):
  nfit: don't start a full scrub by default for an MCE
  pmem: reduce kmap_atomic sections to the memcpys only
  libnvdimm: clear the internal poison_list when clearing badblocks

 drivers/acpi/nfit/core.c  | 23 +++++++++++++--
 drivers/acpi/nfit/mce.c   | 24 ++++++++++++----
 drivers/acpi/nfit/nfit.h  |  6 ++++
 drivers/nvdimm/bus.c      |  2 ++
 drivers/nvdimm/core.c     | 73 ++++++++++++++++++++++++++++++++++++++++++++---
 drivers/nvdimm/pmem.c     | 28 ++++++++++++++----
 include/linux/libnvdimm.h |  2 ++
 7 files changed, 141 insertions(+), 17 deletions(-)

-- 
2.7.4
