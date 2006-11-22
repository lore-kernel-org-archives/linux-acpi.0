From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: problems about ACPI sysfs convert work
Date: Wed, 22 Nov 2006 22:25:04 +0000
Message-ID: <20061122222504.GA2477@srcf.ucam.org>
References: <58A36151585E4047913F40517D307BAE01719E@pdsmsx404.ccr.corp.intel.com> <1164021493.3721.229.camel@queen.suse.de> <20061121163438.GA16748@srcf.ucam.org> <200611221712.37199.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:39878 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1757078AbWKVWZI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Nov 2006 17:25:08 -0500
Content-Disposition: inline
In-Reply-To: <200611221712.37199.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, "Li, Shaohua" <shaohua.li@intel.com>, "Yu, Luming" <luming.yu@intel.com>, Kay Sievers <kasievers@suse.de>

On Wed, Nov 22, 2006 at 05:12:35PM -0500, Len Brown wrote:
> Matthew, exactly what code in "the clock driver" to you refer to that
> should be involved here?

http://lkml.org/lkml/2006/7/15/85 - looking closer, it may not have been 
merged yet. But it hooks the ACPI clock information into the general RTC 
framework, so sounds like the right sort of answer.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
