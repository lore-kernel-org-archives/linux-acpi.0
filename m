From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPI / PCI: remove stale list_head in struct acpi_prt_entry
Date: Fri, 22 May 2015 19:04:27 +0800
Message-ID: <555F0D3B.5080607@linaro.org>
References: <1432216352-8016-1-git-send-email-hanjun.guo@linaro.org> <CAErSpo6kFfXd9gFuL86qQWcVN6NYe11Ps+SoAefz1z2md8j_tA@mail.gmail.com> <555DF723.2000103@linaro.org> <CAErSpo4uZ09K7BSZyyhMtxFpuMCn6hxE01QFWw8nmo7snshutg@mail.gmail.com> <CAErSpo4RebTb36xdXKK-qQ_btYgCQicbH6hF0AFNOmcBWoNRvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34391 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038AbbEVLEb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2015 07:04:31 -0400
Received: by pabru16 with SMTP id ru16so17145587pab.1
        for <linux-acpi@vger.kernel.org>; Fri, 22 May 2015 04:04:31 -0700 (PDT)
In-Reply-To: <CAErSpo4RebTb36xdXKK-qQ_btYgCQicbH6hF0AFNOmcBWoNRvA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Yijing Wang <wangyijing@huawei.com>

On 2015=E5=B9=B405=E6=9C=8821=E6=97=A5 23:53, Bjorn Helgaas wrote:
> On Thu, May 21, 2015 at 10:21 AM, Bjorn Helgaas <bhelgaas@google.com>=
 wrote:
>> On Thu, May 21, 2015 at 10:17 AM, Hanjun Guo <hanjun.guo@linaro.org>=
 wrote:
>>> On 2015=E5=B9=B405=E6=9C=8821=E6=97=A5 23:10, Bjorn Helgaas wrote:
>>>>
>>>> On Thu, May 21, 2015 at 8:52 AM, Hanjun Guo <hanjun.guo@linaro.org=
> wrote:
>>>>>
>>>>> list_head "list" in struct acpi_prt_entry was used to connect
>>>>> _PRT entries for PCI irq, but after commit 181380b7 (PCI/ACPI:
>>>>> Don't cache _PRT, and don't associate them with bus numbers),
>>>>> the list head for _PRT entries was removed, but left "list" in
>>>>> struct acpi_prt_entry which is useless and stale, remove it now.
>>>>
>>>>
>>>> Please use the canonical commit reference format, i.e.,
>>>>
>>>> 181380b702ee ("PCI/ACPI: Don't cache _PRT, and don't associate the=
m
>>>> with bus numbers")
>>>
>>>
>>> OK, now I know what is a canonical commit reference format :)
>>
>> Yeah, it'd be nice if that were better documented.  checkpatch
>> complains about it (d311cd44545f ("checkpatch: add test for commit i=
d
>> formatting style in commit log")), but unfortunately I don't think
>> it's mentioned anywhere in Documentation/
>
> I guess it actually *is* mentioned:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/SubmittingPatches#n171,
> but it's a little bit wishy-washy.  I'll propose a tweak.

Thanks for the guidance :)

Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
