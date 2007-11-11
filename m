From: Tomas Carnecky <tom@dbservice.com>
Subject: acpid and /proc/acpi/events
Date: Sun, 11 Nov 2007 15:14:39 +0100
Message-ID: <47370E4F.5040101@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from neopsis.com ([213.239.204.14]:56797 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756449AbXKKOs6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Nov 2007 09:48:58 -0500
Received: from [192.168.0.11] (gw.ptr-62-65-141-13.customer.ch.netstream.com [62.65.141.13])
	by matterhorn.dbservice.com (Postfix) with ESMTP id 2AC9A20B7600
	for <linux-acpi@vger.kernel.org>; Sun, 11 Nov 2007 15:14:42 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Now that /proc/acpi/events will soon be removed, are there any plans to
port acpid to the evdev/netlink interfaces?

thanks
tom
