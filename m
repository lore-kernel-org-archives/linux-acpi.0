From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/5] acpi, nfit: fix extended status translations for ACPI DSMs
Date: Tue, 06 Dec 2016 16:39:25 -0800
Message-ID: <148107116563.25138.8542559534788044870.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <148107115997.25138.3445497812509173966.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <148107115997.25138.3445497812509173966.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

ACPI DSMs can have an 'extended' status which can be non-zero to convey
additional information about the command. In the xlat_status routine,
where we translate the command statuses, we were returning an error for
a non-zero extended status, even if the primary status indicated success.

Return from each command's 'case' once we have verified both its status
and extend status are good.

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Fixes: 11294d63ac91 ("nfit: fail DSMs that return non-zero status by default")
Signed-off-by: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/nfit/core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 71a7d07c28c9..60acbb1d159c 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -113,7 +113,7 @@ static int xlat_status(void *buf, unsigned int cmd, u32 status)
 		flags = ND_ARS_PERSISTENT | ND_ARS_VOLATILE;
 		if ((status >> 16 & flags) == 0)
 			return -ENOTTY;
-		break;
+		return 0;
 	case ND_CMD_ARS_START:
 		/* ARS is in progress */
 		if ((status & 0xffff) == NFIT_ARS_START_BUSY)
@@ -122,7 +122,7 @@ static int xlat_status(void *buf, unsigned int cmd, u32 status)
 		/* Command failed */
 		if (status & 0xffff)
 			return -EIO;
-		break;
+		return 0;
 	case ND_CMD_ARS_STATUS:
 		ars_status = buf;
 		/* Command failed */
@@ -154,7 +154,7 @@ static int xlat_status(void *buf, unsigned int cmd, u32 status)
 		/* Unknown status */
 		if (status >> 16)
 			return -EIO;
-		break;
+		return 0;
 	case ND_CMD_CLEAR_ERROR:
 		clear_err = buf;
 		if (status & 0xffff)
@@ -163,7 +163,7 @@ static int xlat_status(void *buf, unsigned int cmd, u32 status)
 			return -EIO;
 		if (clear_err->length > clear_err->cleared)
 			return clear_err->cleared;
-		break;
+		return 0;
 	default:
 		break;
 	}
