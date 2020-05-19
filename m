Return-Path: <SRS0=hksk=7B=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78850C433DF
	for <linux-acpi@archiver.kernel.org>; Tue, 19 May 2020 10:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE23205CB
	for <linux-acpi@archiver.kernel.org>; Tue, 19 May 2020 10:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgESKkm (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 19 May 2020 06:40:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgESKkm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 May 2020 06:40:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 363123CF16D80D759112
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2020 18:40:41 +0800 (CST)
Received: from [127.0.0.1] (10.74.173.29) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 19 May 2020
 18:40:36 +0800
From:   "shenyang (M)" <shenyang39@huawei.com>
To:     <linux-acpi@vger.kernel.org>
Subject: Question about ACPI_THERMAL_HID of thermal
Message-ID: <c61a713e-2d4b-91ba-26fa-e3c2f3c50b44@huawei.com>
Date:   Tue, 19 May 2020 18:40:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.173.29]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Sorry for disturbing you.
I want to use the driver thermal.ko. But here I got a question:
the ACPI_THERMAL_HID does not comply with ACPI spec. So I want to know
if any device is using this driver. And if no one is using this driver,
can I modify this HID to comply with ACPI specifications?

Thanks,
Yang

