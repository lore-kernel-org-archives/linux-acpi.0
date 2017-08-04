From: Michal Hocko <mhocko@kernel.org>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Fri, 4 Aug 2017 17:06:19 +0200
Message-ID: <20170804150619.GQ26029@dhcp22.suse.cz>
References: <20170711082532.GA6927@dhcp22.suse.cz>
 <20170713065806.GB2901@linux-l9pv.suse>
 <20170713070618.GC14492@dhcp22.suse.cz>
 <20170713124521.GE2901@linux-l9pv.suse>
 <20170714083713.GB2618@dhcp22.suse.cz>
 <20170714144414.GM2901@linux-l9pv.suse>
 <20170723060248.GA3034@linux-l9pv.suse>
 <b6802e30-cb1e-5fa8-6afc-09b4e05d78c9@gmail.com>
 <20170802054939.GL2946@linux-l9pv.suse>
 <8c04a96f-3f7a-1c31-9522-3344a4751d33@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55307 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752038AbdHDPGV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Aug 2017 11:06:21 -0400
Content-Disposition: inline
In-Reply-To: <8c04a96f-3f7a-1c31-9522-3344a4751d33@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Cc: joeyli <jlee@suse.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Thu 03-08-17 11:37:37, YASUAKI ISHIMATSU wrote:
> 
> 
> On 08/02/2017 01:49 AM, joeyli wrote:
> > Hi YASUAKI,
> > 
> > On Tue, Aug 01, 2017 at 03:21:38PM -0400, YASUAKI ISHIMATSU wrote:
> >> Hi Joey,
> >>
> >> On 07/23/2017 05:18 AM, joeyli wrote:
> > [...snip]
> >>>>>
> >>>>
> >>>> At least Yasuaki raised similar behavior for container in 2013.
> >>>> It's similar to the DVD player case, user space application needs
> >>>> to do something then trigger children offline and ejection of
> >>>> container.
> >>>>
> >>>> Base on Yasuaki's explanation, the reason of that he requested the
> >>>> userland ejection approach is that he got memory hot-remove problem
> >>>> in 2013. Maybe his problem is already fixed by your patches in current
> >>>> mainline.
> >>>>
> >>>> Hi Yasuaki, could you please check that your memory hot-remove problem
> >>>> is fixed on mainline kernel?  
> >>
> >> I cannot remember what I mentioned in 2013. Could you tell me url of lkml archive.
> >>
> > 
> 
> > Here: https://lkml.org/lkml/2013/11/28/520
> 
> Thank you for specifying the URL. In the URL, I wrote the following problems:
> 
> >   1. easily fail
> >      My container device has CPU device and Memory device, and maximum size of
> >      memory is 3Tbyte. In my environment, hot removing container device fails
> >      on offlining memory if memory is used by application.
> >      I think if offlininig memory, we must retly to offline memory several
> >      times.
> 
> I think the issue still remains. If process keeps accessing memory, offlining
> the memory easily fails with EBUSY.

Yes and the only way how to deal with it is to retry the offline. In
order to do that userspace has to be notified to try again.
-- 
Michal Hocko
SUSE Labs
