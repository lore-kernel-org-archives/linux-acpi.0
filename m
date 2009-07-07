From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] fix thinkpad-acpi regression on 2.6.27+
Date: Tue,  7 Jul 2009 20:09:48 -0300
Message-ID: <1247008190-29419-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54636 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752064AbZGGXJ6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2009 19:09:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net


Len,

This small patchset fixes a regression that causes OOPSes on the ACPI
core during bay or dock operations when thinkpad-acpi is loaded and
allowed to bind to the dock or bay nodes.

This is not a very common configuration, which explains why I only heard
of it very recently.  Most users prefer the generic ACPI dock/bay driver
for good reasons (and I am one of them :P ), and most of the time,
thinkpad-acpi loads later so it doesn't get to bind to the bay node.

Please send at least the first patch (but preferably both) to Linus to
fix the issue in mainline.  If it is too late for the second patch, I
will resubmit it for the next merge window.

The stable team should get the first patch, which makes sure the broken
features are normally disabled in a minimalistic way.

Thank you.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
