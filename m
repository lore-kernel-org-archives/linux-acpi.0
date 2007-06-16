From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Exporting EV_SW SW_LID events from thinkpad-acpi to input layer
Date: Sat, 16 Jun 2007 11:44:11 -0300
Message-ID: <20070616144411.GA2127@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:46554 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756068AbXFPOoP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Jun 2007 10:44:15 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, Dmitry Torokhov <dtor@insightbb.com>, Richard Hughes <hughsient@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, ibm-acpi-devel@lists.sourceforge.net

thinkpad-acpi can now be made to export EV_SW SW_LID events to the input
layer.

However, most (all?) thinkpads will also generate ACPI notifications to
\_SB.LID, on LID changes, i.e. this would duplicate an ACPI LID event, and I
undertand ACPI is already moving to provide those over an input device by
itself.

Given that situation, is it desireable for thinkpad-acpi to export EV_SW
SW_LID events by itself (possibly duplicating an event that the ACPI layer
will also issue)?  Or should I just ignore the lid events, and leave them
for the ACPI layer to deal with?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
