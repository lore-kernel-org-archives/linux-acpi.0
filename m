From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] backlight event support enhancements
Date: Sun, 20 Sep 2009 14:44:46 -0300
Message-ID: <1253468688-4933-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48506 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755081AbZITRox (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Sep 2009 13:44:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Matthew, Richard,

This two-patch patchset adds poll() support to Matthew's backlight event
work, and also adds backlight event support for thinkpad-acpi.

The thinkpad-acpi changes depend on a patchset I just sent to Len Brown
for merging in acpi-test.

Is there any timeframe for the backlight event support to be sent to
mainline?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
