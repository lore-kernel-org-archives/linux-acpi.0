From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: The Garbled screen issue on Sony laptops with two graphics (Intel and Nvidia)
Date: Wed, 11 Mar 2009 02:46:52 +0000
Message-ID: <20090311024652.GA14493@srcf.ucam.org>
References: <1236739527.2820.178.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42521 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbZCKCrD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2009 22:47:03 -0400
Content-Disposition: inline
In-Reply-To: <1236739527.2820.178.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, Mar 11, 2009 at 10:45:27AM +0800, Zhang Rui wrote:

> The problem can be fixed by disabling Nvidia card via ACPI _DSM method.
> And it seems that there are some works already done for this issue.
> http://archive.netbsd.se/?ml=xorg&a=2009-02&t=9908058

This method is specific to Sony. What would be most helpful here would 
be for Intel to tell us how this is actually meant to work. 

-- 
Matthew Garrett | mjg59@srcf.ucam.org
