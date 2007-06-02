From: Tobias Neumann <tobias.neumann@gmail.com>
Subject: cpufreq support still broken on some laptops
Date: Sat, 2 Jun 2007 13:35:16 +0200
Message-ID: <A2B2EBD3-64AE-457A-92C3-4E0462A35E2B@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:18124 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbXFBLfj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Jun 2007 07:35:39 -0400
Received: by ug-out-1314.google.com with SMTP id j3so397210ugf
        for <linux-acpi@vger.kernel.org>; Sat, 02 Jun 2007 04:35:37 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
on my Thinkpad T60 (2007-FUG), with kernel 2.6.21.1 I have the same  
problem Ingo Molnar had in January and successfully fixed for his model:
http://git.kernel.org/?p=linux/kernel/git/torvalds/ 
linux-2.6.git;a=commit;h=e4233dec749a3519069d9390561b5636a75c7579

"Recently cpufreq support on my laptop (Lenovo T60) broke completely:  
when
it's plugged into AC it would never go higher than 1 GHz - neither  
1.3 GHz
nor 1.83 GHz is possible - no matter which governor (userspace, speed or
ondemand) is used."

2.6.21 and 2.6.20 include this patch and should not have this problem  
anymore.

Is there any way I can see when ACPI calls for _PPC happen (via  
ACPI_DEBUG) and which _PPC values get returned? Which debug_level do  
I need?

Here are some more people with the same problem on 2.6.20 and 2.6.21 
(which includes that patch too):
https://bugs.beta.launchpad.net/ubuntu/+source/linux-source-2.6.20/ 
+bug/88899

Thanks,
   Tobias
