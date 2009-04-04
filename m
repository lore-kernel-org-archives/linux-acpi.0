From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi queue for 2.6.30
Date: Sat,  4 Apr 2009 01:25:41 -0300
Message-ID: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54086 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750865AbZDDEZ6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 00:25:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Len,

This patchset has the changes for thinkpad-acpi that I would like to
see merged for 2.6.30 (while the window is still open).

It contains the patch for
http://bugzilla.kernel.org/show_bug.cgi?id=11750, and a few
enhancements.

Shortlog:

Henrique de Moraes Holschuh (12):
      thinkpad-acpi: update copyright notices
      thinkpad-acpi: drop ibm-acpi alias
      thinkpad-acpi: documentation cleanup
      thinkpad-acpi: cleanup debug helpers
      thinkpad-acpi: add missing log levels
      thinkpad-acpi: add new debug helpers and warn of deprecated atts
      thinkpad-acpi: remove HKEY disable functionality
      thinkpad-acpi: restrict access to some firmware LEDs
      thinkpad-acpi: enhanced debugging messages for rfkill subdrivers
      thinkpad-acpi: enhanced debugging messages for the hotkey subdriver
      thinkpad-acpi: enhanced debugging messages for the fan subdriver
      thinkpad-acpi: rework brightness support

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
