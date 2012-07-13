From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/5] acpi : remove power from acpi_processor_cx structure
Date: Fri, 13 Jul 2012 20:14:10 +0200
Message-ID: <201207132014.10279.rjw@sisk.pl>
References: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org> <20120713001701.GB13574@phenom.dumpdata.com> <50001325.8010500@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:40079 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932504Ab2GMSIe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jul 2012 14:08:34 -0400
In-Reply-To: <50001325.8010500@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Friday, July 13, 2012, Daniel Lezcano wrote:
> On 07/13/2012 02:17 AM, Konrad Rzeszutek Wilk wrote:
> > On Thu, Jul 12, 2012 at 11:03:45PM +0200, Daniel Lezcano wrote:
> >> Remove the power field as it is not used.
> >>
> > It looks to be used in drivers/xen/xen-acpi-processor.c.
> > 
> > I could emulate some value and stick it in there.. but I am
> > more curious - what is the intent of this value?
> 
> At the first glance, this value is the power consumption of the
> specified state. I am not sure all acpi returns a correct value.
> 
> I can imagine the power should be copied to the cpuidle_state structure
> to the power field where it is used by the governor to choose the better
> C-state. As it is not specified, cpuidle will assume the C-State N
> consumes less than the C-State N-1.
> 
> If we want to add the power consumption we should also set the
> 'power_specified' flag for the driver, but that could change the
> behavior of the cpuidle driver.
> 
> Anyway, IMO, this field is useless for this structure and should be
> specified later, if that makes sense, directly in the cpuidle_state
> structure like the other drivers do.
> 
> If nobody complains, I will remove the field also from Xen and resend
> this patch.

Please do.

Thanks,
Rafael
