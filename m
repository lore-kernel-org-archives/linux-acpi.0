From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 1/2] ACPI, extlog: shift wrapping bug in extlog_get_dsm()
Date: Tue, 5 Nov 2013 23:18:36 +0300
Message-ID: <20131105201836.GA3949@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Chen@elgon.mountain, Gong <gong.chen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

obj->buffer.pointer is a u8 pointer so we need to cast it to u64 for the
64 bit shift.  Otherwise the upper bits are always zero.

I tweaked a couple nearby lines as well to avoid going over the 80
character limit.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index a6869e1..c4d5e59 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -182,11 +182,9 @@ static int extlog_get_dsm(acpi_handle handle, int rev, int func, u64 *ret)
 	obj = (union acpi_object *)buf.pointer;
 	if (obj->type == ACPI_TYPE_INTEGER) {
 		*ret = obj->integer.value;
-	} else if (obj->type == ACPI_TYPE_BUFFER) {
-		if (obj->buffer.length <= 8) {
-			for (i = 0; i < obj->buffer.length; i++)
-				*ret |= (obj->buffer.pointer[i] << (i * 8));
-		}
+	} else if (obj->type == ACPI_TYPE_BUFFER && obj->buffer.length <= 8) {
+		for (i = 0; i < obj->buffer.length; i++)
+			*ret |= ((u64)obj->buffer.pointer[i] << (i * 8));
 	}
 	kfree(buf.pointer);
 
