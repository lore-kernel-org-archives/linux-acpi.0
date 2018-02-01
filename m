From: okaya@codeaurora.org
Subject: Re: [PATCH v1 1/4] ACPI / bus: Remove checks in acpi_get_match_data()
Date: Thu, 01 Feb 2018 07:58:07 -0500
Message-ID: <0858321da222e203fe71269df6b384b9@codeaurora.org>
References: <20180131212959.68766-1-andriy.shevchenko@linux.intel.com>
 <b52b3995-ec9c-660d-6c2f-afebf3864b90@codeaurora.org>
 <CAJZ5v0i_wZCmPcMSqGWNpxAStkw0UVhrDNUdaEiDY90=uEjGcw@mail.gmail.com>
 <1517487893.7000.1372.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43282 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbeBAM6I (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Feb 2018 07:58:08 -0500
In-Reply-To: <1517487893.7000.1372.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, dmaengine-owner@vger.kernel.org

On 2018-02-01 07:24, Andy Shevchenko wrote:
> On Thu, 2018-02-01 at 08:27 +0100, Rafael J. Wysocki wrote:
>> On Wed, Jan 31, 2018 at 11:17 PM, Sinan Kaya <okaya@codeaurora.org>
>> wrote:
>> > On 1/31/2018 4:29 PM, Andy Shevchenko wrote:
>> > > As well as its sibling of_device_get_match_data() has no such
>> > > checks,
>> > > no need to do it in acpi_get_match_data().
>> > >
>> > > First of all, we are not supposed to call fwnode API like this
>> > > without
>> > > driver attached.
>> > >
>> > > Second, if pure OF driver calls this function, it's weird to have
>> > > ACPI
>> > > companion without ACPI ID in this case.
>> >
>> > We talked about this during review.
>> >
>> > of_match_device() does all the checking for the OF part. ACPI
>> > doesn't have
>> > any checks.
>> 
>> Yeah, this patch is just plain incorrect AFAICS.
> 
> I don't see how check dev->driver is implemented on OF side then
> 
> 
> of_device_get_match_data() which is called by
> of_fwnode_device_get_match_data() has dereferenced dev->driver w/o any
> check.
> 
> I can't agree that the patch is plain incorrect, if I didn't miss
> anything.


Sorry, i should have been more specific. I was talkimg about match_data 
not driver.

I agree that driver check is redundant.
