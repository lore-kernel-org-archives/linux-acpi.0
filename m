From: "Matthew Brett" <matthew.brett@gmail.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Wed, 10 Jan 2007 01:12:28 +0000
Message-ID: <1e2af89e0701091712h692985eesdf66dba6b3e7daec@mail.gmail.com>
References: <1e2af89e0612280914n62a192e2kdb7e2677b55d2670@mail.gmail.com>
	 <E3C0BCA40296C347AF7142161DB9FC8293DA20@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:17216 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932613AbXAJBM3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jan 2007 20:12:29 -0500
Received: by ug-out-1314.google.com with SMTP id 44so6744190uga
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jan 2007 17:12:28 -0800 (PST)
In-Reply-To: <E3C0BCA40296C347AF7142161DB9FC8293DA20@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi,

> Could you please perform the following testing:

Thanks a lot for the reply.  Results of tests below.  I've included
the output from the 2.6.17 kernel and 2.6.20-rc3 kernel with comments.
 Patched kernel gave identical output to unpatched...  CPU load did
not turn on the fan as before.

Best,

Matthew

2.6.17 kernel, fan on at boot
[root@bob ~]# cat /proc/acpi/thermal/*/*
cat: /proc/acpi/thermal/*/*: No such file or directory
[root@bob ~]# cat /proc/acpi/thermal_zone/*/*
<setting not supported>
cooling mode:   passive
<polling disabled>
state:                   passive
temperature:             -270 C
critical (S5):           -264 C
passive:                 -273 C: tc1=0 tc2=0 tsp=600 devices=0xf7ffd340
active[0]:               -267 C: devices=0xf7ffd5c0
[root@bob ~]# cat /proc/acpi/fan/*/state
status:                  on
[root@bob ~]# echo 3 > /proc/acpi/fan/*/state
-bash: echo: write error: Exec format error
[Fan goes off]
[root@bob ~]# echo 0 > /proc/acpi/fan/*/state
[No effect, fan stays off]
[root@bob ~]#

2.6.20-rc3 kernel, fan off at boot
[root@bob ~]# cat /proc/acpi/thermal/*/*
cat: /proc/acpi/thermal/*/*: No such file or directory
[root@bob ~]# cat /proc/acpi/thermal_zone/*/*
<setting not supported>
cooling mode:   passive
<polling disabled>
state:                   passive active[0]
temperature:             -266 C
critical (S5):           -264 C
passive:                 -273 C: tc1=0 tc2=0 tsp=600 devices=0xc18fd2c0
active[0]:               -267 C: devices=0xc18fd798
[root@bob ~]# cat /proc/acpi/fan/*/state
status:                  on
[root@bob ~]# echo 3 > /proc/acpi/fan/*/state
-bash: echo: write error: Exec format error
[No effect]
[root@bob ~]# echo 0 > /proc/acpi/fan/*/state
[No effect]
