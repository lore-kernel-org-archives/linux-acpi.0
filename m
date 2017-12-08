From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH V6 4/7] OF: properties: Implement get_match_data()
 callback
Date: Fri, 8 Dec 2017 09:09:26 +0100
Message-ID: <20171208090926.2fb362ef@karo-electronics.de>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
        <1512493493-6464-5-git-send-email-okaya@codeaurora.org>
        <20171207141029.575c0a03@karo-electronics.de>
        <def8e351-bc2d-7adc-fdc5-362b365302a8@codeaurora.org>
        <20171207162036.6a71a4f5@karo-electronics.de>
        <661cbe4d-ea33-3e84-b5f2-ab6517cbb135@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay08.ispgateway.de ([134.119.228.108]:23695 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdLHIJb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Dec 2017 03:09:31 -0500
In-Reply-To: <661cbe4d-ea33-3e84-b5f2-ab6517cbb135@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, timur@codeaurora.org, open list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org

Hi,

On Thu, 7 Dec 2017 12:50:50 -0500 Sinan Kaya wrote:
> On 12/7/2017 10:20 AM, Lothar Waßmann wrote:
> > Hi,
> > 
> > On Thu, 7 Dec 2017 09:45:31 -0500 Sinan Kaya wrote:
> >> On 12/7/2017 8:10 AM, Lothar Waßmann wrote:
> >>>> +void *of_fwnode_get_match_data(const struct fwnode_handle *fwnode,
> >>>> +			       struct device *dev)
> >>> Shouldn't this be 'const void *of_fwnode_get_match_data
> >>
> >> OF keeps the driver data as a (const void*) internally. ACPI keeps the
> >> driver data as kernel_ulong_t in struct acpi_device_id.
> >>
> >> I tried to find the middle ground here by converting output to void*
> >> but not keeping const.
> >>
> > It should be no problem to cast a (const void *) to an unsigned long
> > data type (without const qualifier).
> > 
> 
> It is the other way around. If I change this API to return a a (const void*),
> the device_get_match_data() function need to return a (const void *).
> 
> While implementing the ACPI piece, I have to convert an unsigned long to
> (const void *) in ACPI code so that the APIs are compatible.
> 
That's true, but I don't see any problem with that. Your
device_get_match_data() is merely a wrapper around of_device_get_match_data()
which returns a const pointer. I see no reason to change this to a
non-const pointer by the wrapper function.


Lothar Waßmann
