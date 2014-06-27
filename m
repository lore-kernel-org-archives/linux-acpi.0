From: ayaka <ayaka@soulik.info>
Subject: power off problem in Dell 15-7537
Date: Fri, 27 Jun 2014 21:12:18 +0800
Message-ID: <53AD6DB2.2040301@soulik.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kozue.soulik.info ([108.61.222.116]:41280 "EHLO
	kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbaF0NSV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jun 2014 09:18:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net

I have a Dell 15-7537 laptop install fedora 20 with kernel 3.14.8. But I
can't power off my laptop using systemctl poweroff, I have tried openrc
in gentoo, it couldn't either. Once I let systemctl power off my laptop,
it will, but it actually do the reboot, I have to press power button on
laptop or type halt in grub2, but it will cause the other reboot, after
the second reboot, I could power off my laptop this time. But in the
Windows 8.1, I don't need to do that, just click power off it would
power off my laptop properly.

Thanks
