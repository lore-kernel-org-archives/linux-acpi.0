From: Robin Holt <holt@sgi.com>
Subject: Re: some new unaligned access while booting ia64 (HP rx2620)
Date: Sat, 11 Feb 2006 06:21:25 -0600
Message-ID: <20060211122125.GC889@lnx-holt.americas.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05AD5E4F@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from omx1-ext.sgi.com ([192.48.179.11]:38312 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751411AbWBKMVh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Feb 2006 07:21:37 -0500
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F05AD5E4F@scsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Thomas Renninger <trenn@suse.de>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org

Tony,

Did you compile with CONFIG_DEBUG_INFO?  If so, an
objdump -l --start-address=0xa0000001003afaa0 --stop-address=a0000001003b0000 vmlinux
would give us an idea of the line number and operation being performed.

Thanks,
Robin


On Fri, Feb 10, 2006 at 04:39:55PM -0800, Luck, Tony wrote:
> kernel unaligned access to 0xe000004040e7263c, ip=0xa0000001003afb00
> Badness in ia64_handle_unaligned at arch/ia64/kernel/unaligned.c:1349
