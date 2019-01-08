From: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] nfit: Hide unused functions behind CONFIG_X86
Date: Mon,  7 Jan 2019 21:58:53 -0700
Message-ID: <20190108045853.5471-1-natechancellor@gmail.com>
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
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ross Zwisler <zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On arm64 little endian allyesconfig:

drivers/acpi/nfit/intel.c:149:12: warning: unused function 'intel_security_unlock' [-Wunused-function]
static int intel_security_unlock(struct nvdimm *nvdimm,
           ^
drivers/acpi/nfit/intel.c:230:12: warning: unused function 'intel_security_erase' [-Wunused-function]
static int intel_security_erase(struct nvdimm *nvdimm,
           ^
drivers/acpi/nfit/intel.c:279:12: warning: unused function 'intel_security_query_overwrite' [-Wunused-function]
static int intel_security_query_overwrite(struct nvdimm *nvdimm)
           ^
drivers/acpi/nfit/intel.c:316:12: warning: unused function 'intel_security_overwrite' [-Wunused-function]
static int intel_security_overwrite(struct nvdimm *nvdimm,
           ^
4 warnings generated.

These functions are only used in __intel_security_ops when CONFIG_X86 is
set so only define these functions under that same condition.

Fixes: 4c6926a23b76 ("acpi/nfit, libnvdimm: Add unlock of nvdimm support for Intel DIMMs")
Signed-off-by: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/nfit/intel.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 850b2927b4e7..2ba0f1543940 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -144,6 +144,7 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
 	}
 }
 
+#ifdef CONFIG_X86
 static void nvdimm_invalidate_cache(void);
 
 static int intel_security_unlock(struct nvdimm *nvdimm,
@@ -186,6 +187,7 @@ static int intel_security_unlock(struct nvdimm *nvdimm,
 
 	return 0;
 }
+#endif
 
 static int intel_security_disable(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key_data)
@@ -227,6 +229,7 @@ static int intel_security_disable(struct nvdimm *nvdimm,
 	return 0;
 }
 
+#ifdef CONFIG_X86
 static int intel_security_erase(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key,
 		enum nvdimm_passphrase_type ptype)
@@ -360,16 +363,10 @@ static int intel_security_overwrite(struct nvdimm *nvdimm,
  * TODO: define a cross arch wbinvd equivalent when/if
  * NVDIMM_FAMILY_INTEL command support arrives on another arch.
  */
-#ifdef CONFIG_X86
 static void nvdimm_invalidate_cache(void)
 {
 	wbinvd_on_all_cpus();
 }
-#else
-static void nvdimm_invalidate_cache(void)
-{
-	WARN_ON_ONCE("cache invalidation required after unlock\n");
-}
 #endif
 
 static const struct nvdimm_security_ops __intel_security_ops = {
-- 
2.20.1
