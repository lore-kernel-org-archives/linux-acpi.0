From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [RESEND PATCH v7] acpi: apei: remove the unused dead-code for
 SEA/NMI notification type
Date: Sun, 22 Oct 2017 18:18:03 +0800
Message-ID: <812042fc-bbf2-6bbb-8d5c-be32851005a1@huawei.com>
References: <1508655253-20785-1-git-send-email-gengdongjiu@huawei.com>
 <CAJZ5v0gAGv2XSfvqx7Dyu1w8csUmoJ96wR667WZp4Dq_beyKHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8971 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdJVKSU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Oct 2017 06:18:20 -0400
In-Reply-To: <CAJZ5v0gAGv2XSfvqx7Dyu1w8csUmoJ96wR667WZp4Dq_beyKHw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Prarit Bhargava <prarit@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



On 2017/10/22 17:38, Rafael J. Wysocki wrote:
> On Sun, Oct 22, 2017 at 8:54 AM, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>> For the SEA notification, the two functions ghes_sea_add() and
>> ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
>> is defined. If not, it will return errors in the ghes_probe()
>> and not continue. If the probe is failed, the ghes_sea_remove()
>> also has no chance to be called. Hence, remove the unnecessary
>> handling when CONFIG_ACPI_APEI_SEA is not defined.
>>
>> For the NMI notification, it has the same issue as SEA notification,
>> so also remove the unused dead-code for it.
>>
>> Cc: Tyler Baicar <tbaicar@codeaurora.org>
>> Cc: James Morse <james.morse@arm.com>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
>> Reviewed-by: Borislav Petkov <bp@suse.de>
> I applied one of the previous iterations.
> 
> Do I need to replace it with this version?

Rafael, I checked your applying, your applying is right. so no need to replace.
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=3275fe60d1138e0cb57be9a3f46306b4d031c643
which is already "Reviewed-by: Borislav Petkov <bp@suse.de>"
Thanks

> 

