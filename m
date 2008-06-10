From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 07/11] acpi: change processors from array to per_cpu
 variable
Date: Tue, 10 Jun 2008 13:31:34 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806101330560.14381@localhost.localdomain>
References: <200806092322.m59NMNNC013973@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:34439 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbYFJRde (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jun 2008 13:33:34 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K29007F8COO48F0@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 10 Jun 2008 12:31:40 -0500 (CDT)
In-reply-to: <200806092322.m59NMNNC013973@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, travis@sgi.com, len.brown@intel.com



On Mon, 9 Jun 2008, akpm@linux-foundation.org wrote:

> From: Mike Travis <travis@sgi.com>
> 
> Change processors from an array sized by NR_CPUS to a per_cpu variable.

applied for 2.6.27.

thanks,
-Len
