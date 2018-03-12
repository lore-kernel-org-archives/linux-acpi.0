From: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/5 V3] Teach EDAC about non-volatile DIMMs and add partial
 support to skx_edac
Date: Mon, 12 Mar 2018 11:24:25 -0700
Message-ID: <20180312182430.10335-1-tony.luck@intel.com>
References: <CAPcyv4iHr9nUAS0SiFeqqDkU8NXZ_x=rkD3YS010Dy-nbHJXmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAPcyv4iHr9nUAS0SiFeqqDkU8NXZ_x=rkD3YS010Dy-nbHJXmA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Add support for non-volatile DIMMS
[Repost with fixes from Ross Zwisler and Jean Delvare's comments]

Changes since previous version:

Parts 1-2 unchanged since last post
Part    3 Use new SPDX license header for new file include/acpi/nfit.h
Part    4 Fix some ~0ul that should be ~0ull
Part    5 Rationalize error handling for various different reasons
          that we didn't find the size of a non-volatile DIMM
          Fix some printk formats.
          Fix test for ~0ul that should be ~0ull
          Re-order code to avoid computing number of pages twice

Dan gave the thumb's up to run part 3 through the EDAC tree.

Tony Luck (5):
  EDAC: Drop duplicated array of strings for memory type names
  edac: Add new memory type for non-volatile DIMMs
  acpi, nfit: Add function to look up nvdimm device and provide SMBIOS
    handle
  firmware: dmi: Add function to look up a handle and return DIMM size
  EDAC, skx_edac: Detect non-volatile DIMMs

 drivers/acpi/nfit/core.c     | 27 ++++++++++++++++++
 drivers/edac/Kconfig         |  5 +++-
 drivers/edac/edac_mc.c       | 41 +++++++++++++--------------
 drivers/edac/edac_mc_sysfs.c | 26 ++---------------
 drivers/edac/skx_edac.c      | 66 ++++++++++++++++++++++++++++++++++++++++----
 drivers/firmware/dmi_scan.c  | 31 +++++++++++++++++++++
 include/acpi/nfit.h          | 18 ++++++++++++
 include/linux/dmi.h          |  2 ++
 include/linux/edac.h         |  3 ++
 9 files changed, 168 insertions(+), 51 deletions(-)
 create mode 100644 include/acpi/nfit.h

-- 
2.14.1
