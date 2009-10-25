From: Chris Vine <chris@cvine.freeserve.co.uk>
Subject: ACPI processor module with Atom N270 causes DMA errors
Date: Sun, 25 Oct 2009 21:07:54 +0000
Message-ID: <20091025210754.55abdbe6@boulder.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp6.freeserve.com ([193.252.22.191]:17264 "EHLO
	smtp6.freeserve.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbZJYVZo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Oct 2009 17:25:44 -0400
Received: from smtp6.freeserve.com (mwinf3609 [10.232.31.37])
	by mwinf3610.me.freeserve.com (SMTP Server) with ESMTP id EDDB81C006ED
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2009 22:10:02 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf3609.me.freeserve.com (SMTP Server) with ESMTP id 885E31C00081
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2009 22:09:29 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf3609.me.freeserve.com (SMTP Server) with ESMTP id 7C2D11C00085
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2009 22:09:29 +0100 (CET)
Received: from boulder.homenet (unknown [91.104.2.139])
	by mwinf3609.me.freeserve.com (SMTP Server) with ESMTP id 43EDA1C00081
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2009 22:09:29 +0100 (CET)
Received: from boulder.homenet (IDENT:1000@localhost [127.0.0.1])
	by boulder.homenet (8.14.3/8.14.3) with ESMTP id n9PL7sZA005081
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2009 21:07:54 GMT
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have a Levono S-12 netbook which uses an Atom N270 processor.
Loading the ACPI 'processor' module clobbers my DMA, specifically when
using the b43 driver for a Broadcom BCM4312 802.11b/g [14e4:4315] low
power phy wireless device.  The b43 driver works correctly if the
processor ACPI module is blacklisted.

This is with kernel 2.6.32-rc5, but the same occurs with earlier
pre-2.6.32 kernels.

Please let me know what further information would be helpful (for
example, the output of dmesg, lspci or lsmod, or other hardware
information).

Chris


