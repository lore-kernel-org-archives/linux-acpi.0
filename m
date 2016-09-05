From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/7] ACPI-APEI-HEST: Fix a typo in a comment line
Date: Mon, 5 Sep 2016 22:15:17 +0200
Message-ID: <1abcdda6-0d79-b221-64b0-4c8a4c995576@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 20:37:38 +0200

Add a missing character to the fourth word at the beginning of this file.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/apei/hest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 20b3fcf..e170885 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -1,5 +1,5 @@
 /*
- * APEI Hardware Error Souce Table support
+ * APEI Hardware Error Source Table support
  *
  * HEST describes error sources in detail; communicates operational
  * parameters (i.e. severity levels, masking bits, and threshold
-- 
2.10.0
