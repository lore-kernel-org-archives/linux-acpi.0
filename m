From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: [repost] acpi on gentoo
Date: Sun, 11 Mar 2007 22:12:14 +0800
Message-ID: <3877989d0703110712i34065b9dyd470ba7d1e7d2b15@mail.gmail.com>
References: <45F406EA.7000808@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:38050 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933640AbXCKOMR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Mar 2007 10:12:17 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1907413uga
        for <linux-acpi@vger.kernel.org>; Sun, 11 Mar 2007 07:12:15 -0700 (PDT)
In-Reply-To: <45F406EA.7000808@hotmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel <nigels@hotmail.com>
Cc: linux-acpi@vger.kernel.org

On 3/11/07, Nigel <nigels@hotmail.com> wrote:
>
> Trying again to see if anyone had any other ideas.
>
> In addition:
> The acpid daemon is running.
> The same machine when booted into windows will automatically go to
> powersave mode when the power cable is removed.
>

what condition is your battery in? It makes sense if battery power is very low.
If battery is still full, then it sounds like a bug.  You need to test
the latest base kernel before entering a acpi bug into
bugzilla.kernel.org.

> One interesting though, if I do : modprobe button
> then every 30 seconds or so I get:
> received event "battery BAT1 00000080 00000001"
>
> Even when i do rmmod button I still keep getting these events.
> The only way to go back to "normal" behaviour is to reboot.
>
> Any suggestions as to what might be my problem here ?
>
I guess your battery power level is low.
