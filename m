From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / GED: unregister interrupts during shutdown
Date: Wed, 6 Dec 2017 18:16:04 +0100
Message-ID: <CAJZ5v0iaursWFP_KRoJqT6-QoGkvpTot0oMvs6qdjkaP12p9jQ@mail.gmail.com>
References: <1512507705-2411-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0jcFqG=Jd19ms7XQMR+rGfdKTEaN7SK91DPzBa=xcMY1w@mail.gmail.com>
 <0b661eec-f9c7-7818-ad09-f3d488adcefe@codeaurora.org> <CAJZ5v0hkajauiqEmEVv+k-OYeP+_S4wufjuR7vmhcxARpRpw=g@mail.gmail.com>
 <fe65ff1a-a8b8-c29b-161d-72cbfea5c056@codeaurora.org> <aa5bcbab-b059-1abf-1553-371fe5750455@codeaurora.org>
 <CAJZ5v0iifeFpJsSwXO1AGLW3rn1cG7t3V6ZAnu34-K=D_DavBA@mail.gmail.com> <e0f77da3-93d8-d474-3531-488f8f5f6108@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41746 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbdLFRQF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Dec 2017 12:16:05 -0500
In-Reply-To: <e0f77da3-93d8-d474-3531-488f8f5f6108@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Dec 6, 2017 at 5:55 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 12/6/2017 11:41 AM, Rafael J. Wysocki wrote:
>> On Wed, Dec 6, 2017 at 5:11 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> On 12/6/2017 9:57 AM, Sinan Kaya wrote:
>>>>> Yes, it should, so I'm not sure why you need the list in the first place.
>>>>>
>>>>> Also it looks like something along the lines of devres_release_all()
>>>>> should be sufficient.
>>>> Good suggestion, let me test this.
>>>>
>>>
>>> I tried to pull the code into GED but the API is not public. I also looked
>>> at how it is used. I was afraid to mess up with the internals of base.c by
>>> calling devres_release_all() externally first and by the driver framework
>>> next. I moved away from this approach.
>>
>> Are you sure it is called by the core in the shutdown path?
>
> Sorry, I was thinking about a general case not the shutdown path. If we open
> this API and have device drivers call it from arbitrary places; then we could
> be opening a new can of worms that show up during device driver removal.
>
> If you feel confident (I'm not), I can pursue this approach too.
>
>>
>>> I just fixed the function rename and changed the dev_info() to dev_dbg().
>>
>> And why do you need the list?
>>
>> ged_shutdown() will be called for every device for which ged_probe()
>> has been called.
>
> The problem I had here is that =the last argument is the context pointer when I
> call devm_free_irq().
>
> If I don't pass the same context I used during IRQ registration, then the IRQ
> free API fails. That's why, I needed to keep the event pointer around until the
> IRQ free is called.

OK

Anyway, it looks like something is missing in the core.

You shouldn't really need to do all that dance in a driver.
