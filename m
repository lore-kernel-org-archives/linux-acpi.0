From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi 2.6.31-rc fixes
Date: Sat,  1 Aug 2009 12:04:16 -0300
Message-ID: <1249139060-15392-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49843 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751741AbZHAPHH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Aug 2009 11:07:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Len,

This patchset has important fixes (two are security fixes, one is
known-dangerous code removal, and one is a regression fix) for
thinkpad-acpi.  Not all of them have bugzilla entries.

It includes the patches I already sent you, but which were not sent to
mainline yet.

Please send them to Linus for merging on 2.6.31-rc.

Thank you!

Patches:
[PATCH 1/4] thinkpad-acpi: disable broken bay and dock subdrivers
[PATCH 2/4] thinkpad-acpi: remove dock and bay subdrivers
[PATCH 3/4] thinkpad-acpi: Avoid heap buffer overrun
[PATCH 4/4] thinkpad-acpi: fix incorrect use of TPACPI_BRGHT_MODE_ECNVRAM
