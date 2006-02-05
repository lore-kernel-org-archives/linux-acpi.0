From: Arthur Huillet <arthur.huillet@agoctrl.org>
Subject: Question about AthlonXP on nforce 2 : C2-C3 states
Date: Sun, 5 Feb 2006 15:21:20 +0100
Message-ID: <20060205152120.1688bd7b.arthur.huillet@agoctrl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ABesancon-103-1-6-191.w193-252.abo.wanadoo.fr ([193.252.219.191]:60550
	"EHLO Chani.agoctrl.org") by vger.kernel.org with ESMTP
	id S1750820AbWBEOVT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Feb 2006 09:21:19 -0500
Received: from Chani.agoctrl.org (Chani.agoctrl.org [192.168.0.2])
	by Chani.agoctrl.org (Postfix) with SMTP id B224265F9E
	for <linux-acpi@vger.kernel.org>; Sun,  5 Feb 2006 15:21:20 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I've recently discovered that my system didn't seem to go into C2/C3 states. In fact, they're not
even recognized :

# cat /proc/acpi/processor/CPU0/info 
processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no

# cat /proc/acpi/processor/CPU0/power 
active state:            C1
max_cstate:              C8
bus master activity:     00000000
states:
   *C1:                  type[C1] promotion[--] demotion[--] latency[000] usage[00000000]

Would you happen to know why the Cx states are not seen ? Also, isn't there supposed to be bus
mastering control available ? 
My mainboard is a Asus A7N8X rev 1.xx (nforce2).
The kernels I tried with no success in whatever case are 2.4.29 and 2.6.15.2.
Unfortunately, google doesn't seem to know much about this problem...

-- 
Greetings, 
A.H.
