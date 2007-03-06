From: Renato Alves <simpledark@gmail.com>
Subject: Fixing DSDT table for correct LID behavior
Date: Tue, 06 Mar 2007 00:40:06 +0000
Message-ID: <45ECB866.6010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:29029 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933612AbXCFAkK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Mar 2007 19:40:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so19382uga
        for <linux-acpi@vger.kernel.org>; Mon, 05 Mar 2007 16:40:09 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi guys.

This is my first message to the mailing list.
I'm still new to the ACPI and DSDT mambo jumbo and not a programmer, but
anyway... I tried to debug the dsdt of my laptop (Acer Aspire 1694 LMi)
to solve some of the typical problems (no BAT info, boot hangs...). So
far, by using a mixture of the custom DSDTs at acpi.sf.net I managed to
solve the BAT issues and the boot hangs.
Using iasl I got only one warning, that I don't know how to solve:

dsdt.custom.dsl  7598:                             And (0xFE, Local7)
Warning  1104 -          Result is not used, operator has no effect ^

Past this, I now have the system with thermal support in passive mode
(no throttling), no fan info (no rpm, no throttling, no nothing),
ac_adapter is fine, button power and sleep are fine, lid works but I
will get back to it later, processor is also fine (with throttling) and
battery is also fine except for present rate when charging.

Now the LID: the problem with this is the number of events generated.
The ideal behavior would be 1 event on lid close and 1 on lid open. But
actually what happens is 5 events per second when the lid is closed.
This causes high CPU loads when software like cpufreq parses the logs
and huge logs by acpid.

I was hoping someone could tip me on how to reduce the number of events
generated to prevent this flooding. And enlighten about the possibility
of getting the fan and thermal parts working "non-passive".

Here is a copy of what I have been working on:
http://apollo.dq.fct.unl.pt/~al1133/dsdt.tar.bz2

Thanks
--
Renato Alves
