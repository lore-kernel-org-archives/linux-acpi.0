From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/2] acpi,
 nfit: support for new NVDIMM_FAMILY_INTEL commands
Date: Mon, 30 Oct 2017 13:46:58 -0700
Message-ID: <150939641796.4577.379718469071595984.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Change since v1 [1]:
* Introduce NVDIMM_STANDARD_CMDMASK and NVDIMM_INTEL_CMDMASK to replace
  magic number usage in the driver. (Dave)

[1]: https://lists.01.org/pipermail/linux-nvdimm/2017-October/013082.html
---

The latest version of the NVDIMM_FAMILY_INTEL command set adds support
for firmware updates and setting SMART health alarms / thresholds among
other things. Given that these are command payloads that will only ever
be issued by userspace we only wire up the command numbers and revision
ids for use through the ND_CMD_CALL interface.

---

Dan Williams (2):
      acpi, nfit: hide unknown commands from nmemX/commands
      acpi, nfit: add support for NVDIMM_FAMILY_INTEL v1.6 DSMs


 drivers/acpi/nfit/core.c |   55 ++++++++++++++++++++++++++++++++++++++++------
 drivers/acpi/nfit/nfit.h |   32 ++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 8 deletions(-)
