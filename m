From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] nfit, libnvdimm: fix and unit test isetcookie calculation
Date: Wed, 01 Mar 2017 01:11:19 -0800
Message-ID: <148835947931.28806.15339584183213827869.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Nick noticed that his implementation of the isetcookie calculation was
producing different results than the Linux enabling. Linux is broken in
its usage of memcmp() to sort the components of an array that is hashed
by a fletcher64 sum. See patch2 for more details.

Patch1 arranges for the unit test infrastructure to produce data that
sorts differently under the two schemes. The original simulated data was
masking this problem.

This implementation is tested with a new "ndctl write-labels" command.
It allows namespace labels with broken cookie values to be written and
validate that the compatibility code behaves as expected.

---

Dan Williams (2):
      tools/testing/nvdimm: make iset cookie predictable
      nfit, libnvdimm: fix interleave set cookie calculation


 drivers/acpi/nfit/core.c         |   16 +++++++++++++++-
 drivers/nvdimm/namespace_devs.c  |   18 ++++++++++++++----
 drivers/nvdimm/nd.h              |    1 +
 drivers/nvdimm/region_devs.c     |    9 +++++++++
 include/linux/libnvdimm.h        |    2 ++
 tools/testing/nvdimm/test/nfit.c |   14 +++++++-------
 6 files changed, 48 insertions(+), 12 deletions(-)
