From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPI / PCI: remove stale list_head in struct acpi_prt_entry
Date: Thu, 21 May 2015 23:17:55 +0800
Message-ID: <555DF723.2000103@linaro.org>
References: <1432216352-8016-1-git-send-email-hanjun.guo@linaro.org> <CAErSpo6kFfXd9gFuL86qQWcVN6NYe11Ps+SoAefz1z2md8j_tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33309 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139AbbEUPSF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2015 11:18:05 -0400
Received: by padbw4 with SMTP id bw4so108602231pad.0
        for <linux-acpi@vger.kernel.org>; Thu, 21 May 2015 08:18:05 -0700 (PDT)
In-Reply-To: <CAErSpo6kFfXd9gFuL86qQWcVN6NYe11Ps+SoAefz1z2md8j_tA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Yijing Wang <wangyijing@huawei.com>

On 2015=E5=B9=B405=E6=9C=8821=E6=97=A5 23:10, Bjorn Helgaas wrote:
> On Thu, May 21, 2015 at 8:52 AM, Hanjun Guo <hanjun.guo@linaro.org> w=
rote:
>> list_head "list" in struct acpi_prt_entry was used to connect
>> _PRT entries for PCI irq, but after commit 181380b7 (PCI/ACPI:
>> Don't cache _PRT, and don't associate them with bus numbers),
>> the list head for _PRT entries was removed, but left "list" in
>> struct acpi_prt_entry which is useless and stale, remove it now.
>
> Please use the canonical commit reference format, i.e.,
>
> 181380b702ee ("PCI/ACPI: Don't cache _PRT, and don't associate them
> with bus numbers")

OK, now I know what is a canonical commit reference format :)

>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> CC: Yinghai Lu <yinghai@kernel.org>
>> CC: Yijing Wang <wangyijing@huawei.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks, will update the change log soon.

Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
