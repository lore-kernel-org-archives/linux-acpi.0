From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [patch 11/14] ACPI: change GFP_ATOMIC to GFP_KERNEL for non-atomic
 allocation
Date: Fri, 25 Aug 2006 11:00:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0608251057310.29284@twin.jikos.cz>
References: <200608150537.k7F5bTu8011560@shell0.pdx.osdl.net>
 <200608161902.02221.len.brown@intel.com> <Pine.LNX.4.58.0608171104390.28168@twin.jikos.cz>
 <200608240243.12218.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:21401 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751347AbWHYJBa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Aug 2006 05:01:30 -0400
In-Reply-To: <200608240243.12218.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org

On Thu, 24 Aug 2006, Len Brown wrote:

> to address this on boot, Linux uses system-state. I suggested doing the
> same for resume, but Andrew didn't like it, so here we are chasing a
> bunch of spurious warning messages. Got any random examples that are
> still valid in greg's tree, my tree, or the latest mm?

Actually I just pulled from the acpi git tree, and with this kernel my IBM 
T42p hangs approximately 10s after the kernel is started (hard lockup, no 
caps/numlock). Will investigate.

-- 
JiKos.
