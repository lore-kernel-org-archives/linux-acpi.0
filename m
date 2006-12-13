From: Jacob <fun2program8@yahoo.com>
Subject: Battery sticks at 0% - ACPI's fault or not?
Date: Wed, 13 Dec 2006 08:26:23 -0500
Message-ID: <op.tkh1992m6fluez@jacob-laptop>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp107.plus.mail.re2.yahoo.com ([206.190.53.32]:37458 "HELO
	smtp107.plus.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964956AbWLMNdF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Dec 2006 08:33:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I've made a bug report about this to gnome-power-manager applet, but I  
wonder if it's really ACPI's fault. I decided to check right at the source  
of most excellent support - the mailing lists. :)

So, here's the deal. I've got this Compaq Presario 1720US, with a battery  
that didn't appear to work until recently. (It could've been a self-made  
illusion all along.) Now, however, even when the battery still has 45  
minutes of life left, Gnome's applet reports 0%. The applet does appear to  
be accessing ACPI, because it is telling me everything else about the  
battery but that.

So, here's what ACPI tells me when I ask it:
jacob@jacob-laptop:~$ cat /proc/acpi/battery/CMB0/state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mW
remaining capacity:      2700 mWh
present voltage:         16614 mV
jacob@jacob-laptop:~$ cat /proc/acpi/battery/CMB0/info
present:                 yes
design capacity:         unknown
last full capacity:      unknown
battery technology:      rechargeable
design voltage:          unknown
design capacity warning: 800 mWh
design capacity low:     16 mWh
capacity granularity 1:  100 mWh
capacity granularity 2:  100 mWh
model number:            BAT1
serial number:           0000
battery type:            LION
OEM info:                COMPAQ


When I unplug the AC, it tells me this:
jacob@jacob-laptop:~$ cat /proc/acpi/battery/CMB0/info
present:                 yes
design capacity:         unknown
last full capacity:      unknown
battery technology:      rechargeable
design voltage:          unknown
design capacity warning: 800 mWh
design capacity low:     16 mWh
capacity granularity 1:  100 mWh
capacity granularity 2:  100 mWh
model number:            BAT1
serial number:           0000
battery type:            LION
OEM info:                COMPAQ
jacob@jacob-laptop:~$ cat /proc/acpi/battery/CMB0/state
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            1153 mW
remaining capacity:      2620 mWh
present voltage:         15708 mV


ACPI does do some strange things, like the remaining capacity drops to 0  
mWh when it gets to be around a mere 10 minutes left in battery power,  
causing Gnome to freak out.

So the bottom question is: who's fault is it, and how would I fix this?
