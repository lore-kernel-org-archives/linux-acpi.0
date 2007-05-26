From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [RFC] thinkpad-acpi input hotkey events
Date: Sat, 26 May 2007 14:28:06 -0300
Message-ID: <11802004861625-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34950 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752783AbXEZR2L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 May 2007 13:28:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ibm-acpi-devel@lists.sourceforge.net
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, dtor@mail.ru


This patch is a preliminary version of the input device support for
thinkpad-acpi hotkeys.  It is not for merging.

Please comment.

TODO: monitor input device open/close and block ACPI hotkeys events that
are also going to be sent over the input device, when it is open? [for
HAL]
TODO: Document the interface

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
