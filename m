From: joeyli <jlee@suse.com>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Wed, 19 Jul 2017 17:09:10 +0800
Message-ID: <20170719090910.GK26098@linux-l9pv.suse>
References: <20170626062657.GE4229@linux-l9pv.suse>
 <20170626085907.GE11534@dhcp22.suse.cz>
 <20170711082532.GA6927@dhcp22.suse.cz>
 <20170713065806.GB2901@linux-l9pv.suse>
 <20170713070618.GC14492@dhcp22.suse.cz>
 <20170713124521.GE2901@linux-l9pv.suse>
 <20170714083713.GB2618@dhcp22.suse.cz>
 <20170714144414.GM2901@linux-l9pv.suse>
 <20170717090525.GF12888@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:56265 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752788AbdGSJJV (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Wed, 19 Jul 2017 05:09:21 -0400
Content-Disposition: inline
In-Reply-To: <20170717090525.GF12888@dhcp22.suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Mon, Jul 17, 2017 at 11:05:25AM +0200, Michal Hocko wrote:
> On Fri 14-07-17 22:44:14, Joey Lee wrote:
> > On Fri, Jul 14, 2017 at 10:37:13AM +0200, Michal Hocko wrote:
> > > On Thu 13-07-17 20:45:21, Joey Lee wrote:
> > > > On Thu, Jul 13, 2017 at 09:06:19AM +0200, Michal Hocko wrote:
> > > > > On Thu 13-07-17 14:58:06, Joey Lee wrote:
> > > [...]
> > > > > > If BIOS emits ejection event for a ACPI0004 container, someone needs
> > > > > > to handle the offline/eject jobs of container. Either kernel or user
> > > > > > space.
> > > > > >
> > > > > > Only sending uevent to individual child device can simplify udev rule,
> > > > > > but it also means that the kernel needs to offline/eject container
> > > > > > after all children devices are offlined.
> > > > >
> > > > > Why cannot kernel send this eject command to the BIOS if the whole
> > > > > container is offline? If it is not then the kernel would send EBUSY to
> > > >
> > > > Current kernel container hot-remove process:
> > > >
> > > >   BIOS -> SCI event -> Kernel ACPI -> uevent -> userland
> > > >
> > > > Then, kernel just calls _OST to expose state to BIOS, then process is
> > > > stopped. Kernel doesn't wait there for userland to offline each child
> > > > devices. Either BIOS or userland needs to trigger the container
> > > > ejection.
> > > >
> > > > > container is offline? If it is not then the kernel would send EBUSY to
> > > > > the BIOS and BIOS would have to retry after some timeout. Or is it a
> > > >
> > > > The d429e5c122 patch is merged to mainline. So kernel will send
> > > > DEVICE_BUSY to BIOS after it emits uevent to userland. BIOS can choice
> > > > to apply the retry approach until OS returns process failure exactly or
> > > > BIOS timeout.
> > > >
> > > > > problem that currently implemented BIOS firmwares do not implement this
> > > > > retry?
> > > >
> > > > Yes, we should consider the behavior of old BIOS. Old BIOS doesn't
> > > > retry/resend the ejection event. So kernel or userland need to take the
> > > > retry job. Obviously userland runs the retry since the caa73ea15 patch
> > > > is merged.
> > > >
> > > > IMHO there have two different expectation from user space application.
> > > >
> > > > Applications like DVD player or Burner expect that kernel should
> > > > info userspace for the ejection, then application can do their cleaning
> > > > job and re-trigger ejection from userland.
> > >
> > > I am not sure I understand the DVD example because I do not see how it
> > > fits into the container and online/offline scenario.
> > >
> >
> > At least Yasuaki raised similar behavior for container in 2013.
> > It's similar to the DVD player case, user space application needs
> > to do something then trigger children offline and ejection of
> > container.
>
> The problem I have with this expectation is that userspace will never
> have a good atomic view of the whole container. So it can only try to

I agreed!

Even a userspace application can handle part of offline jobs. It's
still possible that other kernel/userland compenents are using the
resource in container.

> eject and then hope that nobody has onlined part of the container.
> If you emit offline event to the userspace the cleanup can be done and
> after the last component goes offline then the eject can be done
> atomically.

The thing that we didn't align is how does kernel maintains the flag
of ejection state on container.

>
> [...]
> > > Hmm, so can we trigger the eject from the _kernel_ when the last child
> > > is offlined?
> >
> > Kernel needs to remember that the container is under a _EJECTION_ state
> > that it should waits all children be offlined. Then kernel checks the
> > container offline state when each individual device is offlined. If
> > kernel found a container offlined (means that all children are offlined),
> > and the container is under ejection state, then kernel runs ejection
> > jobs (removing objects and calls _EJ0).
>
> yes, that is what I meant.
>
> > To achieve this, I think that the container object needs a _EJECTION_
> > flag. It helps kernel to remember the state that it set by BIOS's
> > ejection event.
>
> yes something like that.
>

Good!

> > This approach has some problems: If userland doesn't finish his offline
> > jobs or userland doesn't do anything, when should kernel clears the
> > ejection flag and responses failure by _OST to BIOS?
>
> I do not see how is that any different from the current approach. You
> still cannot do the eject if some component is online and we rely on the
> userspace to do the offline.

I see. I agree with you that it's no different from the current approach.
But I still concern how to maintain the ejection state flag in kernel.

>
> > And, for new BIOS that it has time out mechanism. Currently there have
> > no way for BIOS to tell kernel that it gives up. It's hard to sync the
> > kernel container's ejection flag with BIOS.
>
> I am not sure I understand. The kernel/BIOS synchronization happens on
> the up/down calls between the platform and the kernel...

NO! The container hot-remove process does not synchronize. For new BIOS
that it can retry until time out, so kernel doesn't need to keep the
ejection state of container:

      retry BIOS           Kernel        Userspace
	  |-----SCI------>|----uevent---->|
	  |               |               +----+
	  |<--_OST(Busy)--|               |    |
	  |----+          |               |  clean up
	  |    |          |               |    |
	  |   Wait        |<---offline----+<---+
	  |   Wait        |<---offline----+<---+
	  |   Wait        |<---offline----+<---+
	  |   Wait        |<---offline----+<---+
	  |    |          |               |  
	  |    |          |               |     
	  |<---+          |               |     
	  |---retry SCI-->|----+          |    
	  |               |    |          |   
	  |     	  | check all     | 
          |               | offlined      |     
	  |               |    |          |     
	  |               +<---+          |     
	  |               +----+          |     
	  |               |    |          |     
          |               | ejection      |     
	  |               |    |          |     
	  |<----_EJ0------+<---+          |     
	  |               |               |     
	  |               |               |     
	Time out

But for old BIOS or non-retry BIOS, it doesn't resend
SCI to kernel, so kernel will not run ejection and _EJ0:

      old BIOS           Kernel        Userspace
	  |-----SCI------>|----uevent---->|
	  |               |               +----+
	  |<--_OST(Busy)--|               |    |
	  |----+          |               |  clean up
	  |    |          |               |    |
	  | failure       |<---offline----+<---+
	  |    |          |<---offline----+<---+
	  |<---+          |<---offline----+<---+
	Stop              |<---offline----+<---+
	                  |               |     
	                  |               |     
	 No retry SCI!--->|----+          |    
	                  |    |          |   
	        	  | check all     | 
                          | offlined??    |     
	                  |    |          |     
	                  +<---+          |     
	                  +----+          |     
	                  |    |          |     
                          | ejection??    |     
	                  |    |          |     
	   <----_EJ0??----+<---+          |     
	                  |               |     

So, kernel needs to keep a ejection state flag that it
indicates that BIOS SCI has triggered the container ejection:

	 BIOS           Kernel        Userspace
	  |-----SCI------>|----+event---->|
	  |               |    |          |
	  |               | set [eject]   |
          |               |  flag         |
	  |               |    |          |     
	  |               |<---+          |
	  |               |----uevent---->|
	  |               |               +----+
	  |<--_OST(Busy)--|               |    |
	  |----+          |               |  clean up
	  |    |          |               |    |
	  | failure       |<---offline----+<---+
	  |    |          |<---offline----+<---+
	  |<---+          |<---offline----+<---+
	Stop              |<---offline----+<---+
	                  +----+          |     
	                  |    |          |     
	                  | if container  |
	                  | is in [eject] | 
	                  | state         |     
	                  |    |          |     
	                  |<---+          |     
	                  |----+          |    
	                  |    |          |   
	        	  | check all     | 
                          | offlined      |     
	                  |    |          |     
	                  +<---+          |     
	                  +----+          |     
	                  |    |          |     
                          | ejection??    |     
	  |               |    |          |     
	  |<----_EJ0  ----+<---+          |     
	  |               |               |     

Base on the above figure, if userspace didn't do anything or it
just performs part of offline jobs. Then the container's [eject]
state will be always _SET_ there, and kernel will always check
the the latest child offline state when any child be offlined
by userspace.

On the other hand, for retry BIOS, we will apply the same
_eject_ flag approach on retry BIOS. If the OS performs
offline/ejection jobs too long then the retry BIOS is finally
time out. There doesn't have way for OS to aware the timeout.
So the _eject_ flag is set forever.

Thanks a lot!
Joey Lee
