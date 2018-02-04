From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/6] ACPI / bus: Remove checks in acpi_get_match_data()
Date: Sun, 4 Feb 2018 08:21:43 +0100
Message-ID: <CAJZ5v0hw2h2qvHD=FyH1SU2CwcQj7xOOs7buAoc779EK1TeibQ@mail.gmail.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
 <20180201202012.36524-3-andriy.shevchenko@linux.intel.com> <1517517998.7000.1448.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35081 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeBDHVo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Feb 2018 02:21:44 -0500
In-Reply-To: <1517517998.7000.1448.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, Feb 1, 2018 at 9:46 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, 2018-02-01 at 22:20 +0200, Andy Shevchenko wrote:
>> As well as its sibling of_device_get_match_data() has no such checks,
>> no need to do it in acpi_get_match_data().
>>
>> First of all, we are not supposed to call fwnode API like this without
>> driver attached.
>>
>> Second, since __acpi_match_device() does check input parameter there
>> is
>> no need to duplicate it outside.
>>
>> Fixes: 80212a162329 ("ACPI / bus: Introduce acpi_get_match_data()
>> function")
>> Cc: Sinan Kaya <okaya@codeaurora.org>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Vinod Koul <vinod.koul@intel.com>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>> v2: rebase on top of new patches, rephrase commit message
>>  drivers/acpi/bus.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index f3a7c29e9190..413e4b1cb1be 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -791,12 +791,6 @@ void *acpi_get_match_data(const struct device
>> *dev)
>>  {
>>       const struct acpi_device_id *match;
>>
>> -     if (!dev->driver)
>> -             return NULL;
>> -
>
>> -     if (!dev->driver->acpi_match_table)
>> -             return NULL;
>> -
>
> Perhaps I have to add that this conditional prevents
> device_get_match_data() to work on PRP0001 devices AFAIU.

Yes, please.

I'm also not sure if the Fixes: tag is really applicable to this.
