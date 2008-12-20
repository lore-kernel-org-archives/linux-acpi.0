From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI Problem with HP EliteBook 2530p
Date: Sat, 20 Dec 2008 23:18:20 +0300
Message-ID: <494D530C.8000209@gmail.com>
References: <494D31B0.90807@kolmann.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:34206 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbYLTUSO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Dec 2008 15:18:14 -0500
Received: by bwz14 with SMTP id 14so5727324bwz.13
        for <linux-acpi@vger.kernel.org>; Sat, 20 Dec 2008 12:18:12 -0800 (PST)
In-Reply-To: <494D31B0.90807@kolmann.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Philipp Kolmann <philipp@kolmann.at>
Cc: linux-acpi@vger.kernel.org

Hi Philipp,

Please check if http://bugzilla.kernel.org/show_bug.cgi?id=11884 is the 
same problem.
There is  a patch, which is reported to help with HP 2730p.
If patch does not help you, please create new bug report and attach your 
acpidump and dmesg (at least from acpi=ht run).

Regards,
Alex.

Philipp Kolmann wrote:
> Hi,
>
> I hope I don't mistreat any code of the mailinglist. I am new here.
>
> I have a new HP Elitebook 2530p with Debian on it (and also Vista).
>
> With 2.6.27 I had no ACPI problems until a VISTA Update somehow broke 
> the ACPI tables.
>
> Now if I boot with ACPI enabled on 2.6.27 and 2.6.28-rc9 the computer 
> hangs completely.
> It only works with acpi=ht.
>
> I also tried pci=noacpi, acpi=noirq, there it hung saying it has a 
> problem with the second CPU.
>
> Can anyone tell me, how to get the proper debugging info for you, so 
> you can help.
>
> Do you prefer screenshots?
>
> thanks
> Philipp
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

