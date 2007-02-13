From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/41] ACPI: add video driver MAINTAINER
Date: Tue, 13 Feb 2007 00:49:34 -0500
Message-ID: <11713458222751-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org> <11713458171374-git-send-email-lenb@kernel.org> <11713458183917-git-send-email-lenb@kernel.org> <11713458191475-git-send-email-lenb@kernel.org> <11713458202747-git-send-email-lenb@kernel.org> <11713458211458-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39554 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751088AbXBMFu1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:27 -0500
In-Reply-To: <11713458211458-git-send-email-lenb@kernel.org>
Message-Id: <359acec8cd78d35e64147565e28b516599066e08.1171345631.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe35f3a..7c5d329 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -247,6 +247,13 @@ L:	linux-acpi@vger.kernel.org
 W:	http://acpi.sourceforge.net/
 S:	Supported
 
+ACPI VIDEO DRIVER
+P:	Luming Yu
+M:	luming.yu@intel.com
+L:	linux-acpi@vger.kernel.org
+W:	http://acpi.sourceforge.net/
+S:	Supported
+
 AD1816 SOUND DRIVER
 P:	Thorsten Knabe
 M:	Thorsten Knabe <linux@thorsten-knabe.de>
-- 
1.5.0.rc4.345.gb4d2
