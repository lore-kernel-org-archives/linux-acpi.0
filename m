From: Holger Macht <hmacht@suse.de>
Subject: Re: kernel vs user power management
Date: Wed, 17 May 2006 19:41:24 +0200
Message-ID: <20060517174123.GA7092@linux-ersb>
References: <CFF307C98FEABE47A452B27C06B85BB679BACB@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-laptop-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB679BACB@hdsmsx411.amr.corp.intel.com>
Sender: linux-laptop-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: thoenig@suse.de, linux-acpi@vger.kernel.org, linux-laptop@vger.kernel.org, Andi Kleen <ak@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Wed 17. May - 11:41:16, Brown, Len wrote:
>  
> >> I installed SL10.1 today on a P3M laptop (Dell D600)
> >> and it defaults to the "Powersave" scheme which includes
> >> "Dynamic Frequency Scaling" (ondemand), so that is good.
> >> 
> >> However, by defaulit "Allow Throttling" is CHECKED
> >> and Max %  is set to 50%.
> >> 
> >> Exactly what does this mean?
> >> I looked in /proc/acpi/processor/*/throttling and the
> >> laptop is still in T0.
> >
> >It means that the powersaved throttles your CPU if there is no load and
> >dethrottles if there is load. It's that way already for 
> >several years and
> >I only got a report about performance loss on SMP systems, so 
> >we don't do
> >throttling by default on those systems.
> 
> I see -- my test platform changed from dual-core to single-core,
> so I didn't see this issue before.
> 
> >> Is there an easy way for me to modify the kernel to
> >> convince the powersaved application that the system
> >> does not support throttling?  I'm thinking that we've
> >> given user-space too much rope and it has proceeded
> >> to hang itself.
> >
> >I'm currently working on a solution to allow throttling only on systems
> >which don't support CPUfreq. At the point this thread came up, or a few
> >days later as we talked about it, I completely agreed with you. But at
> >that time we already had RC1 in regard to SUSE Linux 10.1, so 
> >there was no
> >possibility anymore to change such a default behaviour. For 
> >the unstable
> >powersave realeases, there will come up some changes soon, though.
> 
> I understand, though I think it would be more practical to not
> enable throttling by default on any system; and for systems
> with cpufreq to not even advertise this option to users.

Agreed. We kept this already far too long without seeing a real gain.

> 
> Also, I think something is broken today.
> If I use the GUI to disable throttling in the Powersave scheme
> and save, and then pull out the plug; a window with "watch
> .../throttling"
> shows that the system drops into T2, and then bounces back to T0.

I really don't see a possibility that powersaved could be the culprit in
this case. If it's disabled in /etc/powersave/scheme_powersave, well it
surely doesn't touch this file:

  bool ThrottleInterface::throttle(int percent)
  {
         if (!_throttling_supported
	     || !config_obj->current_scheme->ALLOW_THROTTLING) {
		return false;
         }
  ...
  }

> 
> I don't trust the application to keep its hands off this file,
> so I think that I need a way to disable/remove that file.

If you can reproduce that it switches to T2 when you do a rcpowersaved
restart or on every unplug, it would actually be a bug which is worth
to be reported.


Regards,
	Holger
