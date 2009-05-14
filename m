From: Francis Russell <francis+lkml@unchartedbackwaters.co.uk>
Subject: Spurious power button event on resume from hibernate
Date: Thu, 14 May 2009 22:27:03 +0100
Message-ID: <4A0C8CA7.2020104@unchartedbackwaters.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.unchartedbackwaters.co.uk ([78.110.170.111]:45588 "EHLO
	smtp.unchartedbackwaters.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753762AbZENVer (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 May 2009 17:34:47 -0400
Received: from [192.168.0.2] (host81-129-160-105.range81-129.btcentralplus.com [81.129.160.105])
	by smtp.unchartedbackwaters.co.uk (Postfix) with ESMTPSA id 545FB135267
	for <linux-acpi@vger.kernel.org>; Thu, 14 May 2009 22:27:05 +0100 (BST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I have a Samsung R560 laptop running amd64 Debian testing with a
2.6.29.3 kernel compiled from vanilla sources. Upon resume from
hibernate, it appears that the OS receives a power button event that
causes the system to shut down. I've verified this the best I can by
killing acpid then watching the output of /proc/acpi/event during
hibernate (triggered by writing 'disk' to /sys/power/state).

This problem looked very similar to that discussed in another Bugzilla
entry (http://bugzilla.kernel.org/show_bug.cgi?id=6612) so I had I
extended the changes made by the patch in the obvious way to the S4
state but it made no difference. Is this something the kernel should be
handling? How can I debug this further?

Many thanks,

Francis
