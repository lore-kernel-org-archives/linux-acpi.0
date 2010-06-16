From: Jan Pogadl <pogadl.jan@googlemail.com>
Subject: [BUG, REGRESSION] ACPI: Set _PDC
Date: Thu, 17 Jun 2010 00:40:24 +0200
Message-ID: <201006170040.24736.pogadl.jan@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34260 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab0FPWke (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2010 18:40:34 -0400
Received: by fxm10 with SMTP id 10so1184952fxm.19
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2010 15:40:32 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: achiang@hp.com

Hi,

with commit commit 5d554a7bb0643a6151a84319bfeba8270bf5269e (ACPI: processor: 
add internal processor_physically_present()) a new function got introduced which 
always fails on machines with CONFIG_SMP disabled. Thus _PDC will never be 
initialized? set?. 

The problem of the processor_physically_present() is, that it calls the 
acpi_get_cpuid(...) function which returns on NON-SMP machines always -1.

Note that i don't have any real knowledge what _PDC actualy realy do, all i 
gatherd so far is that its for switching C-Stats. I Stumbled across this by 
bisecting the problem, that the undervolting patches from
linux-phc.org aren't working anymore with 2.6.34 (2.6.35-rc3). Whereas they 
worked fine with 2.6.33 on my  Samsung X20 Notebook with a Pentium M precossor. 
The acpi-cpufreq is now using System-IO instead of MSR Registers. 

Since i don't know what should be the correct behaviour here i can't
provide any patches. But i doub't it's the correct behaviour of 
processor_physically_present() to always fail on non-SMP machines. 
 
Deleting the function call, to this new function in early_init_pdc(...), 
and i get back the old behaviour.

cheers,
jan
