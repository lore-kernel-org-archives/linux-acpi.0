From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v11 1/1] Mailbox: Add support for Platform Communication Channel
Date: Thu, 27 Nov 2014 13:03:57 +0530
Message-ID: <CAJe_ZheZ=zv-EPm26migsjMooBgo8f1hwZ195okAr834dO7mQg@mail.gmail.com>
References: <1415840378-1973-1-git-send-email-ashwin.chaugule@linaro.org>
	<1415840378-1973-2-git-send-email-ashwin.chaugule@linaro.org>
	<1946980.r78SuCoQbW@wuerfel>
	<CAJ5Y-eZ4XKBOvdk9FLi=-5y7jMWM2Wq28QeS6isUdm=X4wFP0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:49191 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbaK0Hd6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2014 02:33:58 -0500
Received: by mail-qg0-f44.google.com with SMTP id z60so3220267qgd.3
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2014 23:33:57 -0800 (PST)
In-Reply-To: <CAJ5Y-eZ4XKBOvdk9FLi=-5y7jMWM2Wq28QeS6isUdm=X4wFP0g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 18 November 2014 at 19:51, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> On 18 November 2014 08:39, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wednesday 12 November 2014 19:59:38 Ashwin Chaugule wrote:
>>> ACPI 5.0+ spec defines a generic mode of communication
>>> between the OS and a platform such as the BMC. This medium
>>> (PCC) is typically used by CPPC (ACPI CPU Performance management),
>>> RAS (ACPI reliability protocol) and MPST (ACPI Memory power
>>> states).
>>>
>>> This patch adds PCC support as a Mailbox Controller. As of
>>> ACPI v5.1 there is no provision for clients to lookup mailbox
>>> controllers in a way that Linux expects. e.g. in DT the clients
>>> can list the mailboxes they can associate with in the DT binding
>>> and then provide a unique index to lookup a channel within a mailbox.
>>> Since the ACPI spec doesn't have anything similar, we introduce a
>>> mailbox controller specific API so that when the client calls it,
>>> we know to lookup in the context of a specific controller. This
>>> also helps in keeping a consistent interface across DT and ACPI
>>> for such drivers.
>>>
>>> This patch implements basic PCC support using the ACPI v5.1
>>> structures. IRQ mode support will be provided as follow up patches.
>>>
>>> Reviewed-by: Mark Brown <broonie@kernel.org>
>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>>
>>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> Very much appreciated !
> Thanks for the constructive feedback Arnd, Jassi, Mark, Sudeep, Lv and Rafael!
> Jassi, can you please pick this patch? or if you'd prefer, I can send
> a git pull for it.
>
Applied to mailbox-devel, Thanks

-Jassi
