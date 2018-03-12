From: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/5] edac: Add new memory type for non-volatile DIMMs
Date: Mon, 12 Mar 2018 11:24:27 -0700
Message-ID: <20180312182430.10335-3-tony.luck@intel.com>
References: <CAPcyv4iHr9nUAS0SiFeqqDkU8NXZ_x=rkD3YS010Dy-nbHJXmA@mail.gmail.com>
 <20180312182430.10335-1-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180312182430.10335-1-tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

There are now non-volatile versions of DIMMs. Add a new entry to
"enum mem_type" and a new string in edac_mem_types[].

Signed-off-by: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/edac/edac_mc.c | 3 ++-
 include/linux/edac.h   | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 1f61b736e075..3bb82e511eca 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -214,7 +214,8 @@ const char * const edac_mem_types[] = {
 	[MEM_RDDR3]	= "Registered-DDR3",
 	[MEM_LRDDR3]	= "Load-Reduced-DDR3-RAM",
 	[MEM_DDR4]	= "Unbuffered-DDR4",
-	[MEM_RDDR4]	= "Registered-DDR4"
+	[MEM_RDDR4]	= "Registered-DDR4",
+	[MEM_NVDIMM]	= "Non-volatile-RAM",
 };
 EXPORT_SYMBOL_GPL(edac_mem_types);
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index cd75c173fd00..bffb97828ed6 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -186,6 +186,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  * @MEM_RDDR4:		Registered DDR4 RAM
  *			This is a variant of the DDR4 memories.
  * @MEM_LRDDR4:		Load-Reduced DDR4 memory.
+ * @MEM_NVDIMM:		Non-volatile RAM
  */
 enum mem_type {
 	MEM_EMPTY = 0,
@@ -209,6 +210,7 @@ enum mem_type {
 	MEM_DDR4,
 	MEM_RDDR4,
 	MEM_LRDDR4,
+	MEM_NVDIMM,
 };
 
 #define MEM_FLAG_EMPTY		BIT(MEM_EMPTY)
@@ -231,6 +233,7 @@ enum mem_type {
 #define MEM_FLAG_DDR4           BIT(MEM_DDR4)
 #define MEM_FLAG_RDDR4          BIT(MEM_RDDR4)
 #define MEM_FLAG_LRDDR4         BIT(MEM_LRDDR4)
+#define MEM_FLAG_NVDIMM         BIT(MEM_NVDIMM)
 
 /**
  * enum edac-type - Error Detection and Correction capabilities and mode
-- 
2.14.1
