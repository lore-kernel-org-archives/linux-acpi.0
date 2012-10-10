From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: Discussion on device's runtime wake capability
Date: Wed, 10 Oct 2012 08:53:32 +0800
Message-ID: <5074C70C.9090704@intel.com>
References: <5073C2D0.1080900@intel.com> <9718124.Sj45DoTPo2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:52490 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637Ab2JJAxi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2012 20:53:38 -0400
In-Reply-To: <9718124.Sj45DoTPo2@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On 10/10/2012 04:48 AM, Rafael J. Wysocki wrote:
> On Tuesday 09 of October 2012 14:23:12 Aaron Lu wrote:
>> Hi all,
>>
>> We are using _PRW as a hint to see if a device supports wakeup, this is
>> fine for device which is able to wake the system in a sleep state, but
>> not to wake itself when system is at S0.
> 
> Why not?

Section 7.2.13 of ACPI spec has words like this:
_PRW is only required for devices that have the ability to wake the
system from a system sleeping state.

This is why I don't think _PRW is necessary for run wake as we are still
at S0.

> 
>> Moreover, when we are to arm the device runtime wake, I think there is
>> no need to power on the power resources referenced in _PRW,
> 
> Why do you think so?  How can you be sure that those resources are not needed
> to provide wakeup power to the device (or whatever generates the wakeup signal
> on its behalf))?

The same reason as above, the power resources are needed to arm the
device to wake the system from a sleeping state, not S0.

But it's really good to know if there are systems that has a requirement
for _PRW to be on for the device to wake itself up when system is at S0.

> 
>> those power resources should be used to give the device ability to wake
>> the system from a sleep state, not to wake itself when system is at S0,
>> so powering thoses power resources on for run wake is a waste.
> 
> Where did you get this idea from?

Section 7.2.13 of ACPI spec.

> 
>> But I may miss something, so it would be very kind of you to point it
>> out if things are not like what I've thought, thanks.
> 
> Yes, you do.  For example, _PRW gives us the number of the GPE to use for
> signalling wakeup, right?

Yes, but I think this is a separate story.
The GPE will still be needed, but the power resources may not.

> 
>> BTW, _S0W seems to be a good hint whether the device supports run wake
>> from ACPI's perspective.
> 
> Yes, it is a _hint_.

And I think it is a better hint than _PRW.
I've seen a ACPI table that uses something like this to express the run
wake of the device:
- It has _S0W;
- It has _DSW;
- No _PRW;
- It has a _CRS method to describe an interrupt resource.

And I've tested with a device which is able to both run wake and system
wake. If I do not power those _PRW power resources, there is no problem
for it to generate wake signal when system is at S0, and it even takes
care of the GPE thing in ASL code. But this may be special cases, so I
want to have a discussion on this.

So I hope we can refresh the way we check if the device is able to run
wake. And if possible, we can change the way we do to arm the device for
run wake by not powering those _PRW power resources.

Thanks,
Aaron

