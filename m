From: JM <v-j-m@suomi24.fi>
Subject: Re: Acer Aspire 9813WKMI fan runs all the time after suspend to ram
Date: Mon, 5 May 2008 21:49:15 +0200 (CEST)
Message-ID: <28220299.1210016955623.JavaMail.apache@eni-cpps13.sth.basefarm.net>
Reply-To: v-j-m@suomi24.fi
Mime-Version: 1.0
Content-Type: text/plain;charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eni-mailout01.sth.basefarm.net ([80.76.148.7]:53530 "EHLO
	eni-mailout01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753298AbYEEUNr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 May 2008 16:13:47 -0400
Received: from [10.7.4.195] (port=34641 helo=eni-cpps13.sth.basefarm.net)
	by eni-mailout01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <v-j-m@suomi24.fi>)
	id 1Jt6gV-0000rR-6M
	for linux-acpi@vger.kernel.org; Mon, 05 May 2008 21:49:16 +0200
Received: from localhost ([127.0.0.1]:34639 helo=eni-cpps13.sth.basefarm.net)
	by eni-cpps13.sth.basefarm.net with esmtp (Exim 4.66)
	(envelope-from <v-j-m@suomi24.fi>)
	id 1Jt6gV-0008O5-KH
	for linux-acpi@vger.kernel.org; Mon, 05 May 2008 21:49:15 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

>
> Notebook fan runs all the time after suspend to ram.
>

Workaround:

Original DSDT > http://aceracpi.googlecode.com/svn/trunk/dsdt/acer/aspire/9810.dsl

Normalize behavior of fan on cold boot and wakeup:
Store (0x46, SMIF)
Store (0x00, TRP0)
But in _WAK is:
If (LAnd (DTSE, MPEN))
and that is not true.

--- a/dsdt.dsl
+++ b/dsdt.dsl
@@ -462,11 +462,11 @@
         Store (0x00, PO80)
         If (LEqual (Arg0, 0x03))
         {
-            If (LAnd (DTSE, MPEN))
-            {
+            // If (LAnd (DTSE, MPEN))
+            // {
                 Store (0x46, SMIF)
                 Store (0x00, TRP0)
-            }
+            // }
         }

         If (LOr (LEqual (Arg0, 0x03), LEqual (Arg0, 0x04)))
