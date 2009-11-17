From: akpm@linux-foundation.org
Subject: [patch 05/12] fujitsu-laptop: fix tests of acpi_evaluate_integer() return
Date: Tue, 17 Nov 2009 14:27:31 -0800
Message-ID: <200911172227.nAHMRV26023190@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48049 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756365AbZKQW2s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 17:28:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, roel.kluin@gmail.com, jwoithe@physics.adelaide.edu.au

From: Roel Kluin <roel.kluin@gmail.com>

The wrong test was used acpi_status status is unsigned.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/fujitsu-laptop.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/platform/x86/fujitsu-laptop.c~fujitsu-laptop-fix-tests-of-acpi_evaluate_integer-return drivers/platform/x86/fujitsu-laptop.c
--- a/drivers/platform/x86/fujitsu-laptop.c~fujitsu-laptop-fix-tests-of-acpi_evaluate_integer-return
+++ a/drivers/platform/x86/fujitsu-laptop.c
@@ -376,7 +376,7 @@ static int get_lcd_level(void)
 
 	status =
 	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
-	if (status < 0)
+	if (ACPI_FAILURE(status))
 		return status;
 
 	fujitsu->brightness_level = state & 0x0fffffff;
@@ -398,7 +398,7 @@ static int get_max_brightness(void)
 
 	status =
 	    acpi_evaluate_integer(fujitsu->acpi_handle, "RBLL", NULL, &state);
-	if (status < 0)
+	if (ACPI_FAILURE(status))
 		return status;
 
 	fujitsu->max_brightness = state;
_
