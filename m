From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH - 2.6.19 -0/2] Backport of psmouse suspend/shutdown cleanups
Date: Wed, 21 Feb 2007 15:30:42 -0500
Message-ID: <d120d5000702211230s24b6ebdcja31ccb7359754931@mail.gmail.com>
References: <1172077685.10619.101.camel@d36.suse.de>
	 <20070221195203.GF3732@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:36380 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423100AbXBUUao (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Feb 2007 15:30:44 -0500
Received: by an-out-0708.google.com with SMTP id b33so670460ana
        for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2007 12:30:43 -0800 (PST)
In-Reply-To: <20070221195203.GF3732@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Renninger <trenn@suse.de>, Stable <Stable@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Hi Pavel,

On 2/21/07, Pavel Machek <pavel@ucw.cz> wrote:
>
> Yes, it is quite nasty problem, but:
>
> 1) Fix is non-trivial (>100 lines, which violates -stable rule IIRC)
>

The fix itself is only 30 lines (counting empty lines and comments)
which is not too bad.

> 2) Fix is very disconnected from the problem. "Deinitialize mouse so
> that fans work after reboot". WTF?

Can you imagine how I love this kind of bugs? ;)

>
> 3) AFAICT it is not a regression.
>

But it is very annoying for HP laptop owners.

-- 
Dmitry
