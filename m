From: Ocean He <oceanhehy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ACPI: nfit: adjust annotation for why return 0 if fail to
 find NFIT at startup
Date: Tue,  7 Aug 2018 02:15:31 -0400
Message-ID: <1533622531-3617-1-git-send-email-oceanhehy@gmail.com>
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
To: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ocean He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Ocean He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>

Add detail explanation why it's ok to return 0 if fail to find NFIT at
startup, refer to chapter 9.20.2 NVDIMM Root Device in ACPI 6.2 spec.

Signed-off-by: Ocean He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
---
v1: https://lists.01.org/pipermail/linux-nvdimm/2018-August/017311.html 
v2: Per Vishal's comments of v1, it turns out that it's right to keep 
"return 0" if NFIT not found at boot time. This v2 adjust annotation
to avoid misunderstanding of "return 0".

 drivers/acpi/nfit/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 7c47900..1b982fe 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3353,7 +3353,13 @@ static int acpi_nfit_add(struct acpi_device *adev)
 
 	status = acpi_get_table(ACPI_SIG_NFIT, 0, &tbl);
 	if (ACPI_FAILURE(status)) {
-		/* This is ok, we could have an nvdimm hotplugged later */
+		/* The NVDIMM root device allows OS to trigger enumeration of
+		 * NVDIMMs through NFIT at boot time and re-enumeration at
+		 * root level via the _FIT method during runtime.
+		 * This is ok to return 0 here, we could have an nvdimm
+		 * hotplugged later and evaluate _FIT method which returns
+		 * data in the format of a series of NFIT Structures.
+		 */
 		dev_dbg(dev, "failed to find NFIT at startup\n");
 		return 0;
 	}
-- 
1.8.3.1
