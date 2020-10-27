Return-Path: <SRS0=OwHM=EC=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A33FC2D0A3
	for <linux-acpi@archiver.kernel.org>; Tue, 27 Oct 2020 01:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F7A217A0
	for <linux-acpi@archiver.kernel.org>; Tue, 27 Oct 2020 01:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502394AbgJ0BKr (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 26 Oct 2020 21:10:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:5468 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502382AbgJ0BKq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Oct 2020 21:10:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CKttd3s9CzhZYL;
        Tue, 27 Oct 2020 09:10:49 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 09:10:40 +0800
Subject: Re: [PATCH] ACPI: dock: fix enum-conversion warning
To:     Arnd Bergmann <arnd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201026214838.3892471-1-arnd@kernel.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <86ffe33a-f5f5-ca38-3d96-1c311e7d6b03@huawei.com>
Date:   Tue, 27 Oct 2020 09:10:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201026214838.3892471-1-arnd@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/10/27 5:48, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc points out a type mismatch:
> 
> drivers/acpi/dock.c: In function 'hot_remove_dock_devices':
> drivers/acpi/dock.c:234:53: warning: implicit conversion from 'enum <anonymous>' to 'enum dock_callback_type' [-Wenum-conversion]
>    234 |   dock_hotplug_event(dd, ACPI_NOTIFY_EJECT_REQUEST, false);
> 
> This is harmless because 'false' still has the correct numeric value,
> but passing DOCK_CALL_HANDLER documents better what is going on
> and avoids the warning.
> 
> Fixes: 37f908778f20 ("ACPI / dock: Walk list in reverse order during removal of devices")
> Fixes: f09ce741a03a ("ACPI / dock / PCI: Drop ACPI dock notifier chain")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/acpi/dock.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index 45d4b7b69de8..24e076f44d23 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -231,7 +231,8 @@ static void hot_remove_dock_devices(struct dock_station *ds)
>   	 * between them).
>   	 */
>   	list_for_each_entry_reverse(dd, &ds->dependent_devices, list)
> -		dock_hotplug_event(dd, ACPI_NOTIFY_EJECT_REQUEST, false);
> +		dock_hotplug_event(dd, ACPI_NOTIFY_EJECT_REQUEST,
> +				   DOCK_CALL_HANDLER);
>   
>   	list_for_each_entry_reverse(dd, &ds->dependent_devices, list)
>   		acpi_bus_trim(dd->adev);

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
