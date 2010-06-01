From: Alan Stern <stern@rowland.harvard.edu>
Subject: ACPI error messages
Date: Tue, 1 Jun 2010 09:11:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006010906530.16754-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:54957 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756187Ab0FANLj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jun 2010 09:11:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

My kernel log is full of hundreds of messages like these:

ACPI Exception: AE_AML_BUFFER_LIMIT, Index (000000046) is beyond end of object (20090903/exoparg2-445)
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.EC0_.STBR] (Node f701c918), AE_AML_BUFFER_LIMIT
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.VGA_.LCDD._BCM] (Node f7017b58), AE_AML_BUFFER_LIMIT
ACPI Error: Evaluating _BCM failed (20090903/video-528)

This is on an ASUS UL20A laptop (ICH9 chipset) with Fedora-12 (kernel
2.6.32.12).  What is the reason for these error messages?  Can anything 
be done to fix them?

Thanks,

Alan Stern

