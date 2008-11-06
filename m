From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 01/11] ACPI: update debug parameter documentation
Date: Thu, 06 Nov 2008 14:24:35 -0800
Message-ID: <49136EA3.7080709@xenotime.net>
References: <20081105231710.26131.3110.stgit@bob.kio> <20081105231737.26131.62046.stgit@bob.kio> <alpine.LFD.2.00.0811061502100.3106@localhost.localdomain> <200811061422.39997.bjorn.helgaas@hp.com> <alpine.LFD.2.00.0811061705450.3106@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.64.118]:42080 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751175AbYKFWfD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Nov 2008 17:35:03 -0500
Received: from ::ffff:98.99.121.230 ([98.99.121.230]) by xenotime.net for <linux-acpi@vger.kernel.org>; Thu, 6 Nov 2008 14:24:58 -0800
In-Reply-To: <alpine.LFD.2.00.0811061705450.3106@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Thomas Renninger <trenn@suse.de>

Len Brown wrote:
> 
>>> $ cat /sys/module/acpi/parameters/debug_layer
> 
>> I don't really like having the whole list in the doc either.
>> One problem with using only a pointer to the sysfs file is
>> that you have to have a booted machine with ACPI_DEBUG=y.
> 
> Good point.
> Maybe in kernel-parameters.txt we should point to
> a Documedntation/acpi/debug.txt file with this stuff in it?

I think that's a good compromise.  It should be available
somewhere other than a source or header file IMO.  I.e.,
some place in Documentation/[acpi].

~Randy

