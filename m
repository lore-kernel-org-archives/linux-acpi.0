From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] pci: increase alignment to make more space for hidden code
Date: Sun, 11 Oct 2009 14:17:16 -0700
Message-ID: <4AD24B5C.4050905@kernel.org>
References: <200908072333.24631.storm@sys49152.net> <alpine.LFD.2.00.0908122350560.22946@localhost.localdomain> <200908160400.03391.storm@sys49152.net> <alpine.LFD.2.00.0910052312140.309@localhost.localdomain> <4ACAC8F1.1050706@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39111 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbZJKVSj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Oct 2009 17:18:39 -0400
In-Reply-To: <4ACAC8F1.1050706@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jesse.barnes@intel.com>, Ingo Molnar <mingo@elte.hu>
Cc: Ricardo Jorge da Fonseca Marques Ferreira <storm@sys49152.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Yannick Roehlly <yannick.roehlly@free.fr>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, x86@kernel.org

for

http://bugzilla.kernel.org/show_bug.cgi?id=13940

some system when acpi are enabled, acpi clears some BAR for some devices without
reason, and kernel will need to allocate devices for them.

try to increase alignment to get more safe range for unassigned devices.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 arch/x86/kernel/e820.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/x86/kernel/e820.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/e820.c
+++ linux-2.6/arch/x86/kernel/e820.c
@@ -1378,8 +1378,8 @@ static unsigned long ram_alignment(resou
 	if (mb < 16)
 		return 1024*1024;
 
-	/* To 32MB for anything above that */
-	return 32*1024*1024;
+	/* To 64MB for anything above that */
+	return 64*1024*1024;
 }
 
 #define MAX_RESOURCE_SIZE ((resource_size_t)-1)
