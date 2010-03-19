From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Fri, 19 Mar 2010 13:23:33 -0400
Message-ID: <4BA3B315.6080905@redhat.com>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com> <201003121418.14204.trenn@suse.de> <4BA123DB.5050807@redhat.com> <201003191755.35421.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45163 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab0CSRXk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Mar 2010 13:23:40 -0400
In-Reply-To: <201003191755.35421.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ykzhao <yakui.zhao@intel.com>, chen gong <gong.chen@linux.intel.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


>
> Blocking does not work.
> But I have an idea, whatabout:
>   - CPU add rule which only adds a CPU if the corresponding Numa node already
>     has onlined memory
>   - Memory add rule which adds the memory and also onlines CPUs if the Numa
>     node still has offlined CPUs
>
> This has the side effect that you online a CPU which may have been offlined on
> purpose if you hotadd memory on the same node..., a rather uncommon case.
>
>   
That actually might be more of a problem than you think.  It's not 
atypical that in the evening a system's components are offlined in order 
to save power.  Maintenance also is scheduled for downtime so when 
memory is added to the system we may bring cpus into service 
erroneously.  I think the "end-user" may not be too happy with this result.

[OTOH, a little documentation could fix that issue]

> A quick try showed that it would be convenient to add the Numa node to the 
> uevent which is a bit tricky...
> Ok, I got this working, but messed up the cpu hotplugging with my patches:
> ...
> Unable to map lapic 32 to logical cpu number
> ...
> This already worked...
>
> I wanted to post something today, but I couldn't made it.
> Still I more or less could prove that above works and I hopefully can show
> some results on Monday.
>
>   

If it works then I'm all for it :)

> Comments?
>
>    Thomas
>
> BTW: I was wrong with slub. It also has bad side effects. What is strange is 
>   

FWIW, I'm testing with slab.

P.

