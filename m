From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: A question about acpi_early_init(), and want to invoke
 acpi_early_init() earlier
Date: Tue, 18 Jul 2017 08:53:39 +0800
Message-ID: <329d0353-9292-97d5-f578-5940529e94c9@cn.fujitsu.com>
References: <b94f8c2e-394f-108b-155b-17fb3f9c4772@cn.fujitsu.com>
 <66904bb8-36ca-beb3-f19c-4796aae743df@cn.fujitsu.com>
 <20170714170101.3edfaf46@saldaea>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:30423 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751769AbdGRAxr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2017 20:53:47 -0400
In-Reply-To: <20170714170101.3edfaf46@saldaea>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julian Wollrath <jwollrath@web.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi, Julian

At 07/14/2017 11:01 PM, Julian Wollrath wrote:
> Hi,
>
>>> I reproduced it by the following command line:
>>>     ...noapic acpi_sci=level...
>>>
>>> the original dmesg is:
>>>
>>> [    0.000000] tsc: Fast TSC calibration using PIT
>>>
>>> the broken dmesg is:
>>>
>>> [    0.001000] tsc: PIT calibration matches HPET. 1 loops
>>>
>>> Is it right? If it is wrong, please give the right process for
>>> reproducing.
> yes, this is right, see [1] for the original thread.
>

  Got it.

> The earliest I could move the call of acpi_early_init() without
> triggering the bug back than is shown in the patch at [2] but
> unforunately I do not have access to the Thinkpad X121e I had back than
> anymore, so I cannot help with regression testing.
>
> Cheers,
> Julian
>
> [1] https://lkml.org/lkml/2014/3/10/123
> [2] https://lkml.org/lkml/2014/3/11/424
>

These two links is really helpful for me.

Thanks,

	dou.


