From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi second set of changes for 2.6.33
Date: Tue, 15 Dec 2009 21:51:05 -0200
Message-ID: <1260921073-7686-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54370 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754893AbZLOXvU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Dec 2009 18:51:20 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Len,

This is the second set of changes to thinkpad-acpi, for the merge
window.  Patch 1 has been reworked as per Dmitry's comments.  The other
patches are new.

Please apply to acpi-test.

Thank you!

Shortlog:

Alexey Dobriyan (1):
      thinkpad-acpi: convert to seq_file

Henrique de Moraes Holschuh (6):
      thinkpad-acpi: log initial state of rfkill switches
      thinkpad-acpi: volume subdriver rewrite
      thinkpad-acpi: support MUTE-only ThinkPads
      thinkpad-acpi: disable volume control
      thinkpad-acpi: basic ALSA mixer support (v2)
      thinkpad-acpi: bump version to 0.24

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
