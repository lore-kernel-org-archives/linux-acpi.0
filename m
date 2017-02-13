From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Two questions about the MADT in ACPI table
Date: Mon, 13 Feb 2017 23:18:34 +0100
Message-ID: <CAJZ5v0hSJUi8UEayDGmCRirW7GuzWbHvoZsveDLkVmNh_-sswg@mail.gmail.com>
References: <5f035cfc-3de1-235d-b387-cd7add94a5e1@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f181.google.com ([74.125.82.181]:33923 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdBMWSf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2017 17:18:35 -0500
Received: by mail-ot0-f181.google.com with SMTP id f9so79753437otd.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2017 14:18:35 -0800 (PST)
In-Reply-To: <5f035cfc-3de1-235d-b387-cd7add94a5e1@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Feb 13, 2017 at 2:31 PM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
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
> Apic Id Enable Flag     Apic Id Enable Flag
> 0x00    1               0x00    1
> 0x02    1               0x02    1
> 0x04    0               0x10    1
> 0x06    0               0x12    1
> 0x10    1               0x04    0
> 0x12    1               0x06    0
> 0x14    0               0x14    0
> 0x16    0               0x16    0
>
> If the flag is the same, It will not change the order.
>
> -----orginal-----------------MADT---------
> Apic Id Enable Flag     Apic Id Enable Flag
> 0x00    0               0x00    0
> 0x02    0               0x02    0
> 0x04    0               0x04    0
> 0x06    0               0x06    0
> 0x10    0               0x10    0
> 0x12    0               0x12    0
> 0x14    0               0x14    0
> 0x16    0               0x16    0
>
>
> 2: If the order rule can be changed ?
> If it can be done, What should I do?

Are you asking about Local APIC IDs?

Thanks,
Rafael
