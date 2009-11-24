From: Alex <ambroxa@yahoo.it>
Subject: Avoid C2/C3 idle state
Date: Tue, 24 Nov 2009 21:50:01 +0000 (GMT)
Message-ID: <642590.96306.qm@web26502.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web26502.mail.ukl.yahoo.com ([217.146.176.39]:25382 "HELO
	web26502.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S934318AbZKXV4h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Nov 2009 16:56:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I run Ubuntu 8.04.3 LTS server 32bit in a small low power motherboard (VIA LN10000EG) equipped with VIA C7 1GHz CPU.
Kernel 2.6.24

I've some problems with serial device: sometimes I've overrun errors when receive data through /dev/ttyS0

After some days of hard work I've discovered that when CPU enter in C2 or C3 state and data come in from serial line, I've the overrun.

I've searched for a solution and I've found that kernel parameter "idle=halt" can avoid CPU enter C2/C3 state, but this parameter is now not supported anymore (it was in the past).
So I've completely disabled the ACPI support ("acpi=off" kernel parameter).
But I lack support for power button, poweroff command and so on.
I wish to re-enable ACPI.

The question is: Howto avoid CPU enter C2/C3 state and re-activate ACPI so CPU can go in C1 state ? C1 is better than nothing at all ....

I have no problem to modify kernel source and recompile it.

Thanks fo suggestions


      
