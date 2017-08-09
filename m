From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 1/4] ACPI-APEI-HEST: Fix a typo in a comment line
Date: Wed, 9 Aug 2017 20:01:46 +0200
Message-ID: <cebc8e6a-03b4-757c-0264-0fb1391e2653@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
 <CAJZ5v0hcD8pi8y+jAtF70cJp8uYyUdOeDJKuR3z=JpB6Z_Qnfw@mail.gmail.com>
 <06ab72bc-6e00-1829-f1bf-67f0a31aff38@users.sourceforge.net>
 <CAJZ5v0i5EW1UpLfaogyD-s4P4vXdgWndwjOpF5ykPDXE=eZVSA@mail.gmail.com>
 <9f6e5436-e550-b64c-db39-b9da668766b0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:50500 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbdHISCA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Aug 2017 14:02:00 -0400
In-Reply-To: <9f6e5436-e550-b64c-db39-b9da668766b0@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Hanjun Guo <hanjun.guo@linaro.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 20:37:38 +0200

Add a missing character to the fourth word at the beginning of this file.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/apei/hest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 456b488eb1df..832a930e98f2 100644
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
2.13.4

