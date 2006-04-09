From: Andi Kleen <ak@suse.de>
Subject: Re: kernel vs user power management
Date: Sun, 9 Apr 2006 08:07:14 +0200
Message-ID: <200604090807.15079.ak@suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB622B275@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39145 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964909AbWDIGHW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Apr 2006 02:07:22 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB622B275@hdsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Holger Macht <hmacht@suse.de>, thoenig@suse.de, linux-acpi@vger.kernel.org, linux-laptop@vger.kernel.org, jacob.shin@amd.com

On Sunday 09 April 2006 05:06, Brown, Len wrote:

> >Furthermore, we had some problems on multiprocessor systems in the past
> >(about 1/2 year ago) with the ondemand governor. After some time the
> >system was running (even some hours or even days) the machine locked up
> >hard.  Thus, we set the userspace governor by default on those systems
> >where we never experienced such problems. At the moment I did 
> >only get one similar report where the root cause is not clear.
> 
> It is important that this failure be root caused and this
> doubt be put behind us.  Got a bug URL?

IIRC that was a powernow-k8 problem - should be fixed now.

> I don't know if the amd-specific drivers would work or not.
> Last I heard their latency was too high, but maybe they've
> fixed that.

I don't think so.

> I think you'll need to keep the userspace backup scheme for systems
> which have switching latency too high to load and run ondemand.

That would be pretty much all AMD systems at least.
But it's ugly - it would be better if ondemand worked on those too.
Anyways not your problem I guess, Len.


> >If so, I fully agree with you. But I do not set a specific 
> >policy in the powersave code explicitely for that feature.
> >If the policy information
> >will go into the kernel, I will use and set this one, of course.
> 
> okay, great.
> Yes, the kernel folks have known for years that this has to be done.
> Hopefully progress will be made soon...

I'm hoping the kernel will be able to put USB mouses to sleep 
soon at least.

-Andi
