From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH 1/3] printk: make preferred_console local static bool
Date: Mon, 25 Jan 2016 18:51:59 +0600
Message-ID: <56A61A6F.10409@linaro.org>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <1453722324-22407-2-git-send-email-aleksey.makarov@linaro.org>
 <1453725901.28952.53.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35738 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118AbcAYMwF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2016 07:52:05 -0500
Received: by mail-lf0-f52.google.com with SMTP id c192so83707491lfe.2
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2016 04:52:03 -0800 (PST)
In-Reply-To: <1453725901.28952.53.camel@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>



On 25.01.2016 18:45, Joe Perches wrote:
> On Mon, 2016-01-25 at 17:45 +0600, Aleksey Makarov wrote:
>> The variable preferred_console is used only inside register_console()
>> and it's semantics is boolean.  Make it clear.
>
> This loses the index of the preferred console.
> I'm not sure this is better.

That index is not used anywhere.  I believe the patch makes things clear.

Also, it indexes the array console_cmdline.  With introduction of the 
ACPI-selected console it does not have any sense and I would have to 
change it anyway.

Thank you
Aleksey Makarov
