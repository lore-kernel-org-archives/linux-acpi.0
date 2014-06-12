From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [RFC v2 1/3] Mailbox: Add support for ACPI
Date: Thu, 12 Jun 2014 13:14:17 -0400
Message-ID: <CAJ5Y-eZ0z-SPSn9oxced2GOAw+OA5rC+uq4pCSXh5H2JujPm1g@mail.gmail.com>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
	<1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
	<4476889.LvjMyVbGZ8@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:45881 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbaFLROS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2014 13:14:18 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so1656291wes.27
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2014 10:14:17 -0700 (PDT)
In-Reply-To: <4476889.LvjMyVbGZ8@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-acpi@vger.kernel.org, Patch Tracking <patches@linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>, rjw@rjwysocki.net, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Mark Brown <broonie@kernel.org>

On 12 June 2014 13:02, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 12 June 2014 12:48:10 Ashwin Chaugule wrote:
>>
>> +#ifndef CONFIG_ACPI
>>         if (!mbox->of_xlate)
>>                 mbox->of_xlate = of_mbox_index_xlate;
>> -
>> +#endif
>>         mutex_lock(&con_mutex);
>>         list_add_tail(&mbox->node, &mbox_cons);
>>         mutex_unlock(&con_mutex);
>>
>
> You can't do #ifndef here, the driver must still work if
> both OF and ACPI are enabled.

Ok. Here we could skip the macro altogether, since of_xlate wont be
called with ACPI anyway.

Will need to look into using/faking mbox->dev to remove the other ifndefs.

Cheers,
Ashwin
