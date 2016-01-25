From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH 1/3] printk: make preferred_console local static bool
Date: Mon, 25 Jan 2016 20:55:16 +0600
Message-ID: <56A63754.7030108@linaro.org>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <1453722324-22407-2-git-send-email-aleksey.makarov@linaro.org>
 <CAHp75Ve+7N+7CCNNQDBBzOZWY-iuVz=9q8vp5TYQhABM2M3cwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36334 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932395AbcAYOzU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2016 09:55:20 -0500
Received: by mail-lb0-f181.google.com with SMTP id oh2so75328615lbb.3
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2016 06:55:19 -0800 (PST)
In-Reply-To: <CAHp75Ve+7N+7CCNNQDBBzOZWY-iuVz=9q8vp5TYQhABM2M3cwg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>



On 25.01.2016 20:24, Andy Shevchenko wrote:
> On Mon, Jan 25, 2016 at 1:45 PM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
>> The variable preferred_console is used only inside register_console()
>> and it's semantics is boolean.  Make it clear.
>
> However the patch looks okay it brings imbalance to understanding how
> exactly the preferred console is chosen.

On the contrary, I would say it makes things more clear.

Also please consider this patch preparatory for the further changes.
See my replies to Joe Perches.

