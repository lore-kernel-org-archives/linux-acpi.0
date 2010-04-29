From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi: fix early DSDT dmi check warnings on ia64
Date: Thu, 29 Apr 2010 10:42:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004291036590.22770@sony>
References: <1272505354.9950.16.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [12.175.186.2] ([12.175.186.2]:41717 "EHLO
	vbn.0055647.lodgenet.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1758871Ab0EABoc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Apr 2010 21:44:32 -0400
In-Reply-To: <1272505354.9950.16.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: tony.luck@intel.com, linux-acpi <linux-acpi@vger.kernel.org>

x86 calls dmi_scan_machine() to initialize DMI
from setup_arch().

ia64 calls dmi_scan_machine() from core_initcall()

Maybe they should both call it from the same place?

Also, ia64 should not parse entries which are known
at compile-time to be x86 specific

thanks,
Len Brown, Intel Open Source Technology Center

