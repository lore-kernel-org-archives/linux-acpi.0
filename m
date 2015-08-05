From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi, property: Export acpi_dev_prop_read_single call.
Date: Thu, 06 Aug 2015 01:55:30 +0200
Message-ID: <9593183.WnSqkeFNYV@vostro.rjw.lan>
References: <1438729319-9146-1-git-send-email-ddaney.cavm@gmail.com> <1501387.bDOHyjjWvt@vostro.rjw.lan> <55C29981.8060308@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53315 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751464AbbHEX2Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Aug 2015 19:28:24 -0400
In-Reply-To: <55C29981.8060308@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: David Daney <ddaney.cavm@gmail.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Robert Richter <rrichter@cavium.com>, David Daney <david.daney@cavium.com>

On Wednesday, August 05, 2015 04:17:21 PM David Daney wrote:
> On 08/05/2015 04:23 PM, Rafael J. Wysocki wrote:
> > On Wednesday, August 05, 2015 01:14:49 PM David Daney wrote:
> >> On 08/05/2015 10:26 AM, David Daney wrote:
> >>> On 08/05/2015 06:43 AM, Tomasz Nowicki wrote:
> >>>> On 05.08.2015 15:48, Rafael J. Wysocki wrote:
> >>>>> On Tuesday, August 04, 2015 04:01:59 PM David Daney wrote:
> >>>>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >>>>>>
> >>>>>> Fixes the following build error when building drivers as modules:
> >>>>>>
> >>>>>>    ERROR: "acpi_dev_prop_read_single" [drivers/net/phy/mdio-octeon.ko]
> >>>>>> undefined!
> >>>>>>    ERROR: "acpi_dev_prop_read_single"
> >>>>>> [drivers/net/ethernet/cavium/thunder/thunder_bgx.ko] undefined!
> >>>>>
> >>>>> Can you please tell me why the drivers in question use that function
> >>>>> directly, although they aren't supposed to?
> >>>>>
> >>>>> Clearly, their authors had not tried to build them as modules or they
> >>>>> would have noticed the problem at the development stage already.
> >>>>>
> >>>>> What would be wrong with using the generic device properties API
> >>>>> instead?
> >>>>>
> >>>> Yes, you are right. We should use:
> >>>> int device_property_read_u64_array(struct device *dev, const char
> >>>> *propname, u64 *val, size_t nval);
> >>>>
> >>>
> >>> Thanks all, for the review and suggestions.  We we try the suggested
> >>> approach and see how it goes...
> >>>
> >>
> >> Actually I don't think device_property_read_u64_array() will work.
> >>
> >> We are traversing a reference to a different acpi_device via
> >> acpi_dev_get_property_reference(),
> >
> > Why?
> 
> Network device has a "phy-handle" (traversed with 
> acpi_dev_get_property_reference()), and we want to get some properties 
> of that phy.
> 
> I could turn the question around to you:  Why export 
> acpi_dev_get_property_reference()?  If there is a reason to export that, 
> then you should let people use the result.

The GPIO core uses it and you *can* use the result (please see my other
message).

I wonder how does the ACPI table in question look like.  Do you have
an acpidump output from that system by any chance?

Thanks,
Rafael

