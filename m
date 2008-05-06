From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: acpi_cpu_freq_init warning...
Date: Mon, 5 May 2008 19:51:49 -0700
Message-ID: <86802c440805051951u153ebc21p15f0d73904496217@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:32031 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbYEFCvt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 May 2008 22:51:49 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1451385rvb.1
        for <linux-acpi@vger.kernel.org>; Mon, 05 May 2008 19:51:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

calling  acpi_cpufreq_init+0x0/0x68()
boot acpi=off got

calling  powernowk8_init+0x0/0xfd()
powernow-k8: Found 2 Quad-Core AMD Opteron(tm) Processor 2356
processors (8 cpu cores) (version 2.20.00)
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
initcall powernowk8_init+0x0/0xfd() returned -19 after 49 msecs

calling  acpi_cpufreq_init+0x0/0x68()
sysdev: class cpu: driver (ffffffff80da0110) has already been
registered to a class, something is wrong, but will forge on!
------------[ cut here ]------------
WARNING: at drivers/base/sys.c:183 sysdev_driver_register+0x82/0x150()
Modules linked in:
Pid: 1, comm: swapper Not tainted
2.6.26-rc1-sched-devel.git-x86-latest.git-00485-g253148c-dirty #333

Call Trace:
 [<ffffffff802611c6>] warn_on_slowpath+0x67/0xa2
 [<ffffffff80262582>] ? printk+0xa0/0xc1
 [<ffffffff80504b31>] ? __next_cpu_nr+0x31/0x51
 [<ffffffff80504bc1>] ? __first_cpu+0x21/0x44
 [<ffffffff80562ac8>] ? acpi_processor_preregister_performance+0x51c/0x544
 [<ffffffff8059d0b8>] sysdev_driver_register+0x82/0x150
 [<ffffffff8082de67>] cpufreq_register_driver+0xa8/0x159
 [<ffffffff80e40b3f>] acpi_cpufreq_init+0x52/0x68
 [<ffffffff80e33c38>] kernel_init+0x1ec/0x32c
 [<ffffffff8022a398>] child_rip+0xa/0x12
 [<ffffffff80a15fd3>] ? _etext+0x0/0x1
 [<ffffffff80e33a4c>] ? kernel_init+0x0/0x32c
 [<ffffffff8022a38e>] ? child_rip+0x0/0x12

---[ end trace 42a7898e9c11b2ed ]---
initcall acpi_cpufreq_init+0x0/0x68() returned -19 after 87 msecs


---[ end trace 42a7898e9c11b2ed ]---
