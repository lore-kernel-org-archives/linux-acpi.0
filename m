From: Balazs Ree <ree@ree.hu>
Subject: Fujitsu-Siemens Amilo A1667G: low CPU speed on battery + S3
Date: Sun, 14 May 2006 08:37:03 +0200
Message-ID: <pan.2006.05.14.06.37.03.497588@ree.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:7092 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751326AbWENGuF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 May 2006 02:50:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FfAQU-0006LU-10
	for linux-acpi@vger.kernel.org; Sun, 14 May 2006 08:50:02 +0200
Received: from 3e44b65f.adsl.enternet.hu ([62.68.182.95])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 14 May 2006 08:50:02 +0200
Received: from ree by 3e44b65f.adsl.enternet.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 14 May 2006 08:50:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I've got a Fujitsu-Siemens Amilo A1667G notebook and there are some issues
with it. One of the most important ones is the way CPU speed control works.

It all works perfectly with AC power on. Cpufreq control works right with
both kernel and usespace utilities. Even the "fan" button works: if I
press that, it fixes the frequency to the lowest 800Mhz and releases it
after pressing the button again (although it sometimes looses events and
the led status reverses in this cases.)

However the problem is that when I am on battery, the speed is everytime
fixed to the lowest 800 Mhz. Cpufreq just shows there is no higher
frequency available and it cannot be set higher: just like when in AC mode
I would press the fan button. This is annoying, because the on-demand
frequency setting would be especially important when running on battery
(although it is also useful on ac power, for reducing temperature.) 

Seems to be kernel independent, I currently use 2.6.16.

Another issue is about putting it to sleep (S3). The system goes properly
to sleep but there is no button to wake it up. I can only press the power
button for more seconds to poweroff. The syslog says at initial bootup:

May 14 07:48:35 brumi kernel: ACPI wakeup devices: 
May 14 07:48:35 brumi kernel: MC97  LAN MPC1 

So maybe there are really no wakeup events. I could not experiment a lot
with this, since I have other issues with wakeup (even from S4), due to
the proprietary ATI video driver.

I apologize for not being very practiced in debugging these things.
I don't know what output I should include here. Please write me what
information should I attach in addition, and I will send that in a
followup mail.

Thank you very much in advance,

-- 
Balazs Ree


