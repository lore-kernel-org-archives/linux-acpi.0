From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [RFC] thinkpad-acpi volume subdriver rework
Date: Tue,  8 Dec 2009 23:48:18 -0200
Message-ID: <1260323302-6040-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58411 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754903AbZLIBs1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 20:48:27 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Lorne Applebaum <lorne.applebaum@gmail.com>, Matthew Garrett <mjg@redhat.com>

This patchset shoud be applied on top of the first set I just sent to
the mailinglists.   It has seen some testing on 2.6.31.7.

It contains the volume subdriver rewrite, and the basic ALSA mixer
support.  Thanks to Lorne Applebaum and Matthew Garrett for doing much
of the grunt work.

Comments?  I'd like to submit it to Len during this merge window...

