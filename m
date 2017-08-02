From: Michal Hocko <mhocko@kernel.org>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Wed, 2 Aug 2017 11:01:43 +0200
Message-ID: <20170802090143.GG2524@dhcp22.suse.cz>
References: <20170713070618.GC14492@dhcp22.suse.cz>
 <20170713124521.GE2901@linux-l9pv.suse>
 <20170714083713.GB2618@dhcp22.suse.cz>
 <20170714144414.GM2901@linux-l9pv.suse>
 <20170717090525.GF12888@dhcp22.suse.cz>
 <20170719090910.GK26098@linux-l9pv.suse>
 <20170724085702.GE25221@dhcp22.suse.cz>
 <20170724092921.GF3034@linux-l9pv.suse>
 <20170725124837.GH26723@dhcp22.suse.cz>
 <20170731073845.GC2946@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170731073845.GC2946@linux-l9pv.suse>
Sender: linux-kernel-owner@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon 31-07-17 15:38:45, Joey Lee wrote:
> Hi Michal,
> 
> Sorry for my delay...
> 
> On Tue, Jul 25, 2017 at 02:48:37PM +0200, Michal Hocko wrote:
> > On Mon 24-07-17 17:29:21, Joey Lee wrote:
[...]
> > > For the success case, yes, we can clear the flag when the _EJ0 of container
> > > is success. But for the fail case, we don't know when the operation is
> > > terminated.
> > 
> > Hmm, this is rather strange. What is the BIOS state in the meantime?
> > Let's say it doesn't retry. Does it wait for the OS for ever?
> > 
> 
> Unfortunately ACPI spec doesn't mention the detail of BIOS behavior for
> container hot-removing.
> 
> IMHO, if the BIOS doesn't retry, at least it should maintains a timer
> to handle the OS layer time out then BIOS resets hardware(turns off
> progress light or something else...).
> 
> The old BIOS just treats the ejection event as a button event. BIOS
> emits 0x103 ejection event to OS after user presses a button or UI.
> Then BIOS hopes that OS(either kernel or userland) finishs all jobs,
> calls _EJ0 to turn off power, and calls _OST to return state to BIOS.
> 
> If the ejection event from BIOS doesn't trigger anything in upper OS
> layer, old BIOS can not against this situation unless it has a timer.

Right but I would consider that a BIOS problem. It is simply not
feasible to expect that OS will react in instance. Especially when we
are talking about resources like memory which takes time proportional to
the size to tear down properly.
 
> > > > [...]
> > > > > Base on the above figure, if userspace didn't do anything or it
> > > > > just performs part of offline jobs. Then the container's [eject]
> > > > > state will be always _SET_ there, and kernel will always check
> > > > > the the latest child offline state when any child be offlined
> > > > > by userspace.
> > > > 
> > > > What is a problem about that? The eject is simply in progress until all
> > > > is set. Or maybe I just misunderstood.
> > > >
> > > 
> > > I agree, but it's only for success case. For fail case, kernel can not
> > > wait forever. Can we?
> > 
> > Well, this won't consume any additional resources so I wouldn't be all
> > that worried. Maybe we can reset the flag as soon as somebody tries to
> > online some part of the container?
> >
> 
> So, the behavior is:
> 
> Kernel received ejection event, set _Eject_ flag on container object
>   -> Kernel sends offline events to all children devices
>     -> User space performs cleaning jobs and offlines each child device
>       -> Kernel detects all children offlined
> 	-> Kernel removes objects and calls power off(_EJ0)

Yes this is what I've had in mind. It is the "kernel detects..." part
which is not implemented now and that requires us to do the explicit
eject from userspace, correct?

> If anyone onlined one of the children devices in the term of waiting
> userland offlines all children, then the _Eject_ flag will be clean
> and ejection process will be interrupted. In this situation, administrator
> needs to trigger ejection event again.

yes

> Do you think that the race hurts anything?

What kind of race?
-- 
Michal Hocko
SUSE Labs
