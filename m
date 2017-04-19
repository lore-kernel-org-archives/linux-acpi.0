From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] acpi: fix typo
Date: Wed, 19 Apr 2017 21:34:57 +0200
Message-ID: <CAJZ5v0g8VeDG5KM8=Ls3m=Z+nRbCW6oP1ZoiLdz9rNW5-NSYTg@mail.gmail.com>
References: <1490953594-16014-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <CAJZ5v0gMp2ahedsmD6qUnXj0-=EVdPTC8C-e-HiuO17Ai-1PGA@mail.gmail.com> <58F6F3E1.5020601@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:32881 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764728AbdDSTe6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2017 15:34:58 -0400
In-Reply-To: <58F6F3E1.5020601@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Lv <lv.zheng@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>

On Wed, Apr 19, 2017 at 7:21 AM, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> Hi
>
> On 04/19/2017 08:20 AM, Rafael J. Wysocki wrote:
>> On Fri, Mar 31, 2017 at 11:46 AM, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>>> ---
>>>  Documentation/acpi/linuxized-acpica.txt | 10 +++++-----
>>
>> Please send changes to this file separately.
>>
>>>  include/acpi/actypes.h                  |  4 ++--
>>
>> This one belongs to ACPICA and there is a special process for
>> modifying ACPICA files.
>>
>
> I have read the process. So, does that means, we never send acpica patch
> to kernel mail list, they only can be sent to acpica project?

You can send them to linux-acpi, but then you need to CC the ACPICA
maintainers and development mailing list *and* make sure that the
patch modifies the ACPICA code only (ie. no mixed ACPICA and
non-ACPICA changes in one go, please).

Thanks,
Rafael
