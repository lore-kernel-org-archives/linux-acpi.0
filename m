From: M P <m.paniez@zoho.com>
Subject: Tr : Bug with acpi to boot
Date: Wed, 08 Jun 2016 15:20:17 +0200
Message-ID: <155302b95ae.c55ce71746161.6684118391733533681@zoho.com>
References: <1552ffa468f.121d7e5a345699.5097958136133155323@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sender153-mail.zoho.com ([74.201.84.153]:21912 "EHLO
	sender153-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbcFHNUU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jun 2016 09:20:20 -0400
In-Reply-To: <1552ffa468f.121d7e5a345699.5097958136133155323@zoho.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

Hi,

I post a bug to Launchpad and we ask me to report to you (sorry if it doesn't respect exactly your process, it's my first).



[1.] One line summary of the problem:
"acpi=off" required to boot.


[2.] Full description of the problem/report:
Hi,
I just install Ubuntu 16.04 on my new MSI laptop G72 6QE.
My touchpad doesn't work and recognize at all.
Furthermore "acpi=off" required to boot.

After tests with Christopher M. Penalver (penalvch), my touchpad problem comes from ACPI but I need disable it to boot.
I try with kernel 4.6 and 4.7-rc2. With kernel 4.7-rc2, I can't go to login page because the start freezes (gnome-shell) ; so I need use 4.6 to work.

My bug report on launchpad :
Launchpad link : https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1584479/comments/31


[3.] Keywords


[4.] Kernel version (from /proc/version):
Linux version 4.7.0-040700rc2-generic (kernel@tangerine) (gcc version 5.3.1 20160528 (Ubuntu 5.3.1-21ubuntu11) ) #201606051831 SMP Sun Jun 5 22:33:44 UTC 2016


[5.] Output of Oops.. message
cf. syslog : https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1584479/+attachment/4679536/+files/syslog_20160608.log


[6.] A small shell script or example program which triggers the problem (if possible)



Thanks

-- 
Cordialement, Best regards,

Mr Matthieu PANIEZ














