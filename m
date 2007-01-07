From: bloch@verdurin.com
Subject: Sony Vaio SZ3XVP
Date: Sun, 7 Jan 2007 10:02:54 +0000
Message-ID: <20070107100254.GC1076@bloch.config>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 87-194-8-112.bethere.co.uk ([87.194.8.112]:65266 "EHLO
	bloch.verdurin.priv" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932492AbXAGK66 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jan 2007 05:58:58 -0500
Received: from bloch.verdurin.priv (localhost.localdomain [127.0.0.1])
	by bloch.verdurin.priv (8.13.8/8.13.1) with ESMTP id l07A2t8Y005348
	for <linux-acpi@vger.kernel.org>; Sun, 7 Jan 2007 10:02:55 GMT
Received: (from adam@localhost)
	by bloch.verdurin.priv (8.13.8/8.13.1/Submit) id l07A2tY5005347
	for linux-acpi@vger.kernel.org; Sun, 7 Jan 2007 10:02:55 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I've been glad to see the recent activity on Vaio support, as I have an
SZ3XVP with Fedora 6 x86_64 installed.  It seems the sonypi module is
disabled as it "doesn't work in 64-bit" (according to a bug report I've
seen).

Which module is expected to work with this module - sonypi or sony_acpi?
Is it true that sonypi needs to be cleaned up for 64-bit installations?
I'm quite happy to test, though I was initially unsure which patches in
the -mm kernel tree to apply.

Adam
