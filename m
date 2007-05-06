From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [PATCH 3/4] asus-laptop fix light sens init
Date: Sun, 6 May 2007 14:47:29 +0200
Message-ID: <200705061447.29707.corentincj@iksaif.net>
References: <200705061445.03504.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:40252 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933536AbXEFMrb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 May 2007 08:47:31 -0400
In-Reply-To: <200705061445.03504.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Corentin Chary <corentincj@iksaif.net>

Fix a stupid light sens detection bug.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus-laptop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/asus-laptop.c	2007-05-05 09:31:05.000000000 +0200
+++ b/drivers/misc/asus-laptop.c	2007-05-05 09:32:55.000000000 +0200
@@ -936,7 +936,7 @@
 
 	/* There is a lot of models with "ALSL", but a few get
 	   a real light sens, so we need to check it. */
-	if (ASUS_HANDLE_INIT(ls_switch))
+	if (!ASUS_HANDLE_INIT(ls_switch))
 		ASUS_HANDLE_INIT(ls_level);
 
 	ASUS_HANDLE_INIT(gps_on);
