From: Fred Labrosse <ffl@aber.ac.uk>
Subject: multiple APIC/MADT found
Date: Fri, 13 Nov 2009 13:38:38 +0000
Message-ID: <200911131338.38528.ffl@aber.ac.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from braint.aber.ac.uk ([144.124.16.42]:37606 "EHLO
	braint.aber.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbZKMNuS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2009 08:50:18 -0500
Received: from pcffl.dcs.aber.ac.uk ([193.60.10.49] helo=aber.ac.uk)
	by braint.aber.ac.uk with esmtp (Exim 4.69)
	(envelope-from <ffl@aber.ac.uk>)
	id 1N8wMI-0002c5-5q
	for linux-acpi@vger.kernel.org; Fri, 13 Nov 2009 13:38:38 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

At some point, I discovered that I only had one processor active on my 
laptop (A VAIO VGN-SZ2M) wich has a centrino duo in (2 cores).  I then 
discovered in dmesg the lines that say:

ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify linux-
acpi@vger.kernel.org

So I did that (acpi_apic_instance=2) and that did give me 2 processors.  
Which is definitely better, hence my email to the suggested address.

There is one thing that does not quite work however and I don't know if this 
is related: ACPI only sees one processor and therefore cpufreq only controls 
the frequency of one processor.  I think this used to work but I don't know 
when that stopped.

Hee's the output of uname:

# uname -a
Linux pcp2ffl 2.6.30-gentoo-r8 #4 SMP PREEMPT Thu Nov 12 18:41:51 GMT 2009 
i686 Genuine Intel(R) CPU T2300 @ 1.66GHz GenuineIntel GNU/Linux

I have tried with a vanilla kernel too but that made no difference.

Hope this helps.

Fred
