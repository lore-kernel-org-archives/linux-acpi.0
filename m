From: Greg KH <greg@kroah.com>
Subject: Re: Options depending on STANDALONE
Date: Thu, 3 Aug 2006 13:28:07 -0700
Message-ID: <20060803202807.GA7712@kroah.com>
References: <44D1CC7D.4010600@vmware.com> <1154603822.2965.18.camel@laptopd505.fenrus.org> <44D23B84.6090605@vmware.com> <20060803190327.GA14237@kroah.com> <44D24B31.2080802@vmware.com> <20060803193600.GA14858@kroah.com> <20060803195617.GD16927@redhat.com> <20060803202543.GH25692@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:26012 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751165AbWHCUcx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2006 16:32:53 -0400
Content-Disposition: inline
In-Reply-To: <20060803202543.GH25692@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>, Arjan van de Ven <arjan@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>, v4l-dvb-maintainer@linuxtv.org, linux-acpi@vger.kernel.org

On Thu, Aug 03, 2006 at 10:25:43PM +0200, Adrian Bunk wrote:
> ACPI_CUSTOM_DSDT seems to be the most interesting case.
> It's anyway not usable for distribution kernels, and AFAIR the ACPI 
> people prefer to get the kernel working with all original DSDTs
> (which usually work with at least one other OS) than letting the people 
> workaround the problem by using a custom DSDT.

Not true at all.  For SuSE kernels, we have a patch that lets people
load a new DSDT from initramfs due to broken machines requiring a
replacement in order to work properly.

thanks,

greg k-h
