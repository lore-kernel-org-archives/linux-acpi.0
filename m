From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Tue, 02 Oct 2012 04:08:23 +0200
Message-ID: <3723306.GAm1cPlZaP@vostro.rjw.lan>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org> <201209300007.49771.rjw@sisk.pl> <50687497.9040205@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:54483 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab2JBCFB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Oct 2012 22:05:01 -0400
In-Reply-To: <50687497.9040205@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, pdeschrijver@nvidia.com, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On Sunday 30 of September 2012 18:34:31 Daniel Lezcano wrote:
> On 09/30/2012 12:07 AM, Rafael J. Wysocki wrote:
> > On Saturday, September 29, 2012, Daniel Lezcano wrote:
> >> On 09/29/2012 11:41 AM, Francesco Lavra wrote:
> >>> Hi,
> >> Hi Francesco,
> >>
> >> thanks for reviewing the patch.
> >>
> >>>>  static ssize_t show_current_driver(struct device *dev,
> >>>>  				   struct device_attribute *attr,
> >>>>  				   char *buf)
> >>>>  {
> >>>> -	ssize_t ret;
> >>>> -	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
> >>>> +	struct cbarg cbarg = { .buf = buf };
> >>> cbarg.count should be initialized to 0.
> >> Actually, with this initialization, all the fields will be initialized
> >> to 0, except 'buf'.
> > However, it would be good to initialize count explicitly so as to show
> > that we care about the initial value of it.
> 
> Ok, I will change that in a V2.
> 
> Rafael, you're right, this approach makes more sense IMO.

Well, I'm glad that you agree. :-)

I'm sorry I haven't posted any comments about the latest series,
I'll do my best to review it later this week.

Thanks,
Rafael

