From: joeyli <jlee@suse.com>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Wed, 2 Aug 2017 13:49:39 +0800
Message-ID: <20170802054939.GL2946@linux-l9pv.suse>
References: <20170626062657.GE4229@linux-l9pv.suse>
 <20170626085907.GE11534@dhcp22.suse.cz>
 <20170711082532.GA6927@dhcp22.suse.cz>
 <20170713065806.GB2901@linux-l9pv.suse>
 <20170713070618.GC14492@dhcp22.suse.cz>
 <20170713124521.GE2901@linux-l9pv.suse>
 <20170714083713.GB2618@dhcp22.suse.cz>
 <20170714144414.GM2901@linux-l9pv.suse>
 <20170723060248.GA3034@linux-l9pv.suse>
 <b6802e30-cb1e-5fa8-6afc-09b4e05d78c9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6802e30-cb1e-5fa8-6afc-09b4e05d78c9@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi YASUAKI,

On Tue, Aug 01, 2017 at 03:21:38PM -0400, YASUAKI ISHIMATSU wrote:
> Hi Joey,
> 
> On 07/23/2017 05:18 AM, joeyli wrote:
[...snip]
> >>>
> >>
> >> At least Yasuaki raised similar behavior for container in 2013.
> >> It's similar to the DVD player case, user space application needs
> >> to do something then trigger children offline and ejection of
> >> container.
> >>
> >> Base on Yasuaki's explanation, the reason of that he requested the
> >> userland ejection approach is that he got memory hot-remove problem
> >> in 2013. Maybe his problem is already fixed by your patches in current
> >> mainline.
> >>
> >> Hi Yasuaki, could you please check that your memory hot-remove problem
> >> is fixed on mainline kernel?  
> 
> I cannot remember what I mentioned in 2013. Could you tell me url of lkml archive.
>

Here: https://lkml.org/lkml/2013/11/28/520

In the mail, you mentioned two problems. But there have no detail about
those issues, and no root causes. We don't know why kernel should relies
on user space to complete the hot removing process for container.

Thank a lot!
Joey Lee
