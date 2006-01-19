From: Diego Calleja <diegocg@gmail.com>
Subject: CONFIG_ACPI_PROCESSOR=y confuses the cpu scheduler
Date: Thu, 19 Jan 2006 01:20:40 +0100
Message-ID: <20060119012040.733335f4.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.207]:1417 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161074AbWASAU7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 19:20:59 -0500
Received: by uproxy.gmail.com with SMTP id s2so27991uge
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2006 16:20:58 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

If I compile CONFIG_ACPI_PROCESSOR in the kernel, one of the two cpus
doesn't get scheduled any process. The CPU works and everything, it
services interrupts and I can force processes to run on that CPU
with taskset, but they won't get scheduled in that CPU no matter
how much processes and load you put on the machine.

However, when I compile it as a module everything works fine. I can't
say when this started happening; I noticed it in the current linus 
git tree from a couple of days ago, but testing 2.6.15-rc7 didn't
help. The machine is a dual P3 machine.

Here's a working dmesg: http://terra.es/personal/diegocg/dmesg-acpi
a dmesg of the machine after setting CONFIG_ACPI_PROCESSOR to y:
http://terra.es/personal/diegocg/dmesg-acpi-no
and a acpidump output: http://terra.es/personal/diegocg/acpidump


