From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi patches for the merge window (second set)
Date: Sun, 20 Sep 2009 14:09:21 -0300
Message-ID: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48065 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754683AbZITRJ5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Sep 2009 13:09:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Len,

This is a second set of changes for thinkpad-acpi that I would like to
see merged into acpi-test for this merge window.

The patchset contains some cleanups, and an important rework of the
internal hotkey event handling code which new features will depend on.

I apologise for not sending them with the first set, but they were not
fully tested at that time.

Thank you!

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
