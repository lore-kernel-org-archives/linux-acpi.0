From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI : Avoid bogus timeout about SMbus check
Date: Tue, 26 Aug 2008 13:57:34 +0800
Message-ID: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1780 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbYHZFma (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Aug 2008 01:42:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, astarikovskiy@suse.de

Subject: ACPI: Avoid bogus timeout about SMbus check
>From :  Zhao Yakui <yakui.zhao@intel.com>

In the function of wait_transaction_complete when the timeout happens,
OS will try to check the status of SMbus again. If the status is what O=
S
expected, it will be regarded as the bogus timeout. Otherwise it will b=
e
treated as ETIME.

http://bugzilla.kernel.org/show_bug.cgi?id=3D10483

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
tested-by    : Old=C5=99ich Jedli=C4=8Dka < <oldium.pro@seznam.cz>

---
 drivers/acpi/sbshc.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6/drivers/acpi/sbshc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/sbshc.c
+++ linux-2.6/drivers/acpi/sbshc.c
@@ -107,6 +107,13 @@ static int wait_transaction_complete(str
 	if (wait_event_timeout(hc->wait, smb_check_done(hc),
 			       msecs_to_jiffies(timeout)))
 		return 0;
+	/*
+	 * After the timeout happens, OS will try to check the status of SMbu=
s.
+	 * If the status is what OS expected, it will be regarded as the bogu=
s
+	 * timeout.
+	 */
+	if (smb_check_done(hc))
+		return 0;
 	else
 		return -ETIME;
 }


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
