From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 16/16] platform/x86: dell-wmi: Convert to the WMI bus infrastructure
Date: Sat, 27 May 2017 11:40:52 -0700
Message-ID: <CALCETrWtkEazuMMrFZp4oybwjNO-8r6GNF2BLA39fJqfH8Crtw@mail.gmail.com>
References: <cover.1495862272.git.dvhart@infradead.org> <4a4da770c8d0af7e3f31e79261b43573d70a6ea6.1495862272.git.dvhart@infradead.org>
 <201705271250.20338@pali> <CALCETrWic6ZWrjdmXTRX92U058B1SZ+xMd+5TBW+YL51ZrgeCA@mail.gmail.com>
 <3669DF37-7D17-40AD-852A-F8EDBE15A785@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750744AbdE0SlO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 May 2017 14:41:14 -0400
Received: from mail-ua0-f174.google.com (mail-ua0-f174.google.com [209.85.217.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98337239DA
        for <linux-acpi@vger.kernel.org>; Sat, 27 May 2017 18:41:13 +0000 (UTC)
Received: by mail-ua0-f174.google.com with SMTP id y4so19849965uay.2
        for <linux-acpi@vger.kernel.org>; Sat, 27 May 2017 11:41:13 -0700 (PDT)
In-Reply-To: <3669DF37-7D17-40AD-852A-F8EDBE15A785@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Jiri Kosina <jikos@kernel.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Sat, May 27, 2017 at 9:17 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On May 27, 2017 9:04:38 AM PDT, Andy Lutomirski <luto@kernel.org> wrote:
>>On Sat, May 27, 2017 at 3:50 AM, Pali Rohár <pali.rohar@gmail.com>
>>wrote:
>>> On Saturday 27 May 2017 07:31:30 Darren Hart wrote:
>>>> -     dell_wmi_input_dev->name = "Dell WMI hotkeys";
>>>> -     dell_wmi_input_dev->phys = "wmi/input0";
>>>> -     dell_wmi_input_dev->id.bustype = BUS_HOST;
>>>> +     priv->input_dev->name = "Dell WMI hotkeys";
>>>> +     priv->input_dev->id.bustype = BUS_HOST;
>>>
>>> Is not there BUS_WMI, or something like that? (Just asking)
>>>
>>
>>Jiri and/or Dmitry, what is bustype for, anyway?
>
> The bus type could be used to help further  identifying device if it used same vendor/product for spi and i2c, for example, but there are not many if them. I'm not sure if anyone actually makes decisions based on it, but it is part of abi now.
>
>>I suppose we could add BUS_PLATFORM.
>
> What would be the difference from BUS_HOST?
>

If BUS_HOST means that the device is part of the host as opposed to
being plugged in, then it seems entirely reasonable.
