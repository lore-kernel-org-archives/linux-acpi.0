From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Sat, 20 Mar 2010 21:51:56 +0100
Message-ID: <201003202151.57008.trenn@suse.de>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com> <201003191755.35421.trenn@suse.de> <4BA3B315.6080905@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55390 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592Ab0CTUvw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 Mar 2010 16:51:52 -0400
In-Reply-To: <4BA3B315.6080905@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: ykzhao <yakui.zhao@intel.com>, chen gong <gong.chen@linux.intel.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday 19 March 2010 06:23:33 pm Prarit Bhargava wrote:
> > Blocking does not work.
> > But I have an idea, whatabout:
> >   - CPU add rule which only adds a CPU if the corresponding Numa node
> > already has onlined memory
> >   - Memory add rule which adds the memory and also onlines CPUs if the
> > Numa node still has offlined CPUs
> >
> > This has the side effect that you online a CPU which may have been
> > offlined on purpose if you hotadd memory on the same node..., a rather
> > uncommon case.
>
> That actually might be more of a problem than you think.  It's not
> atypical that in the evening a system's components are offlined in order
> to save power.
This shouldn't be a problem currently, because offlined CPUs drain more
power than online ones:
http://bugzilla.kernel.org/show_bug.cgi?id=5471

> Maintenance also is scheduled for downtime
I don't understand this part.
> so when  
> memory is added to the system we may bring cpus into service
> erroneously.  I think the "end-user" may not be too happy with this result.
...
> > I wanted to post something today, but I couldn't made it.
> > Still I more or less could prove that above works and I hopefully can
> > show some results on Monday.
>
> If it works then I'm all for it :)
Great. I'll hopefully post some patches in a new thread soon and try to 
collect all interested people in CC.

     Thomas
