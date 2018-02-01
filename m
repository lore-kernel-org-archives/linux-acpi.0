From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/4] ACPI / bus: Remove checks in acpi_get_match_data()
Date: Thu, 1 Feb 2018 08:27:07 +0100
Message-ID: <CAJZ5v0i_wZCmPcMSqGWNpxAStkw0UVhrDNUdaEiDY90=uEjGcw@mail.gmail.com>
References: <20180131212959.68766-1-andriy.shevchenko@linux.intel.com> <b52b3995-ec9c-660d-6c2f-afebf3864b90@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:36082 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbeBAH1I (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Feb 2018 02:27:08 -0500
In-Reply-To: <b52b3995-ec9c-660d-6c2f-afebf3864b90@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Wed, Jan 31, 2018 at 11:17 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 1/31/2018 4:29 PM, Andy Shevchenko wrote:
>> As well as its sibling of_device_get_match_data() has no such checks,
>> no need to do it in acpi_get_match_data().
>>
>> First of all, we are not supposed to call fwnode API like this without
>> driver attached.
>>
>> Second, if pure OF driver calls this function, it's weird to have ACPI
>> companion without ACPI ID in this case.
>
> We talked about this during review.
>
> of_match_device() does all the checking for the OF part. ACPI doesn't have
> any checks.

Yeah, this patch is just plain incorrect AFAICS.
