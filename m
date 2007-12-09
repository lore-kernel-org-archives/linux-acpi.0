From: Andrew Morton <akpm@linux-foundation.org>
Subject: suspend to RAM failure on t61p
Date: Sun, 9 Dec 2007 01:19:28 -0800
Message-ID: <20071209011928.c9873c66.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52578 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751511AbXLIJUA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Dec 2007 04:20:00 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB99JSbU027846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sun, 9 Dec 2007 01:19:29 -0800
Received: from box (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id lB99JSSp010875
	for <linux-acpi@vger.kernel.org>; Sun, 9 Dec 2007 01:19:28 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


2.6.24-rc4 on a Lenovo t61p, using FC8 config.

echo mem > /sys/power/state while running X.

It appears to suspend OK but then it instantly resumes and runs
OK except the display is blank.

A copy of /proc/acpi/dsdt is at http://userweb.kernel.org/~akpm/dsdt.t61p
config: http://userweb.kernel.org/~akpm/config-t61p.txt
dmesg: http://userweb.kernel.org/~akpm/dmesg-t61p.txt
