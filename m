From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] ACPI: thinkpad-acpi: do not use named sysfs groups
Date: Fri, 25 May 2007 20:53:21 -0300
Message-ID: <118013720199-git-send-email-hmh@hmh.eng.br>
References: <1180137201942-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51372 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752801AbXEYXx1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 May 2007 19:53:27 -0400
In-Reply-To: <1180137201942-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

The initial version of the thinkpad-acpi sysfs interface (not yet released
in any stable mainline kernel) made liberal use of named sysfs groups, in
order to get the attributes more organized.

This proved to be a really bad design decision.  Maybe if attribute groups
were as flexible as a real directory, and if binary attributes were not
second-class citizens, the idea of subdirs and named groups would not have
been so bad.

This patch makes all the thinkpad-acpi sysfs groups anonymous (thus
removing the subdirs), adds the former group names as a prefix (so that
hotkey/enable becomes hotkey_enable for example), and updates the
documentation.

These changes will make the thinkpad-acpi sysfs ABI a lot easier to
maintain.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

-- 
1.5.1.4

