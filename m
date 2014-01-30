From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ACPI: remove a pointless NULL check
Date: Thu, 30 Jan 2014 14:56:56 +0300
Message-ID: <20140130115656.GG12734@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

"element" can't be NULL because it is the address of a struct member.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 492cf4f409fd..94dbbcb5827b 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -98,10 +98,6 @@ acpi_extract_package(union acpi_object *package,
 
 		union acpi_object *element = &(package->package.elements[i]);
 
-		if (!element) {
-			return AE_BAD_DATA;
-		}
-
 		switch (element->type) {
 
 		case ACPI_TYPE_INTEGER:
