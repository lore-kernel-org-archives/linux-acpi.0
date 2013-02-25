From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Fixups for ACPI initrd table override
Date: Mon, 25 Feb 2013 10:48:53 -0800
Message-ID: <512BB215.6030807@zytor.com>
References: <1361538742-67599-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60244 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab3BYSuF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2013 13:50:05 -0500
In-Reply-To: <1361538742-67599-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, aaron.lu@intel.com, devurandom@gmx.net

On 02/22/2013 05:12 AM, Thomas Renninger wrote:
> These are rather minor fixups for code correctness.
> Except the dependency for X86 which avoids build errors on IA64.
> 
> Sooner or later this X86 dependency (max_low_pfn_mapped) should vanish
> from ACPI code, but for now just get the build failure quickly fixed with
> an easy patch (the Kconfig one).
> 

Please send the cleanup one again after the merge window is over.

The build error is an urgent fix; I will take that now.

	-hpa

