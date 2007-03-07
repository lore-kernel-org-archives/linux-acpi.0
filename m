From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: post-2.6.20 hangs during boot
Date: Wed, 7 Mar 2007 12:41:20 -0800
Message-ID: <20070307124120.9d9b3bb9.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:30611 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992545AbXCGUnZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Mar 2007 15:43:25 -0500
Received: from rgmgw3.us.oracle.com (rgmgw3.us.oracle.com [138.1.186.112])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id l27KhMAI017604
	for <linux-acpi@vger.kernel.org>; Wed, 7 Mar 2007 14:43:23 -0600
Received: from rcsmt251.oracle.com (rcsmt251.oracle.com [148.87.90.196])
	by rgmgw3.us.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id l27HlFSI024260
	for <linux-acpi@vger.kernel.org>; Wed, 7 Mar 2007 13:43:22 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Anything after 2.6.20-pv (plain vanilla) hangs during boot
for me.  I built a kernel with CONFIG_ACPI_DEBUG=y and booted
with acpi_dbg_level=0x10 acpi_dbg_layer=01x1ff.

Boot log for 2.6.20-git1 is here:
  http://www.xenotime.net/linux/logs/2620-g1-bootlog.txt

Ideas, suggestions?

Thanks,
---
~Randy
