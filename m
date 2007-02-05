From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: Strange things on 2.6.19/20 for a dual-core CPU
Date: Mon, 5 Feb 2007 14:34:20 +0800
Message-ID: <3877989d0702042234v6734ca66r56a723c2d4c98a6c@mail.gmail.com>
References: <20070205060404.GA23121@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:25345 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbXBEGeV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2007 01:34:21 -0500
Received: by wr-out-0506.google.com with SMTP id i22so1143133wra
        for <linux-acpi@vger.kernel.org>; Sun, 04 Feb 2007 22:34:21 -0800 (PST)
In-Reply-To: <20070205060404.GA23121@tangens.sinus.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>, linux-acpi@vger.kernel.org

Well, enter a acpi bug on bugzilla with acpidump output and dmesg attached.

>   Another interesting thing is shown here:
> patrol@arcus:~$ cat /proc/acpi/processor/CPU1/info
> processor id:            0
> acpi id:                 1
> bus mastering control:   no
> power management:        no
> throttling control:      yes
> limit interface:         yes
> patrol@arcus:~$ cat /proc/acpi/processor/CPU2/info
> processor id:            1
> acpi id:                 2
> bus mastering control:   no
> power management:        no
> throttling control:      no
> limit interface:         no
>
>   As I remember, both cores were showing the same things formerly.
>   The only line referring to CPUs during boot is
> ACPI: Processor [CPU1] (supports 8 throttling states)
>   and CPU2 is not mentioned at all.
>
>   The last (but maybe not acpi-related) strange thing is that in /proc/cpuinfo,
> CPU1 reports 6403.56 bogomips (as always, approximately twice the clock) and CPU2
> 8314.32 ones (too much). It's also very suspicious. Formerly the difference was
> very small.
>
>   Should I provide more info to debug these things, or is it OK ?
>          With regards, Pavel Troller
>
> ----- End forwarded message -----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
