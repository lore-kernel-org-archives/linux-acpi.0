From: joeyli <jlee@suse.com>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Tue, 15 Aug 2017 18:04:03 +0800
Message-ID: <20170815100403.GJ25541@linux-l9pv.suse>
References: <20170713065806.GB2901@linux-l9pv.suse>
 <20170713070618.GC14492@dhcp22.suse.cz>
 <20170713124521.GE2901@linux-l9pv.suse>
 <20170714083713.GB2618@dhcp22.suse.cz>
 <20170714144414.GM2901@linux-l9pv.suse>
 <20170723060248.GA3034@linux-l9pv.suse>
 <b6802e30-cb1e-5fa8-6afc-09b4e05d78c9@gmail.com>
 <20170802054939.GL2946@linux-l9pv.suse>
 <8c04a96f-3f7a-1c31-9522-3344a4751d33@gmail.com>
 <20170804150619.GQ26029@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170804150619.GQ26029@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 04, 2017 at 05:06:19PM +0200, Michal Hocko wrote:
> On Thu 03-08-17 11:37:37, YASUAKI ISHIMATSU wrote:
> > 
> > 
> > On 08/02/2017 01:49 AM, joeyli wrote:
> > > Hi YASUAKI,
> > > 
> > > On Tue, Aug 01, 2017 at 03:21:38PM -0400, YASUAKI ISHIMATSU wrote:
> > >> Hi Joey,
> > >>
> > >> On 07/23/2017 05:18 AM, joeyli wrote:
> > > [...snip]
> > >>>>>
> > >>>>
> > >>>> At least Yasuaki raised similar behavior for container in 2013.
> > >>>> It's similar to the DVD player case, user space application needs
> > >>>> to do something then trigger children offline and ejection of
> > >>>> container.
> > >>>>
> > >>>> Base on Yasuaki's explanation, the reason of that he requested the
> > >>>> userland ejection approach is that he got memory hot-remove problem
> > >>>> in 2013. Maybe his problem is already fixed by your patches in current
> > >>>> mainline.
> > >>>>
> > >>>> Hi Yasuaki, could you please check that your memory hot-remove problem
> > >>>> is fixed on mainline kernel?  
> > >>
> > >> I cannot remember what I mentioned in 2013. Could you tell me url of lkml archive.
> > >>
> > > 
> > 
> > > Here: https://lkml.org/lkml/2013/11/28/520
> > 
> > Thank you for specifying the URL. In the URL, I wrote the following problems:
> > 
> > >   1. easily fail
> > >      My container device has CPU device and Memory device, and maximum size of
> > >      memory is 3Tbyte. In my environment, hot removing container device fails
> > >      on offlining memory if memory is used by application.
> > >      I think if offlininig memory, we must retly to offline memory several
> > >      times.
> > 
> > I think the issue still remains. If process keeps accessing memory, offlining
> > the memory easily fails with EBUSY.
> 
> Yes and the only way how to deal with it is to retry the offline. In
> order to do that userspace has to be notified to try again.

Looks that kernel still needs to rely on userspace to trigger offline
for each child device. 

My plan is to impelement a _EJECTING_ flag on acpi_device struct.
It indicates that the acpi device under ejection process. The flag
will be changed in the following situations:

- EJECTING flag 0 -> 1
    - After acpi_scan_hot_remove() sends KOBJ_CHANGE for all children

- EJECTING flag 1 -> 0 
    - After acpi_scan_hot_remove() calls _EJ0
    - Any child device was set online again

And, according to the order, any EJECTING flag changing work must be
pushed to kacpi_hotplug_wq work queue.

Thanks a lot!
Joey Lee
