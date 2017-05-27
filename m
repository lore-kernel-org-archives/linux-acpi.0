From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose
 embedded WMI MOF metadata
Date: Sat, 27 May 2017 14:07:40 -0700
Message-ID: <CALCETrWgFqhYCVmr+rox5GuwAO8HzenjRt7MeKJbAmV3gJCmng@mail.gmail.com>
References: <cover.1495862272.git.dvhart@infradead.org> <27758381c6cb77efab75a266e21243a964cce0ba.1495862272.git.dvhart@infradead.org>
 <201705271314.16241@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750784AbdE0VIC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 May 2017 17:08:02 -0400
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com [209.85.217.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C26D3239F3
        for <linux-acpi@vger.kernel.org>; Sat, 27 May 2017 21:08:01 +0000 (UTC)
Received: by mail-ua0-f178.google.com with SMTP id u10so20624519uaf.1
        for <linux-acpi@vger.kernel.org>; Sat, 27 May 2017 14:08:01 -0700 (PDT)
In-Reply-To: <201705271314.16241@pali>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Sat, May 27, 2017 at 4:14 AM, Pali Rohár <pali.rohar@gmail.com> wrote:
> Hi! Note that in WMI is stored binary MOF (BMOF; .bmf file; compiled
> MOF), not ordinary MOF data which are plain text. So maybe it could make
> sense to include "B" into name of sysfs entry? Or not? (Just suggestion)
>
> On Saturday 27 May 2017 07:31:29 Darren Hart wrote:
>> From: Andy Lutomirski <luto@kernel.org>
>>
>> Quite a few laptops (and maybe servers?) have embedded WMI MOF
>
> Not "a few", but "lots of" :-)
>
>> metadata. I think that Samba has tools to interpret it, but there is
>> currently no interface to get the data in the first place.
>
> No, there is no non-ms-windows tool for interpreting those binary MOF
> (BMF) data yet.
>
>> +     priv->mofdata = wmidev_block_query(wdev, 0);
>> +     if (!priv->mofdata) {
>> +             dev_warn(&wdev->dev, "failed to read MOF\n");
>> +             return -EIO;
>> +     }
>> +
>> +     if (priv->mofdata->type != ACPI_TYPE_BUFFER) {
>> +             dev_warn(&wdev->dev, "MOF is not a buffer\n");
>> +             ret = -EIO;
>> +             goto err_free;
>> +     }
>
> Are not those problems fatal for driver and therefore dev_err() better?
>
>> +     sysfs_bin_attr_init(&priv->mof_bin_attr);
>> +     priv->mof_bin_attr.attr.name = "mof";
>> +     priv->mof_bin_attr.attr.mode = 0400;
>
> 0400 means to be readable only by root? Is there then reason why normal
> user should not be able to read it?
>

I have no specific objection to making it 0444, but in general I'd
rather expose less information to unprivileged users rather than more.
I'm also having trouble imagining what an unprivileged user would do
with the MOF -- it's useful for reverse engineering and it may
eventually be useful for making WMI calls from userspace, but neither
of those is particularly useful to unprivileged users.
