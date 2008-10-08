From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Problem: ACPI related soft lockup on Fujitsu-Siemens AMILO Si
 2636
Date: Wed, 08 Oct 2008 11:42:29 +0400
Message-ID: <48EC6465.8060200@gmail.com>
References: <48E9F51A.4080107@gmail.com> <48EC5F4B.8020009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:2282 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbYJHHmL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 03:42:11 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1183071eyi.37
        for <linux-acpi@vger.kernel.org>; Wed, 08 Oct 2008 00:42:09 -0700 (PDT)
In-Reply-To: <48EC5F4B.8020009@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Lindroth <thomas.lindroth@gmail.com>
Cc: linux-acpi@vger.kernel.org

Thomas Lindroth wrote:
> I've done some debugging of this problem myself and reached some conclusions.
>
> I tried activating the ACPI_LV_INFO ACPI debug mode and observed what happens
> when the system is under load. I saved one trace and put it in the file
> acpi_debug_log at http://www.cyd.liu.se/~tholi945/acpi-bug-2008-10-06/
>
> When the temp goes over the ACPI passive trip point the processor gets
> throttled. It usually never goes over T4 before the temp falls below the
> passive temp but sometimes it reaches the highest T7. If it reach T7 the
> next call to _TMP or _L18 never returns. I've confirmed this by running
> echo T7 > /proc/acpi/processor/CPU*/throttling and then tried to read
> from /proc/acpi/thermal_zone/TZ00/temperature and it fails in the same way.
>
> I've tried activating the ACPI_LV_PARSE ACPI debug mode, enter T7 and read
> from temp. I put the result of that in the trace_debug file at the same adress.
>
> The AML call chain looks like this _TMP -> PMRD -> RCMD -> WIBF
> WIBF always returns 1 causing the interpreter to get stuck in the while
> loop in PMRD.
>
> While (RCMD (0x80, Local0))
> {
>     Noop
>     Noop
>     Store (PMUC, Local5)
>     If (And (Local5, One, Local2))
>     {
>         Store (PMUD, Local5)
>     }
> }
>
>   
This is AML implementation of EC driver... it relies on certain speed
of AML interpreter to work properly (look for Noop inserted as delay).

It is possible to replace this driver with the native Linux one, which 
might be
more robust, but this involves heavy DSDT hacking.

Overall, it is heavily mis-designed BIOS, so don't expect it to be fixed 
on Linux side.

Regards,
Alex.
