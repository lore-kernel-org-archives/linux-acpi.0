From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Discussion on device's runtime wake capability
Date: Sat, 13 Oct 2012 19:13:02 +0200
Message-ID: <29356922.eWlVE9E7SJ@vostro.rjw.lan>
References: <5073C2D0.1080900@intel.com> <2938573.5VAPp3FQcI@vostro.rjw.lan> <CAOzJMDRRao8B-BOeofnoT2a5Bzy7G9bhhi7fFuST2g-1wc+owQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:45496 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210Ab2JMRJb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Oct 2012 13:09:31 -0400
In-Reply-To: <CAOzJMDRRao8B-BOeofnoT2a5Bzy7G9bhhi7fFuST2g-1wc+owQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lwe@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Friday 12 of October 2012 22:15:10 Aaron Lu wrote:
> On Fri, Oct 12, 2012 at 1:18 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday 11 of October 2012 08:47:43 Aaron Lu wrote:
> >> On 10/11/2012 06:59 AM, Rafael J. Wysocki wrote:
> >> > On Wednesday 10 of October 2012 08:53:32 Aaron Lu wrote:
> >> >
> >> >> And if possible, we can change the way we do to arm the device for
> >> >> run wake by not powering those _PRW power resources.
> >> >
> >> > No, we can't.
> >> >
> >> > Do you have examples of devices where it is harmful?
> >>
> >> Yes, for the ZPODD device.
> >> It has _PRW specifying it can wake the system up from S4. And I tried
> >> not to powering on the power resources referenced in _PRW, no problem
> >> for it to generate wake event in S0.
> >
> > How does it do that? Through the _PRW GPE or something else?
> 
> Yes, through the GPE defined in _PRW.
> 
> >
> >> Let me try to conclude:
> >> - The behaviour of devices which only have _PRW should not be changed;
> >> - We can change the way we check if a device is run wake capable by
> >>   checking if it has _PRW or _S0W;
> >> - For devices which have both _PRW and _S0W, we need consider if
> >>   powering on _PRW is needed for run wake.
> >
> > Well, _S0W only tells us what power state(s) it is safe to put the device into
> > without breaking its wakeup capability, but it doesn't really guarantee that,
> > for example, the _PRW GPE will always work if the device is in one of the
> > "safe" states.
> 
> Suppose _S0W returns 4, and its wake up event is sent through GPE
> defined in _PRW, and system is at S0. Do we need to turn on the power
> resources referenced in _PRW when we put the device into D3_COLD
> and its run wake capability is desired?
> 
> >
> > My interpretation of the _PRW output is that it tells us the wakeup GPE number
> > and a list of resources needed for that GPE to actually work. In which case it
> > shouldn't matter whether or not the system is in S0.
> 
> From this, it sounds like if GPE is used, _PRW should always be turned on.

Yes, that's my understanding of this.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
