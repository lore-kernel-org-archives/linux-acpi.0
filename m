From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/2] ACPI: video: get rid of magic numbers and use enum instead
Date: Thu, 20 Apr 2017 12:40:26 +0200
Message-ID: <CAJZ5v0hrebf=WsETzRjmfP71XaY=V4HS66N=8RVWPJ9Ueu=Huw@mail.gmail.com>
References: <20170418123558.12436-1-mail@dmitryfrank.com> <20170419103618.20939-1-mail@dmitryfrank.com>
 <20170419103618.20939-2-mail@dmitryfrank.com> <CAJZ5v0gZ95Np7gPidaAO2D7oEmDyE_O8RVuLOnoTsKC5o=QwFQ@mail.gmail.com>
 <20170419194453.GA23107@dimon-t520> <CAJZ5v0ibJxzZyfTUL2CcqCuV76qSyDNDKJJJg_umUr8tAjdMHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33335 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942994AbdDTKk1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2017 06:40:27 -0400
Received: by mail-oi0-f66.google.com with SMTP id a189so8139694oib.0
        for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2017 03:40:27 -0700 (PDT)
In-Reply-To: <CAJZ5v0ibJxzZyfTUL2CcqCuV76qSyDNDKJJJg_umUr8tAjdMHQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Frank <mail@dmitryfrank.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Apr 19, 2017 at 10:15 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Apr 19, 2017 at 9:44 PM, Dmitry Frank <mail@dmitryfrank.com> wrote:
>> Hi Rafael,
>>
>> On 04/19, Rafael J. Wysocki wrote:
>>> On Wed, Apr 19, 2017 at 12:36 PM, Dmitry Frank <mail@dmitryfrank.com> wrote:
>>> > The first two items in the _BCL method response are special:
>>> >
>>> >   - Level when machine has full power
>>> >   - Level when machine is on batteries
>>> >   - .... actual supported levels go there ....
>>> >
>>> > So this commits adds an enum and uses its descriptive elements
>>> > throughout the code, instead of magic numbers.
>>> >
>>> > Signed-off-by: Dmitry Frank <mail@dmitryfrank.com>
>>>
>>> Are there any differences between this and the previous version of the
>>> patch you posted?
>>>
>>
>> No; this patch is identical in both v2 and v3 patchsets.
>>
>> Differences between v3 and v2 are as follows: In v3 I removed the middle
>> patch (which was renaming the global flag device_id_scheme), and also
>> amended the last patch: added the comment for that flag. Everything else
>> is identical.
>
> OK, thanks!

The v2 has been applied.

Thanks,
Rafael
