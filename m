From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 4.9-rc1: [TMP_] ACPI namespace lookup failure, AE_ALREADY_EXISTS
Date: Thu, 20 Oct 2016 23:16:16 +0200
Message-ID: <CAJZ5v0jMtzSg8JCLQDzYRK5xtdWOJTUKktHKjhAw1o0nRG2Thw@mail.gmail.com>
References: <1476913001.7633.13.camel@intel.com> <1AE640813FDE7649BE1B193DEA596E886A256346@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35411 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbcJTVQU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Oct 2016 17:16:20 -0400
Received: by mail-lf0-f42.google.com with SMTP id l131so99261285lfl.2
        for <linux-acpi@vger.kernel.org>; Thu, 20 Oct 2016 14:16:19 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A256346@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Deak, Imre" <imre.deak@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Thu, Oct 20, 2016 at 8:44 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
>> From: Deak, Imre
>> Subject: 4.9-rc1: [TMP_] ACPI namespace lookup failure, AE_ALREADY_EXISTS
>>
>> Hi,
>>
>> after upgrading to 4.9-rc1 I get the following errors occasionally
>> during boot and suspend-to-ram on an APL system:
>>
>> [   59.513434] ACPI Error: [TMP_] Namespace lookup failure, AE_ALREADY_EXISTS (20160831/dswload2-330)
>> [   59.513446] ACPI Exception: AE_ALREADY_EXISTS, During name lookup/catalog (20160831/psobject-227)
>> [   59.513469] ACPI Error: Method parse/execution failed [\_SB.PCI0.SCPG] (Node ffff8802770b7bb8),
>> AE_ALREADY_EXISTS (20160831/psparse-543)
>> [   59.515415] ACPI Error: Method parse/execution failed [\_SB.PCI0.SDHA._PS3] (Node ffff8802770b7dc0),
>> AE_ALREADY_EXISTS (20160831/psparse-543)
>> [   59.517118] ACPI: Marking method _PS3 as Serialized because of AE_ALREADY_EXISTS error
>>
>> Other than these error messages, booting and suspend/resume seems to work ok.
>> Bisecting points to
>> commit 74f51b80a0c4ff84fbeb7f12ea43ce66934d29aa
>> Author: Lv Zheng <lv.zheng@intel.com>
>> Date:   Wed Sep 7 14:07:10 2016 +0800
>>
>>     ACPICA: Namespace: Fix dynamic table loading issues
>>
>> Reverting this on top of 4.9-rc1 gets rid of the error messages.
>
> The commit in question only modified code to make locks unlocked/locked.
> Which should be transparent to the functional stuffs.

It might change the relative timing of thigs (which might result in
ordering changes).

> I'm not sure how it can lead to such error in the single-threading boot environment.

Why do you think it's single-threaded?  At least suspend/resume isn't
in general.

Thanks,
Rafael
