From: Andi Kleen <andi@firstfloor.org>
Subject: Re: How can a patch be merged upstream?
Date: Thu, 28 Aug 2008 01:09:39 +0200
Message-ID: <20080827230939.GF26610@one.firstfloor.org>
References: <5f6f8c5f0808250726h4649ddferff1be82c7d6203ba@mail.gmail.com> <1219712802.4116.32.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:47227 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbYH0XHG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 19:07:06 -0400
Content-Disposition: inline
In-Reply-To: <1219712802.4116.32.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Joshua C." <joshuacov@googlemail.com>, linux-acpi@vger.kernel.org, andi@firstfloor.org, lenb@kernel.org

> Linux can't work normally while Windows can work on such broken BIOS. Of
> course the issue is related with the broken BIOS. The _REG object of EC
> device is incorrect, which causes that EC device can't be initialized
> correctly. 
> After this workaround patch is applied, Linux can also work. IMO this
> workaround patch is reasonable. 

Can you please submit it with proper description?

> > +		if (status == AE_NOT_FOUND) {
> > +			/*
> > +			 * Maybe OS fails in evaluating the _REG object.
> > +			 * The AE_NOT_FOUND error will be ignored and OS
> > +			 * continue to initialize EC.
> > +			 */
> > +			printk(KERN_ERR "Fail in evaluating _REG object."
> > +				" It is broken BIOS.\n");

The English could be improved.

"Failure in evaluation _REG object .... Broken BIOS suspected."

Also could you output the path to the object too for easier 
diagnosis?

-Andi
