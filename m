From: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] Adding support to parse BERT for libnvdimm
Date: Thu, 29 Mar 2018 15:37:01 -0700
Message-ID: <152236282506.35558.2067249639136170490.stgit@djiang5-desk3.ch.intel.com>
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
To: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The following series implements support for parsing of the BERT records
and adding the error memory ranges to nvdimm badblocks in order for the
kernel to avoid prevent the kernel from accessing those areas. And with
the addition of this support, we can surface the nd regions instead of waiting
for ARS to complete. So the ARS handling is reworked to run in the
background and not block nd region registration.

---

Dave Jiang (4):
      acpi: add find error record in BERT function
      acpi/libnvdimm: search through BERT records and add to nvdimm badblocks
      acpi/nfit: removing ARS timeout and change scrubbing to delayed work
      acpi/nfit: allow knob to disable ARS being issued at kernel boot


 drivers/acpi/apei/bert.c  |  137 +++++++++++++++++++++---
 drivers/acpi/nfit/core.c  |  262 ++++++++++++++++++++-------------------------
 drivers/acpi/nfit/nfit.h  |   13 ++
 drivers/nvdimm/core.c     |    6 +
 include/linux/acpi.h      |   10 ++
 include/linux/libnvdimm.h |    1 
 6 files changed, 271 insertions(+), 158 deletions(-)

--
