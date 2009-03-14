From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Subject: Re: [PATCH] thinkpad-acpi: fix module autoloading for older models
Date: Sat, 14 Mar 2009 16:35:26 +0100
Message-ID: <20090314153526.GA13084@mobydick>
References: <20090314104204.GA11226@mobydick> <ac3eb2510903140814t26954869m4f07623c25b5948f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay2-v.mail.gandi.net ([217.70.178.76]:41295 "EHLO
	relay2-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZCNPfa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Mar 2009 11:35:30 -0400
Content-Disposition: inline
In-Reply-To: <ac3eb2510903140814t26954869m4f07623c25b5948f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, stable@kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

On Sat, Mar 14, 2009 at 04:14:19PM +0100, Kay Sievers wrote:
> On Sat, Mar 14, 2009 at 11:42, Mathieu Chouquet-Stringer
> <mchouque@free.fr> wrote:
> 
> > While for older Thinkpads, you do this (for instance):
> > IBM_BIOS_MODULE_ALIAS("1[0,3,6,8,A-G,I,K,M-P,S,T]");
> 
> Aliases are shell-style globs. Any idea what the ',' are doing in a
> character class? Confused ...

Good point...  I guess it's a typo: perhaps the original authors thought
of it as a brace expansion?  Something like 1{0,3,6,...}?

A proper patch would then be:

Signed-off-by: Mathieu Chouquet-Stringer <mchouque@free.fr>
 drivers/platform/x86/thinkpad_acpi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index bcbc051..d243320 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7532,7 +7532,7 @@ MODULE_ALIAS(TPACPI_DRVR_SHORTNAME);
  * if it is not there yet.
  */
 #define IBM_BIOS_MODULE_ALIAS(__type) \
-	MODULE_ALIAS("dmi:bvnIBM:bvr" __type "ET??WW")
+	MODULE_ALIAS("dmi:bvnIBM:bvr" __type "ET??WW*")
 
 /* Non-ancient thinkpads */
 MODULE_ALIAS("dmi:bvnIBM:*:svnIBM:*:pvrThinkPad*:rvnIBM:*");
@@ -7541,9 +7541,9 @@ MODULE_ALIAS("dmi:bvnLENOVO:*:svnLENOVO:*:pvrThinkPad*:rvnLENOVO:*");
 /* Ancient thinkpad BIOSes have to be identified by
  * BIOS type or model number, and there are far less
  * BIOS types than model numbers... */
-IBM_BIOS_MODULE_ALIAS("I[B,D,H,I,M,N,O,T,W,V,Y,Z]");
-IBM_BIOS_MODULE_ALIAS("1[0,3,6,8,A-G,I,K,M-P,S,T]");
-IBM_BIOS_MODULE_ALIAS("K[U,X-Z]");
+IBM_BIOS_MODULE_ALIAS("I[BDHIMNOTWVYZ]");
+IBM_BIOS_MODULE_ALIAS("1[0368A-GIKM-PST]");
+IBM_BIOS_MODULE_ALIAS("K[UX-Z]");
 
 MODULE_AUTHOR("Borislav Deianov, Henrique de Moraes Holschuh");
 MODULE_DESCRIPTION(TPACPI_DESC);
