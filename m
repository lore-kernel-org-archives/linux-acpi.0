From: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] nfit: Mark some functions as __maybe_unused
Date: Tue,  8 Jan 2019 22:00:37 -0700
Message-ID: <20190109050036.17322-1-natechancellor@gmail.com>
References: <20190108045853.5471-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20190108045853.5471-1-natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Mark these functions as __maybe_unused because they are only used when
CONFIG_X86 is set.

Fixes: 4c6926a23b76 ("acpi/nfit, libnvdimm: Add unlock of nvdimm support for Intel DIMMs")
Suggested-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

v1 -> v2:

* Mark the functions as __maybe_unused rather than expanding the
  CONFIG_X86, as requested by Dan.

 drivers/acpi/nfit/intel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 850b2927b4e7..f70de71f79d6 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -146,7 +146,7 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
 
 static void nvdimm_invalidate_cache(void);
 
-static int intel_security_unlock(struct nvdimm *nvdimm,
+static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key_data)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
@@ -227,7 +227,7 @@ static int intel_security_disable(struct nvdimm *nvdimm,
 	return 0;
 }
 
-static int intel_security_erase(struct nvdimm *nvdimm,
+static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key,
 		enum nvdimm_passphrase_type ptype)
 {
@@ -276,7 +276,7 @@ static int intel_security_erase(struct nvdimm *nvdimm,
 	return 0;
 }
 
-static int intel_security_query_overwrite(struct nvdimm *nvdimm)
+static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
@@ -313,7 +313,7 @@ static int intel_security_query_overwrite(struct nvdimm *nvdimm)
 	return 0;
 }
 
-static int intel_security_overwrite(struct nvdimm *nvdimm,
+static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *nkey)
 {
 	int rc;
-- 
2.20.1
