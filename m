From: Frank von Daak <f.vondaak@kpage.de>
Subject: Dual Core CPU on Abit NI8-Board
Date: Fri, 7 Apr 2006 07:07:46 +0200
Message-ID: <200604070707.47121.f.vondaak@kpage.de>
Reply-To: f.vondaak@kpage.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from s15206242.onlinehome-server.info ([87.106.7.174]:55168 "EHLO
	kpage.de") by vger.kernel.org with ESMTP id S932259AbWDGFHJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2006 01:07:09 -0400
Received: from p54851c26.dip0.t-ipconnect.de ([84.133.28.38] helo=frank.vondaak.fun)
	by kpage.de with esmtp (Exim 4.60)
	(envelope-from <f.vondaak@kpage.de>)
	id 1FRjBc-0006w2-3D
	for linux-acpi@vger.kernel.org; Fri, 07 Apr 2006 07:07:08 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello!

I've a problem with my configuration and maybe someone of you can help me out.

My system looks like this:
Abit NI8 SLI mother board
CPU Pentium-D 2,8 GHz (dual-core)
1 GB DDR2-RAM (one module)
2x GeForc7800GTX grahpics adapter (to connect three monitors)
kernel 2.6.17-rc1 (vanilla)

My problem ist, that a "cat /proc/cpuinfo" show's just one cpu-core if I boot 
with ACPI enabled.
If I disable ACPI by removing it from kernel or by passing 'append="acpi=off"' 
to my lilo.conf, the system is going unstable. It is freezing sporadical 
without any trace output. The freezes occur after a short time, especialy 
when I run OpenGL-applications - but also without OpenGL!

I have collected some information about my system here:
--------------------------------------------------------------
dmesg's output with acpi-debug enabled in kernel:
http://www.kpage.de/dmesg_acpi3.txt

My kernels ".config"-file:
http://www.kpage.de/config.txt

The output of "cat /proc/interrupts" when ACPI is enabled:
http://www.kpage.de/interrupts_acpi3.txt

The output of "cat /proc/interrupts" when ACPI is disabled:
http://www.kpage.de/interrupts_noacpi3.txt

The output of "cat /proc/cpuinfo" if ACPI is enabled:
http://www.kpage.de/cpuinfo_acpi3.txt

The output of "cat /proc/cpuinfo" if ACPI is disabled:
http://www.kpage.de/cpuinfo_noacpi3.txt

And last, but not least: the output of "acpidump":
http://www.kpage.de/acpidump.txt
--------------------------------------------------------------

I've started a discussion about this problem on the linux-smp mailinglist. You 
can find some more information about what I've done by now here:
http://marc.theaimsgroup.com/?l=linux-smp&m=114421848813280&w=2

I have also contacted nvidia and abit - without response from abit by the 
time...

Who can give me a little help?

Thank you very much!!!
Greetings
Frank

-- 
Name:	Frank von Daak
