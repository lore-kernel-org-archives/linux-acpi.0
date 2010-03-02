From: Chase Douglas <chase.douglas@ubuntu.com>
Subject: Re: [PATCH] Reduce ACPI resource conflict message to KERN_INFO
Date: Tue, 02 Mar 2010 18:45:01 -0500
Message-ID: <1267573501.12051.25.camel@cndougla-ubuntu>
References: <1267564152-11048-1-git-send-email-chase.douglas@ubuntu.com>
	 <201003021614.34026.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:50791 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757566Ab0CBXpH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2010 18:45:07 -0500
In-Reply-To: <201003021614.34026.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 2010-03-02 at 16:14 -0700, Bjorn Helgaas wrote:
> On Tuesday 02 March 2010 02:09:12 pm Chase Douglas wrote:
> > -			printk("%sACPI: %s resource %s [0x%llx-0x%llx]"
> > +			printk(KERN_INFO "ACPI: %s resource %s [0x%llx-0x%llx]"
> >  			       " conflicts with ACPI region %s"
> >  			       " [0x%llx-0x%llx]\n",
> > -			       acpi_enforce_resources == ENFORCE_RESOURCES_LAX
> > -			       ? KERN_WARNING : KERN_ERR,
> >  			       ioport ? "I/O" : "Memory", res->name,
> >  			       (long long) res->start, (long long) res->end,
> >  			       res_list_elem->name,
> 
> Since you're touching this anyway, can you convert this to use %pR?

I see the potential usage of %p, but is the 'R' a typo? I haven't found
it in man 3 fprintf nor in a google search.

Thanks,
Chase

