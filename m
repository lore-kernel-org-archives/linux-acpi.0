From: Frank <frank@61924.nl>
Subject: Toshiba Satellite L650D-10J only boots with acpi=off
Date: Sat, 28 Aug 2010 19:25:38 +0200
Message-ID: <20100828192538.666c34c4.frank@61924.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail6.webfaction.com ([74.55.86.74]:57622 "EHLO
	smtp.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab0H1SAO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Aug 2010 14:00:14 -0400
Received: from localhost.localdomain (ip4da71572.direct-adsl.nl [77.167.21.114])
	by smtp.webfaction.com (Postfix) with ESMTP id 5294732031B
	for <linux-acpi@vger.kernel.org>; Sat, 28 Aug 2010 12:31:56 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I purchased a Toshiba Satellite L650D-10J a few days ago and when I
wanted to install Archlinux I was only able to boot the installer with
acpi=off. The same goes for the installed OS.

I asked on ##kernel on freenode and one guy said I should mail this
issue to this mailing list. And include all the information I have.

This is what I get when I boot without acpi=off:
http://i.imagehost.org/view/0872/DSC00071
http://a.imagehost.org/view/0172/DSC00069

The system boots normally when I use acpi=off, but the dual-core CPU is
seen as a CPU with one core. And X is slow with starting up and doesn't
shutdown when I close Openbox, but I'm not sure if that's even related.

Here's the dmesg:
http://codepad.org/W7EzULKf

And the lspci:
http://codepad.org/ce1boP3r

I'm using the stock Archlinux x86_64 kernel (the latest is 2.6.35.3-1
at this moment) and the config files can be found here:
http://repos.archlinux.org/wsvn/packages/kernel26/repos/core-x86_64/

If more information is needed, I'll glady provide it.

Regards,
Frank
