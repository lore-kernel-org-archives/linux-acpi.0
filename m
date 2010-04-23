From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] acpi: silence kmemcheck false positive
Date: Fri, 23 Apr 2010 21:17:14 +0200
Message-ID: <20100423191714.GJ29093@bicker>
References: <20100422194346.GB29093@bicker> <20100422200220.GC29093@bicker> <201004221632.21129.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:33263 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab0DWTRj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2010 15:17:39 -0400
Received: by wwg30 with SMTP id 30so187998wwg.19
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2010 12:17:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201004221632.21129.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Shaohua Li <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, vegardno@ifi.uio.no, casteyde.christian@free.fr

On Thu, Apr 22, 2010 at 04:32:20PM -0600, Bjorn Helgaas wrote:
> > > -	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
> > > +	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC | __GFP_NOTRACK_FALSE_POSITIVE);
> 
> Just in terms of reading the code, this solution is fairly ugly.
> I think __GFP_NOTRACK should be sort of the last resort, after we've
> ruled out all the more conventional strategies.
> 
> Has anybody tried any of the alternatives Vegard suggested here:
> https://bugzilla.kernel.org/show_bug.cgi?id=14998#c35 ?

Another potential solution would be to change the kmalloc() to a
kzalloc().

This isn't really my code, I was just randomly poking through bugzilla.
Tell me which approach you prefer and I'll do it.

regards,
dan carpenter

