Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C955DC2B9F7
	for <linux-acpi@archiver.kernel.org>; Tue, 25 May 2021 02:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26D761003
	for <linux-acpi@archiver.kernel.org>; Tue, 25 May 2021 02:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhEYCsU (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 24 May 2021 22:48:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3991 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhEYCsU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 22:48:20 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fpz1n0snxzmVFM;
        Tue, 25 May 2021 10:44:29 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 10:46:49 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 10:46:48 +0800
Subject: Re: [PATCH -next] ACPI: LPSS: Replaced simple_strtol() with kstrtol()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <20210524120832.1580247-1-liushixin2@huawei.com>
 <CAJZ5v0gZYupB2w4oU1QGvE5aohcyPXk=BJVRvSrApGzp=sXkMQ@mail.gmail.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <a62a08be-33e2-d22b-c790-3765c87a2309@huawei.com>
Date:   Tue, 25 May 2021 10:46:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gZYupB2w4oU1QGvE5aohcyPXk=BJVRvSrApGzp=sXkMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2021/5/24 22:33, Rafael J. Wysocki wrote:
> On Mon, May 24, 2021 at 1:35 PM Liu Shixin <liushixin2@huawei.com> wrote:
>> The simple_strtol() function is deprecated in some situation since
>> it does not check for the range overflow. Use kstrtol() instead.
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>  drivers/acpi/acpi_lpss.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
>> index ca742f16a507..1b46e00cad3a 100644
>> --- a/drivers/acpi/acpi_lpss.c
>> +++ b/drivers/acpi/acpi_lpss.c
>> @@ -186,13 +186,12 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
>>         long uid = 0;
>>
>>         /* Expected to always be true, but better safe then sorry */
>> -       if (uid_str)
>> -               uid = simple_strtol(uid_str, NULL, 10);
>> -
>> -       /* Detect I2C bus shared with PUNIT and ignore its d3 status */
>> -       status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);
>> -       if (ACPI_SUCCESS(status) && shared_host && uid)
>> -               pmc_atom_d3_mask &= ~(BIT_LPSS2_F1_I2C1 << (uid - 1));
>> +       if (uid_str && !kstrtol(uid_str, 10, &uid)) {
>> +               /* Detect I2C bus shared with PUNIT and ignore its d3 status */
>> +               status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);
>> +               if (ACPI_SUCCESS(status) && shared_host && uid)
>> +                       pmc_atom_d3_mask &= ~(BIT_LPSS2_F1_I2C1 << (uid - 1));
>> +       }
> This is not a simple replacement.
>
> Why are you making the other changes?
The variables status and shared_host are valid only when the uid is not zero(default to zero).
If uid_str is NULL or kstrtol() failed or uid is assigned to zero, we can skip these operations.
>>         lpss_deassert_reset(pdata);
>>
>> --
> .
>

