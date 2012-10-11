From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Discussion on device's runtime wake capability
Date: Thu, 11 Oct 2012 19:18:29 +0200
Message-ID: <2938573.5VAPp3FQcI@vostro.rjw.lan>
References: <5073C2D0.1080900@intel.com> <2385066.UqpHriJSiI@vostro.rjw.lan> <5076172F.5080708@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:43251 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759003Ab2JKROv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Oct 2012 13:14:51 -0400
In-Reply-To: <5076172F.5080708@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Thursday 11 of October 2012 08:47:43 Aaron Lu wrote:
> On 10/11/2012 06:59 AM, Rafael J. Wysocki wrote:
> > On Wednesday 10 of October 2012 08:53:32 Aaron Lu wrote:
> >> On 10/10/2012 04:48 AM, Rafael J. Wysocki wrote:
> >>> On Tuesday 09 of October 2012 14:23:12 Aaron Lu wrote:
> >>>> Hi all,
> >>>>
> >>>> We are using _PRW as a hint to see if a device supports wakeup, this is
> >>>> fine for device which is able to wake the system in a sleep state, but
> >>>> not to wake itself when system is at S0.
> >>>
> >>> Why not?
> >>
> >> Section 7.2.13 of ACPI spec has words like this:
> >> _PRW is only required for devices that have the ability to wake the
> >> system from a system sleeping state.
> >>
> >> This is why I don't think _PRW is necessary for run wake as we are still
> >> at S0.
> > 
> > It may not be necessary, but if it is present, it gives us certain information
> > about the device's wakeup capabilities.
> 
> Agree.
> 
> > 
> >>>> Moreover, when we are to arm the device runtime wake, I think there is
> >>>> no need to power on the power resources referenced in _PRW,
> >>>
> >>> Why do you think so?  How can you be sure that those resources are not needed
> >>> to provide wakeup power to the device (or whatever generates the wakeup signal
> >>> on its behalf))?
> >>
> >> The same reason as above, the power resources are needed to arm the
> >> device to wake the system from a sleeping state, not S0.
> > 
> > The spec doesn't say pretty much anything about S0 in that context and we
> > found out some things by experimentation.
> 
> OK.
> 
> > 
> >> But it's really good to know if there are systems that has a requirement
> >> for _PRW to be on for the device to wake itself up when system is at S0.
> > 
> > Yes, there are.  Please see the Matthew's response.
> 
> I was thinking in his example, the device may not have a _S0W object.
> I was waiting for his reply.
> 
> I agree that for devices only have _PRW but not _S0W, if we want run
> wake, we will need to power on _PRW.
> 
> > 
> >>>> those power resources should be used to give the device ability to wake
> >>>> the system from a sleep state, not to wake itself when system is at S0,
> >>>> so powering thoses power resources on for run wake is a waste.
> >>>
> >>> Where did you get this idea from?
> >>
> >> Section 7.2.13 of ACPI spec.
> > 
> > I thought so. :-)
> > 
> > That part of the spec doesn't cover runtime wakeup at all, so I'm not sure it's
> > a good reference.
> 
> OK.
> 
> > 
> >>>> But I may miss something, so it would be very kind of you to point it
> >>>> out if things are not like what I've thought, thanks.
> >>>
> >>> Yes, you do.  For example, _PRW gives us the number of the GPE to use for
> >>> signalling wakeup, right?
> >>
> >> Yes, but I think this is a separate story.
> >> The GPE will still be needed, but the power resources may not.
> > 
> > They may or may not be needed, that's the problem.  We basically cannot tell
> > that just by reading the ACPI tables in many cases.
> 
> It doesn't hurt if we enable the GPE, since either we as OSPM will
> enable it, or the ASL code will do that.
> 
> This is not like the power resources, which will waste some energy.
>
> >>>> BTW, _S0W seems to be a good hint whether the device supports run wake
> >>>> from ACPI's perspective.
> >>>
> >>> Yes, it is a _hint_.
> >>
> >> And I think it is a better hint than _PRW.
> >> I've seen a ACPI table that uses something like this to express the run
> >> wake of the device:
> >> - It has _S0W;
> >> - It has _DSW;
> >> - No _PRW;
> >> - It has a _CRS method to describe an interrupt resource.
> > 
> > That's fine I suppose, because this seems to be a device whose interrupt
> > wakes it up.  We didn't consider such devices before.
> > 
> > However, that doesn't mean that if _PRW _is_ defined and it lists some
> > power resources, then those resources are only necessary for waking up
> > the whole system from sleep states.  They may be necessary for remote
> > wakeup to work in S0 too.
> > 
> >> And I've tested with a device which is able to both run wake and system
> >> wake. If I do not power those _PRW power resources, there is no problem
> >> for it to generate wake signal when system is at S0, and it even takes
> >> care of the GPE thing in ASL code. But this may be special cases, so I
> >> want to have a discussion on this.
> >>
> >> So I hope we can refresh the way we check if the device is able to run
> >> wake.
> > 
> > Yes, we can.
> 
> Good :-)
> 
> > 
> >> And if possible, we can change the way we do to arm the device for
> >> run wake by not powering those _PRW power resources.
> > 
> > No, we can't.
> > 
> > Do you have examples of devices where it is harmful?
> 
> Yes, for the ZPODD device.
> It has _PRW specifying it can wake the system up from S4. And I tried
> not to powering on the power resources referenced in _PRW, no problem
> for it to generate wake event in S0.

How does it do that? Through the _PRW GPE or something else?

> Let me try to conclude:
> - The behaviour of devices which only have _PRW should not be changed;
> - We can change the way we check if a device is run wake capable by
>   checking if it has _PRW or _S0W;
> - For devices which have both _PRW and _S0W, we need consider if
>   powering on _PRW is needed for run wake.

Well, _S0W only tells us what power state(s) it is safe to put the device into
without breaking its wakeup capability, but it doesn't really guarantee that,
for example, the _PRW GPE will always work if the device is in one of the
"safe" states.

My interpretation of the _PRW output is that it tells us the wakeup GPE number
and a list of resources needed for that GPE to actually work. In which case it
shouldn't matter whether or not the system is in S0.

> Does this look correct to you?

Almost. :-)

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
