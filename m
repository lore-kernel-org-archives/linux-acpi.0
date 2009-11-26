From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI video: print out a warning message when duplicate
	video bus devices under the same VGA controller are detected
Date: Thu, 26 Nov 2009 05:10:08 +0000
Message-ID: <20091126051008.GB7874@srcf.ucam.org>
References: <1259140608.10510.62.camel@rzhang1-desktop> <alpine.LFD.2.00.0911251638220.3950@localhost.localdomain> <1259197533.10510.76.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52956 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbZKZFKM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2009 00:10:12 -0500
Content-Disposition: inline
In-Reply-To: <1259197533.10510.76.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Nov 26, 2009 at 09:05:33AM +0800, Zhang Rui wrote:

> If this bug is not rare, then we can set up a dmi list to choose the
> working video bus device for these laptops.

Any time somebody says "we can set up a dmi list", we've already failed. 
Does Windows work on this system without platform-specific drivers? If 
so, Linux is wrong and a dmi approach is incorrect. Does Windows require 
a platform-specific driver? If so, Linux should also require a 
platform-specific driver and a dmi approach in the core code is 
incorrect.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
