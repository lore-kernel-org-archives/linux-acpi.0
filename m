From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/5] libnvdimm: fix locked status detection
Date: Tue, 10 Apr 2018 15:39:09 -0700
Message-ID: <152339994885.16061.1760220735664848631.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: stable@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The new ACPI _LSx methods moved the 'dimm locked' error status from the
result of ND_CMD_GET_CONFIG_SIZE to an error status result of
ND_CMD_GET_CONFIG_DATA. Error code translation prevents the proper error
code from making it back to the 'nd_dimm' driver.

Fix the error code propagation and add some unit test infrastructure for
regression testing this case.

---

Dan Williams (5):
      libnvdimm, dimm: handle EACCES failures from label reads
      tools/testing/nvdimm: allow custom error code injection
      tools/testing/nvdimm: support nfit_test_dimm attributes under nfit_test.1
      tools/testing/nvdimm: fix missing newline in nfit_test_dimm 'handle' attribute
      tools/testing/nvdimm: enable labels for nfit_test.1 dimms


 drivers/nvdimm/dimm_devs.c       |   22 +++++-----
 tools/testing/nvdimm/test/nfit.c |   84 +++++++++++++++++++++++++++++---------
 2 files changed, 77 insertions(+), 29 deletions(-)
