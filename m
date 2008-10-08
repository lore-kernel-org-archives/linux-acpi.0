From: Thomas Lindroth <thomas.lindroth@gmail.com>
Subject: Re: Problem: ACPI related soft lockup on Fujitsu-Siemens AMILO Si
 2636
Date: Wed, 08 Oct 2008 09:20:43 +0200
Message-ID: <48EC5F4B.8020009@gmail.com>
References: <48E9F51A.4080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.182]:52133 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbYJHHUs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 03:20:48 -0400
Received: by ik-out-1112.google.com with SMTP id c30so2377895ika.5
        for <linux-acpi@vger.kernel.org>; Wed, 08 Oct 2008 00:20:46 -0700 (PDT)
In-Reply-To: <48E9F51A.4080107@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I've done some debugging of this problem myself and reached some conclusions.

I tried activating the ACPI_LV_INFO ACPI debug mode and observed what happens
when the system is under load. I saved one trace and put it in the file
acpi_debug_log at http://www.cyd.liu.se/~tholi945/acpi-bug-2008-10-06/

When the temp goes over the ACPI passive trip point the processor gets
throttled. It usually never goes over T4 before the temp falls below the
passive temp but sometimes it reaches the highest T7. If it reach T7 the
next call to _TMP or _L18 never returns. I've confirmed this by running
echo T7 > /proc/acpi/processor/CPU*/throttling and then tried to read
from /proc/acpi/thermal_zone/TZ00/temperature and it fails in the same way.

I've tried activating the ACPI_LV_PARSE ACPI debug mode, enter T7 and read
from temp. I put the result of that in the trace_debug file at the same adress.

The AML call chain looks like this _TMP -> PMRD -> RCMD -> WIBF
WIBF always returns 1 causing the interpreter to get stuck in the while
loop in PMRD.

While (RCMD (0x80, Local0))
{
    Noop
    Noop
    Store (PMUC, Local5)
    If (And (Local5, One, Local2))
    {
        Store (PMUD, Local5)
    }
}

I don't really understand how AML code works so I can't get much further than
this.

I did not experience complete lockups in Windows but I did notice some minor
stalls. Maybe the Windows AML parser can break infinite loops or maybe the
stalls is a normal part of the Windows experience. I tried to boot with the
acpi_osi=Linux option active but it didn't make any difference.


/Thomas Lindroth
