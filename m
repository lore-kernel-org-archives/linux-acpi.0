From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Tue, 02 Oct 2012 16:02:57 +0200
Message-ID: <7641903.D6ceG2hO4l@vostro.rjw.lan>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org> <3723306.GAm1cPlZaP@vostro.rjw.lan> <506ADDA5.3010905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:55271 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752359Ab2JBN7n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Oct 2012 09:59:43 -0400
In-Reply-To: <506ADDA5.3010905@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, pdeschrijver@nvidia.com, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On Tuesday 02 of October 2012 14:27:17 Daniel Lezcano wrote:
> On 10/02/2012 04:08 AM, Rafael J. Wysocki wrote:
> > On Sunday 30 of September 2012 18:34:31 Daniel Lezcano wrote:
> >> On 09/30/2012 12:07 AM, Rafael J. Wysocki wrote:
> >>> On Saturday, September 29, 2012, Daniel Lezcano wrote:
> >>>> On 09/29/2012 11:41 AM, Francesco Lavra wrote:
> >>>>> Hi,
> >>>> Hi Francesco,
> >>>>
> >>>> thanks for reviewing the patch.
> >>>>
> >>>>>>  static ssize_t show_current_driver(struct device *dev,
> >>>>>>  				   struct device_attribute *attr,
> >>>>>>  				   char *buf)
> >>>>>>  {
> >>>>>> -	ssize_t ret;
> >>>>>> -	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
> >>>>>> +	struct cbarg cbarg = { .buf = buf };
> >>>>> cbarg.count should be initialized to 0.
> >>>> Actually, with this initialization, all the fields will be initialized
> >>>> to 0, except 'buf'.
> >>> However, it would be good to initialize count explicitly so as to show
> >>> that we care about the initial value of it.
> >>
> >> Ok, I will change that in a V2.
> >>
> >> Rafael, you're right, this approach makes more sense IMO.
> > 
> > Well, I'm glad that you agree. :-)
> > 
> > I'm sorry I haven't posted any comments about the latest series,
> > I'll do my best to review it later this week.
> 
> Ok, cool. Thanks!
> 
> I guess it is too late to have this material for v3.7, right ?

Yes, it is too late.

Thanks,
Rafael


---
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
