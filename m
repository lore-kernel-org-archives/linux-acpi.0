From: "Stefan Haller" <sh@grep.ch>
Subject: Overheating Problem: Acer 1525WLMi
Date: Mon, 06 Nov 2006 10:19:14 +0100 (CET)
Message-ID: <E1Gh0dO-0003TM-9y@fenris.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aibo.runbox.com ([193.71.199.94]:63700 "EHLO aibo.runbox.com")
	by vger.kernel.org with ESMTP id S1161730AbWKFJTP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Nov 2006 04:19:15 -0500
Received: from [10.9.9.130] (helo=fenris.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1Gh0dO-0002zU-BF
	for linux-acpi@vger.kernel.org; Mon, 06 Nov 2006 10:19:14 +0100
Received: from mail by fenris.runbox.com with local  (Exim 4.50)
	id 1Gh0dO-0003TM-9y
	for linux-acpi@vger.kernel.org; Mon, 06 Nov 2006 10:19:14 +0100
Content-Disposition: inline
Received: from [62.202.214.58] by secure.runbox.com with http (uid:602948)
 (RMM 4.0); for <linux-acpi@vger.kernel.org>; Mon, 06 Nov 2006 09:19:14 GMT
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all

I hope this is the right place to ask this.

I have an overheating problem with my acer 1525WLMi notebook (AMD64) and experience frequent shutdowns due to "critical temperature (80C) reached". Interesstingly, this happens when the temperature of THRC reaches 90C, not 80C. I did not yet experience any such shutdowns under WIndows.

According to BIOS info, I have version 1.11 from Phoenix, which is the latest available from acer for my notebook. Unlike others with this kind of notebook, I had no problems under Windows yet, though I use Windows only for gaming once in a while.

I run Ubuntu Linux 6.10.

Some info:
sh@hermes:/proc/acpi/thermal_zone/THRC$ cat cooling_mode 
cooling mode:   active
sh@hermes:/proc/acpi/thermal_zone/THRC$ cat polling_frequency 
<polling disabled>
sh@hermes:/proc/acpi/thermal_zone/THRC$ cat state 
state:                   ok
sh@hermes:/proc/acpi/thermal_zone/THRC$ cat temperature 
temperature:             52 C
sh@hermes:/proc/acpi/thermal_zone/THRC$ cat trip_points 
critical (S5):           97 C
passive:                 90 C: tc1=2 tc2=5 tsp=300 devices=0xffff81001ff59270 

There is a second thermal zone (THRS) which seems not to be a problem, since THRC temperature increases so fast when under load.

sh@hermes:/proc/acpi$ cat processor/CPU0/info 
processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no

sh@hermes:/proc/acpi$ ls -la fan
total 0
dr-xr-xr-x  2 root root 0 2006-11-06 10:04 .
dr-xr-xr-x 14 root root 0 2006-11-06 09:34 ..

I tried to decrease trip_points with this command:
echo -n "70:0:60:50:0" > /proc/acpi/thermal_zone/THRC/trip_points
resulting in
sh@hermes:/proc/acpi/thermal_zone/THRC$ cat trip_points 
critical (S5):           70 C
passive:                 60 C: tc1=2 tc2=5 tsp=300 devices=0xffff81001ff59270

The new settings had no noticable impact. The platform does not seem to support to many features.

The fan is usually on and gets louder when system is under load, but I have the feeling, under Windows it increases to a higher speed when under load, though I could not say for sure.

When I execute an endless loop program, the temperature THRC increases about 1 degree per 2-3 seconds and the system shuts down immediately after reaching 90C.

The ventilator shaft seems not very dirty to me.

Is there anything I could try out yet? What disturbs me, is that I do not seem to have the same problems in Windows.

Thanks for your advice.

With kind regards
Stefan
