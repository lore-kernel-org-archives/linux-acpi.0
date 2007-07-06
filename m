From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 03/16] ACPI: thinkpad-acpi: update information on T43 thermal sensor 0xc1
Date: Thu,  5 Jul 2007 23:42:15 -0300
Message-ID: <11836897482806-git-send-email-hmh@hmh.eng.br>
References: <11836897482509-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49735 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759695AbXGFCmh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jul 2007 22:42:37 -0400
In-Reply-To: <11836897482509-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update the documentation with some extra data on the T43 thermal sensor
@0xc1, thanks to Alexey Fisher.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/thinkpad-acpi.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 9e6b94f..b90d9a7 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -562,7 +562,8 @@ http://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_T43.2C_T43p
 2:  System board, left side (near PCMCIA slot), reported as HDAPS temp
 3:  PCMCIA slot
 9:  MCH (northbridge) to DRAM Bus
-10: ICH (southbridge), under Mini-PCI card, under touchpad
+10: Clock-generator, mini-pci card and ICH (southbridge), under Mini-PCI
+    card, under touchpad
 11: Power regulator, underside of system board, below F2 key
 
 The A31 has a very atypical layout for the thermal sensors
-- 
1.5.2.1

