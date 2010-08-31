From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] ACPI/HEST: fix boot failure when encountering
	 duplicate source IDs
Date: Tue, 31 Aug 2010 14:16:00 +0100
Message-ID: <4C7D1CB002000078000132F3@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

While they should be unique, boot certainly shouldn't fail if the HEST
table isn't sane. The problem is that platform_device_release() wants
to kfree() ->dev.platform_data, which gets set to point into the
middle of some (allocated or mapped) enclosing table.

It appears safe to simply create a copy of the table (no data in there
should change post-boot); if it isn't, the pointer would need to be
cleared before dropping the device.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/acpi/apei/hest.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.36-rc3/drivers/acpi/apei/hest.c
+++ 2.6.36-rc3-acpi-hest-error-path/drivers/acpi/apei/hest.c
@@ -150,7 +150,9 @@ static int hest_parse_ghes(struct acpi_h
 	ghes_dev = platform_device_alloc("GHES", hest_hdr->source_id);
 	if (!ghes_dev)
 		return -ENOMEM;
-	ghes_dev->dev.platform_data = generic;
+	rc = platform_device_add_data(ghes_dev, generic, sizeof(*generic));
+	if (rc)
+		goto err;
 	rc = platform_device_add(ghes_dev);
 	if (rc)
 		goto err;



