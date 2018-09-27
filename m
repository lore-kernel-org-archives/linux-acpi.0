From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] acpi, nfit: Add dirty shutdown count to sysfs
Date: Wed, 26 Sep 2018 21:24:20 -0700
Message-ID: <153802226065.833068.11943510429252969385.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The Intel NVDIMM command specification publishes a dirty-shutdown-count
in addition to the dirty-shutdown / flush-failed indication that comes
from the ACPI NFIT. This is expected to be a common property of NVDIMMs
and is a static hardware health detail to be cached / exported via
sysfs.

Add plumbing for retrieving this data at driver load time, publish the
count, and use the dynamically retrieved dirty-shutdown indicator to
augment the existing 'flush_failed' flag.

---

Dan Williams (3):
      acpi, nfit: Introduce nfit_mem flags
      acpi, nfit: Collect shutdown status
      tools/testing/nvdimm: Populate dirty shutdown data


 drivers/acpi/nfit/core.c              |  115 ++++++++++++++++++++++++++++-----
 drivers/acpi/nfit/intel.h             |   34 ++++++++++
 drivers/acpi/nfit/nfit.h              |   11 +++
 tools/testing/nvdimm/Kbuild           |    1 
 tools/testing/nvdimm/acpi_nfit_test.c |    8 ++
 tools/testing/nvdimm/test/nfit.c      |    3 +
 tools/testing/nvdimm/test/nfit_test.h |   24 -------
 7 files changed, 152 insertions(+), 44 deletions(-)
