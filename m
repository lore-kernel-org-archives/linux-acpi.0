From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi late queue for 2.6.31
Date: Thu, 18 Jun 2009 00:40:15 -0300
Message-ID: <1245296417-3734-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56685 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754069AbZFRDk3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jun 2009 23:40:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net


Len,

Here are two late patches that add support for the second fan on the
X60/X61.  Please queue them as well for 2.6.31 merge window.

Thank you!

Shortlog:

Henrique de Moraes Holschuh (2):
      thinkpad-acpi: forbid the use of HBRV on Lenovo ThinkPads
      thinkpad-acpi: support the second fan on the X61

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
