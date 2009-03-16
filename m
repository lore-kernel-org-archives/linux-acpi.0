From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: The Garbled screen issue on Sony laptops with two graphics (Intel and Nvidia)
Date: Mon, 16 Mar 2009 10:24:23 +0000
Message-ID: <20090316102423.GA16889@srcf.ucam.org>
References: <1236739527.2820.178.camel@rzhang-dt> <20090311024652.GA14493@srcf.ucam.org> <1236756550.2820.218.camel@rzhang-dt> <20090311130847.GC13101@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38303 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbZCPKYa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 06:24:30 -0400
Content-Disposition: inline
In-Reply-To: <20090311130847.GC13101@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, Mar 11, 2009 at 10:08:47PM +0900, Mattia Dongili wrote:

> - some models have different magic numbers for the _DSM invocation, from
>   the DSDT I have available:
> 	DSDT.sz.xxx.dsl (some uknown model)
> 	DSDT.sz61mn-forXP.dsl
> 	DSDT.tt11lnb.dsl
> 	DSDT.z11vn.dsl
> 	DSDT.z90s.dsl
> 	VGN-SZ4XWNC-R0111N0.dsl
>   and for what I can see, z and tt have the same magic numbers while the
>   sz has different ones. So the code that calls _DSM will need to have
>   some DMI switch to make sure we are calling it with the right
>   parameters (for now supporting z and tt might be enough)

_DSM is "Device Specific Method". The magic numbers it requires are 
interface descriptions. How many of these machines have nvidia-based 
dual GPU architectures? Are the _DSM methods always attached to the 
nvidia device?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
