From: Michal Hocko <mhocko@kernel.org>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Tue, 25 Jul 2017 14:48:37 +0200
Message-ID: <20170725124837.GH26723@dhcp22.suse.cz>
References: <20170711082532.GA6927@dhcp22.suse.cz>
 <20170713065806.GB2901@linux-l9pv.suse>
 <20170713070618.GC14492@dhcp22.suse.cz>
 <20170713124521.GE2901@linux-l9pv.suse>
 <20170714083713.GB2618@dhcp22.suse.cz>
 <20170714144414.GM2901@linux-l9pv.suse>
 <20170717090525.GF12888@dhcp22.suse.cz>
 <20170719090910.GK26098@linux-l9pv.suse>
 <20170724085702.GE25221@dhcp22.suse.cz>
 <20170724092921.GF3034@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724092921.GF3034@linux-l9pv.suse>
Sender: linux-kernel-owner@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon 24-07-17 17:29:21, Joey Lee wrote:
> On Mon, Jul 24, 2017 at 10:57:02AM +0200, Michal Hocko wrote:
> > On Wed 19-07-17 17:09:10, Joey Lee wrote:
> > > On Mon, Jul 17, 2017 at 11:05:25AM +0200, Michal Hocko wrote:
> > [...]
> > > > The problem I have with this expectation is that userspace will never
> > > > have a good atomic view of the whole container. So it can only try to
> > > 
> > > I agreed!
> > > 
> > > Even a userspace application can handle part of offline jobs. It's
> > > still possible that other kernel/userland compenents are using the
> > > resource in container.
> > > 
> > > > eject and then hope that nobody has onlined part of the container.
> > > > If you emit offline event to the userspace the cleanup can be done and
> > > > after the last component goes offline then the eject can be done
> > > > atomically.
> > > 
> > > The thing that we didn't align is how does kernel maintains the flag
> > > of ejection state on container.
> > 
> > Why it cannot be an attribute of the container? The flag would be set
> > when the eject operation is requested and cleared when either the
> > operation is successful (all parts offline and eject operation acked
> > by the BIOS) or it is terminated.
> >
> 
> For the success case, yes, we can clear the flag when the _EJ0 of container
> is success. But for the fail case, we don't know when the operation is
> terminated.

Hmm, this is rather strange. What is the BIOS state in the meantime?
Let's say it doesn't retry. Does it wait for the OS for ever?

> > [...]
> > > Base on the above figure, if userspace didn't do anything or it
> > > just performs part of offline jobs. Then the container's [eject]
> > > state will be always _SET_ there, and kernel will always check
> > > the the latest child offline state when any child be offlined
> > > by userspace.
> > 
> > What is a problem about that? The eject is simply in progress until all
> > is set. Or maybe I just misunderstood.
> >
> 
> I agree, but it's only for success case. For fail case, kernel can not
> wait forever. Can we?

Well, this won't consume any additional resources so I wouldn't be all
that worried. Maybe we can reset the flag as soon as somebody tries to
online some part of the container?

-- 
Michal Hocko
SUSE Labs
