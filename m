From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v3 3/8] x86, cpu: provide a function
 topology_num_packages to enumerate #packages
Date: Mon, 12 Sep 2016 13:51:51 -0700
Message-ID: <1473713511.3916.50.camel@linux.intel.com>
References: <1473373615-51427-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1473373615-51427-4-git-send-email-srinivas.pandruvada@linux.intel.com>
         <alpine.DEB.2.20.1609101513410.2804@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:42303 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756781AbcILUvy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Sep 2016 16:51:54 -0400
In-Reply-To: <alpine.DEB.2.20.1609101513410.2804@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org

On Sat, 2016-09-10 at 15:28 +0200, Thomas Gleixner wrote:
> B1;2802;0cOn Thu, 8 Sep 2016, Srinivas Pandruvada wrote:
> 
> > 
> > From: Tim Chen <tim.c.chen@linux.intel.com>
> $subject: x86, cpu: provide a function topology_num_packages  to enumerate #packages
> 
> - we switched to the prefix scheme 'x86/subsys'. Please use this.
> 
> - this is not related to x86/cpu. x86/topology is the proper prefix.
> 
> - Sentence after ':' starts with an uppercase letter.
> 
> - please make the subject line short and descriptive. 
> 
>   x86/topology: Provide topology_num_packages()
> 
>   is completely sufficient, because it's entirely clear that it is a
>   function and the function name is self explaining.

Will do.

> 
> > 
> > We compute the the number of active packages during boot and
> > topology update.
> We? We do not do anything..... and how is that information useful for the
> reader?
> 
> > 
> > Provide a function to export this info for functions that need this
> > topology info.
> Well, it's obvious that a new function is going to be used by something
> which needs it.
> 
> In changelogs/comments there is only one thing worse than superflous
> informatioin: wrong information.
> 
> If you have nothing to say, then omit it instead of forcing the reader to
> parse incoherent blurbs for nothing.
> 
> > 
> >  int topology_update_package_map(unsigned int apicid, unsigned int cpu);
> > +extern int topology_num_packages(void);
> >  extern int topology_phys_to_logical_pkg(unsigned int pkg);
> >  #else
> >  #define topology_max_packages()			(1)
> stub function for the !SMP case is missing....
> 
> Thanks,
> 
> 	tglx
