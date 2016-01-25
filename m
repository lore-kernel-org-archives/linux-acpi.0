From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH 1/3] printk: make preferred_console local static bool
Date: Mon, 25 Jan 2016 19:28:52 +0600
Message-ID: <56A62314.3020803@linaro.org>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <1453722324-22407-2-git-send-email-aleksey.makarov@linaro.org>
 <1453725901.28952.53.camel@perches.com> <56A61A6F.10409@linaro.org>
 <1453728205.28952.62.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36159 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405AbcAYN25 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2016 08:28:57 -0500
Received: by mail-lb0-f182.google.com with SMTP id oh2so73874844lbb.3
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2016 05:28:56 -0800 (PST)
In-Reply-To: <1453728205.28952.62.camel@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>



On 25.01.2016 19:23, Joe Perches wrote:
> On Mon, 2016-01-25 at 18:51 +0600, Aleksey Makarov wrote:
>>
>> On 25.01.2016 18:45, Joe Perches wrote:
>>> On Mon, 2016-01-25 at 17:45 +0600, Aleksey Makarov wrote:
>>>> The variable preferred_console is used only inside register_console()
>>>> and it's semantics is boolean.  Make it clear.
>>>
>>> This loses the index of the preferred console.
>>> I'm not sure this is better.
>>
>> That index is not used anywhere.  I believe the patch makes things clear.
>
> Well, with this change the name and its use
> is a bit misleading.  Maybe changing it to
> something like use_selected_console is better.

Thank you. I will fix this in the next version.
