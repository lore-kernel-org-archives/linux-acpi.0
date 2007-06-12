From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] drivers/acpi/processor_throttling.c: make 2 functions
	static
Date: Wed, 13 Jun 2007 01:03:17 +0200
Message-ID: <20070612230317.GB3588@stusta.de>
References: <20070606220313.8f7c1fab.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33078 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754005AbXFLXDG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jun 2007 19:03:06 -0400
Content-Disposition: inline
In-Reply-To: <20070606220313.8f7c1fab.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Jun 06, 2007 at 10:03:13PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.22-rc4-mm1:
> 
>  git-acpi.patch
>...
>  git trees
>...

This patch makes 2 needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/acpi/processor_throttling.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.22-rc4-mm2/drivers/acpi/processor_throttling.c.old	2007-06-12 23:57:53.000000000 +0200
+++ linux-2.6.22-rc4-mm2/drivers/acpi/processor_throttling.c	2007-06-12 23:58:22.000000000 +0200
@@ -410,7 +410,8 @@
 	return pr->throttling.acpi_processor_get_throttling(pr);
 }
 
-int acpi_processor_set_throttling_fadt(struct acpi_processor *pr, int state)
+static int acpi_processor_set_throttling_fadt(struct acpi_processor *pr,
+					      int state)
 {
 	u32 value = 0;
 	u32 duty_mask = 0;
@@ -482,7 +483,8 @@
 	return 0;
 }
 
-int acpi_processor_set_throttling_ptc(struct acpi_processor *pr, int state)
+static int acpi_processor_set_throttling_ptc(struct acpi_processor *pr,
+					     int state)
 {
 	u32 value = 0;
 

