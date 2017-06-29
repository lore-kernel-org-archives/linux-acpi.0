From: joeyli <jlee@suse.com>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Thu, 29 Jun 2017 11:57:36 +0800
Message-ID: <20170629035736.GT4229@linux-l9pv.suse>
References: <20170626062657.GE4229@linux-l9pv.suse>
 <1f1b0229-84c8-f95f-dab4-76588834b6e6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:48946 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdF2D5t (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Wed, 28 Jun 2017 23:57:49 -0400
Content-Disposition: inline
In-Reply-To: <1f1b0229-84c8-f95f-dab4-76588834b6e6@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>

Hi YASUAKI,

Thanks for your response.

On Wed, Jun 28, 2017 at 03:53:16PM -0400, YASUAKI ISHIMATSU wrote:
> 
> On 06/26/2017 02:26 AM, joeyli wrote:
> > Hi all,
> > 
> > If ACPI received ejection request for a ACPI container, kernel
> > emits KOBJ_CHANGE uevent when it found online children devices
> > below the acpi container.
> > 
> > Base on the description of caa73ea15 kernel patch, user space
> > is expected to offline all devices below the container and the
> > container itself. Then, user space can finalize the removal of
> > the container with the help of its ACPI device object's eject
> > attribute in sysfs.
> > 
> > That means that kernel relies on users space to peform the offline
> > and ejection jobs to acpi container and children devices. The
> > discussion is here:
> > 	https://lkml.org/lkml/2013/11/28/520
> > 
> > The mail loop didn't explain why the userspace is responsible for
> > the whole container offlining. Is it possible to do that transparently
> > from the kernel? What's the difference between offlining memory and
> > processors which happends without any cleanup and container which
> > does essentially the same except it happens at once? 
> 
> We don't know what devices mount on the container device. I think
> devices mount on the container device are different each vendor's server.
>
> If memory device mounts on the container, memory offline easily fails.
> Other devices may have other concerns. So the following udev rule you
> write does not work correctly.
>

IMHO, if the memory hot-remove(offline/ejection) has problem, then we
should report the issue and fix it in mm subsystem. Michal Hocko works
hard on this. I think that the CPU or IO subsystem are the same.

Current kernel can not complete the container hot-remove job without
userspace's involvement. So I sent the udev rule as a example to
response change uevents.

> I think we need to change offline processing for each device. So currently
> the userspace is responsible for the whole container offlining.
>

It depends on what is the expectation of the deivce offline function
in kernel. If a subsystem supports offline in kernel, then it should
not affects the running user space application. Otherwise the issue 
should be fixed.

Thanks a lot!
Joey Lee
