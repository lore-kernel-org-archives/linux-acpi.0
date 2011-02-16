From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: Question on Toshiba Satellite L670
Date: Wed, 16 Feb 2011 17:29:50 +0100
Message-ID: <AANLkTi=7wTTu6AsTTe=NPtayHWshQz9hH+sCnC8ZcVOz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44834 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab1BPQaN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Feb 2011 11:30:13 -0500
Received: by gwj20 with SMTP id 20so673629gwj.19
        for <linux-acpi@vger.kernel.org>; Wed, 16 Feb 2011 08:30:12 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear all,

  I recently bought a new laptop, where I installed a debian system.
However the ACPI output is a bit surprising on this machine:

$ acpi -V
Battery 0: Discharging, 94%, 01:50:55 remaining
Battery 0: design capacity 4500 mAh, last full capacity 4570 mAh = 100%
Adapter 0: off-line
Cooling 0: Processor 0 of 3
Cooling 1: Processor 0 of 3
Cooling 2: Processor 0 of 3
Cooling 3: Processor 0 of 3
Cooling 4: LCD 4 of 7

$ lsmod | grep acpi
acpi_cpufreq            5571  1
processor              29935  5 acpi_cpufreq

Reading some online documentation (*) I should have something like a
toshiba_acpi module loaded, right ?

Is this the right place too ask this kind of question ? If so what
else is needed to investigate what could be wrong on my setup ?

Thanks !
-- 
Mathieu
(*) http://memebeam.org/toys/ToshibaAcpiDriver
