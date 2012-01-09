From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ericsson.com>
Subject: [PATCH] ACPI, APEI, EINJ Allow empty Trigger Error Action Table
Date: Mon, 9 Jan 2012 16:49:44 +0100
Message-ID: <1326124184-10084-2-git-send-email-niklas.soderlund@ericsson.com>
References: <1326124184-10084-1-git-send-email-niklas.soderlund@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1326124184-10084-1-git-send-email-niklas.soderlund@ericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, ying.huang@intel.com, akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ericsson.com>
List-Id: linux-acpi@vger.kernel.org

According to the ACPI spec [1] section 18.6.4 the TRIGGER_ERROR action
table can consists of zero elements.

[1] Advanced Configuration and Power Interface Specification
    Revision 5.0, December 6, 2011
	http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund@ericsson.com>
---
 drivers/acpi/apei/einj.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 589b96c..94c05ff 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -184,7 +184,7 @@ static int einj_check_trigger_header(struct acpi_ei=
nj_trigger *trigger_tab)
 	if (trigger_tab->header_size !=3D sizeof(struct acpi_einj_trigger))
 		return -EINVAL;
 	if (trigger_tab->table_size > PAGE_SIZE ||
-	    trigger_tab->table_size <=3D trigger_tab->header_size)
+	    trigger_tab->table_size < trigger_tab->header_size)
 		return -EINVAL;
 	if (trigger_tab->entry_count !=3D
 	    (trigger_tab->table_size - trigger_tab->header_size) /
@@ -225,6 +225,11 @@ static int __einj_error_trigger(u64 trigger_paddr)
 			   "The trigger error action table is invalid\n");
 		goto out_rel_header;
 	}
+
+	/* No action structures in the TRIGGER_ERROR table, nothing to do */
+	if (!trigger_tab->entry_count)
+		goto out_rel_header;
+
 	rc =3D -EIO;
 	table_size =3D trigger_tab->table_size;
 	r =3D request_mem_region(trigger_paddr + sizeof(*trigger_tab),
--=20
1.7.8.3
