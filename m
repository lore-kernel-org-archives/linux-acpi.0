Return-Path: <SRS0=2hes=ZR=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDC1C432C0
	for <linux-acpi@archiver.kernel.org>; Mon, 25 Nov 2019 01:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ADE2071A
	for <linux-acpi@archiver.kernel.org>; Mon, 25 Nov 2019 01:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKYB3V (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 24 Nov 2019 20:29:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36582 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727072AbfKYB3V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 24 Nov 2019 20:29:21 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9DEF9FEABABB2759A66B;
        Mon, 25 Nov 2019 09:29:18 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 25 Nov 2019
 09:29:11 +0800
Subject: Re: [PATCH] ACPI: sysfs: Define the variable gpe from u8 to u16 to
 avoid endless loop in function apci_gpe_apply_masked_gpes()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <1574390957-6313-1-git-send-email-chenxiang66@hisilicon.com>
 <CAJZ5v0ixTZE6sDD4tojNi7=peqCXSrkS3qyHgeo==zKr4AHKTw@mail.gmail.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <48e035bf-120e-4170-b794-3cf6562ce2ae@hisilicon.com>
Date:   Mon, 25 Nov 2019 09:29:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ixTZE6sDD4tojNi7=peqCXSrkS3qyHgeo==zKr4AHKTw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



在 2019/11/22 18:03, Rafael J. Wysocki 写道:
> On Fri, Nov 22, 2019 at 3:52 AM chenxiang <chenxiang66@hisilicon.com> wrote:
>> From: Xiang Chen <chenxiang66@hisilicon.com>
>>
>> After the patch (eb09878e1301 ("ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100")),
>> the macro ACPI_MASKABLE_GPE_MAX is changed from 0xFF to 0x100. So in function
>> apci_gpe_apply_masked_gpes(), the variable gpe may reach 0x100 but it is
>> defined as u8, so it will be 0 when reaching 0x100. If the bitmap
>> acpi_masked_gpes_map are all 0s, it will loop all the times.
>>
>> To solve endless loop in the function, define the variable gpe from u8 to u16.
>>
>> Fixes: eb09878e1301 ("ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100")
> This commit has been dropped.
>
> I have a new version of it queued up with the u16 change below folded it.

Ok, thanks!

>
> Thanks!
>
>> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
>> ---
>>   drivers/acpi/sysfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
>> index 0a83ce1..c60d2c6 100644
>> --- a/drivers/acpi/sysfs.c
>> +++ b/drivers/acpi/sysfs.c
>> @@ -838,7 +838,7 @@ void __init acpi_gpe_apply_masked_gpes(void)
>>   {
>>          acpi_handle handle;
>>          acpi_status status;
>> -       u8 gpe;
>> +       u16 gpe;
>>
>>          for_each_set_bit(gpe, acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) {
>>                  status = acpi_get_gpe_device(gpe, &handle);
>> --
>> 2.8.1
>>
> .
>


