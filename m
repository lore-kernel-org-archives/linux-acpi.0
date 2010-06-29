From: Raz <raziebe@gmail.com>
Subject: CRASH: core dump while bringing a processor online
Date: Tue, 29 Jun 2010 18:17:35 +0300
Message-ID: <AANLkTinvV6hRsIUDXNwF9gti6WgqYCUSZVwmmfBYoAoZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56734 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756484Ab0F2PR4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2010 11:17:56 -0400
Received: by fxm14 with SMTP id 14so1463056fxm.19
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jun 2010 08:17:55 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

Len Hello

My program offline a processor and uses it as some sort of an engine (
aka offline scheduler, if you recall).
It seems that it is possible to hung the kernel when a huge core dump
(40G) is been dumped while brining
a processor online at the same time.
I debugged the cpu_up code a bit and it seems that it hangs possibly
around the bellow code.

wakeup_secondary_via_INIT()
....
      for (j = 1; j <= num_starts; j++) {
                Dprintk("Sending STARTUP #%d.\n",j);
                apic_write(APIC_ESR, 0);
                apic_read(APIC_ESR);
                Dprintk("After apic_write.\n");
....

I am using redhat kernels. 2.6.18-164 ( redhat 5.4 ) or 2.6.18-8.el5 (
reddhat 5.0 ).
happens in both kernels.

Is this a known issue ? Is there a patch somewhere ? if so, what is
the problem ?

thank you
raz
