From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: Two questions about the MADT in ACPI table
Date: Wed, 15 Feb 2017 10:38:11 +0800
Message-ID: <46ea45ad-e2de-27f6-e71a-6908703a48cf@linaro.org>
References: <5f035cfc-3de1-235d-b387-cd7add94a5e1@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33812 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbdBOCii (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2017 21:38:38 -0500
Received: by mail-pg0-f51.google.com with SMTP id z67so470615pgb.1
        for <linux-acpi@vger.kernel.org>; Tue, 14 Feb 2017 18:38:37 -0800 (PST)
In-Reply-To: <5f035cfc-3de1-235d-b387-cd7add94a5e1@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, rafael@kernel.org, "Zheng, Lv" <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org

On 2017/2/13 21:31, Dou Liyang wrote:
> Hi, Rafael, Lv
>
> May I ask for your help.
>
> Recently, I am very confused about the generation of the MADT
> in ACPI table.
>
> 1: Why we put all the Apic Ids which flag==1 in front of the
> one which flag==0 in MADT?
>
> Just like that:
>
> -----orginal-----------------MADT-------
> Apic Id    Enable Flag    Apic Id    Enable Flag
> 0x00    1        0x00    1
> 0x02    1        0x02    1
> 0x04    0        0x10    1
> 0x06    0        0x12    1
> 0x10    1        0x04    0
> 0x12    1        0x06    0
> 0x14    0        0x14    0
> 0x16    0        0x16    0
>
> If the flag is the same, It will not change the order.
>
> -----orginal-----------------MADT---------
> Apic Id    Enable Flag    Apic Id    Enable Flag
> 0x00    0        0x00    0
> 0x02    0        0x02    0
> 0x04    0        0x04    0
> 0x06    0        0x06    0
> 0x10    0        0x10    0
> 0x12    0        0x12    0
> 0x14    0        0x14    0
> 0x16    0        0x16    0

Sorry, a little bit confused, local APIC entries are listed in
MADT by firmware, and MADT is a static table which means the OS
will not update the orders.

>
>
> 2: If the order rule can be changed ?
> If it can be done, What should I do?

What's the issue you are facing? any problem here?

Thanks
Hanjun
