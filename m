From: Jerone Young <jerone.young@canonical.com>
Subject: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting them
Date: Fri, 23 Apr 2010 17:48:04 -0500
Message-ID: <1272062884.1594.73.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:43279 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab0DWWsI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2010 18:48:08 -0400
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1O5RfL-0004Dj-B1
	for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2010 23:48:07 +0100
Received: from rrcs-24-227-244-55.sw.biz.rr.com ([24.227.244.55] helo=[192.168.1.220])
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <jerone.young@canonical.com>)
	id 1O5RfL-0000YC-1K
	for linux-acpi@vger.kernel.org; Fri, 23 Apr 2010 23:48:07 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This patch fixes that mute keys for X & R & W series Thinkpads. For
these Thinkpads in the BIOS if OS exposes itself as "Linux" it will
switch the functionality of the mute key to send a mute key press to the
OS. These machines will not be getting any bios updates in the future.

All of these Thinkpads do not have a little light that would indicate
the mute is on. So having them send the mute key to the OS makes a
better user experience and also will match behavior of newer Thinkpads.
These all have the same quirk the T400 & T500 have.

Unlike the last time I sent a similar patch(s) somethings have happened:

	- All new Lenovo Thinkpads now send a mute key press to the 
          OS by default (x201 series).

	- I've decoded the bioses. Under the Linux selection it 
          only does one operation. Switch the hardware mute to
          a software mute. Has no special operations done under
          Windows selections.
	
	- On all the machines. The hardware mute key is only wired
          to the external speakers. So the headphone jack does not 
          get muted by the hardware mute.

	- I also have gotten confirmation from users around the
          net that it works. Except for the W700, though based on
          data I found it was the same as the W500.


Signed-off-by: Jerone Young <jerone.young@canonical.com>

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 2815df6..cce6e1a 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -285,6 +285,46 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T500"),
 		},
 	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad X200[s][t]",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X200"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad R400",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R400"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad R500",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R500"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad W500",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		    DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W500"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad W700[ds]",
+	.matches = {
+		   DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		   DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W700"),
+		},
+	},
 	{}
 };
 



