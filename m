From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH V2 3/4] mailbox: pcc: optimized
 pcc_send_data
Date: Mon, 25 Jan 2016 12:52:17 -0600
Message-ID: <56A66EE1.6010605@codeaurora.org>
References: <1453511240-20792-1-git-send-email-pprakash@codeaurora.org>
 <1453511240-20792-4-git-send-email-pprakash@codeaurora.org>
 <CAOZdJXU8wCJZpo61TcusArxBgXdKQEFbxRmFVZTOy6dxPm=CnA@mail.gmail.com>
 <CAJ5Y-eYtTz05Vk+DOLhKk8gOMo5j7x_DAqZmvQRC4kW40XPsfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48182 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757401AbcAYSwU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2016 13:52:20 -0500
In-Reply-To: <CAJ5Y-eYtTz05Vk+DOLhKk8gOMo5j7x_DAqZmvQRC4kW40XPsfQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Prashanth Prakash <pprakash@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>

Ashwin Chaugule wrote:

>>> +       pcc_doorbell_vaddr = kcalloc(count, sizeof(void *), GFP_KERNEL);
>>
>> ... this is wrong.  You're using readl() and writel() on this pointer,
>> but it's not an iomem pointer, it's normal kernel memory.  You need to
>> delete your usage of readX, writeX on this pointer.
>>
>
> The acpi_os_ioremap() below should take care of that.

...

>>> +               if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>>> +                       pcc_doorbell_vaddr[i] = acpi_os_ioremap(db_reg->address,
>>> +                                                       db_reg->bit_width/8);

Ah, I see.  pcc_doorbell_vaddr[i] still needs to be an __iomem*, and the 
rest of the code needs to honor that.

