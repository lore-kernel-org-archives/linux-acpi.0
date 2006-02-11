From: Iacopo Spalletti <liste@spalletti.it>
Subject: S3 suspend regression in 2.6.16-rc2 and higher
Date: Sat, 11 Feb 2006 10:33:48 +0100
Message-ID: <200602111033.49037.liste@spalletti.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [62.48.34.169] ([62.48.34.169]:45524 "EHLO ercolino.iast.it")
	by vger.kernel.org with ESMTP id S1751314AbWBKJeB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Feb 2006 04:34:01 -0500
Received: from localhost (ercolino [127.0.0.1])
	by ercolino.iast.it (Mail Daemon) with ESMTP id 7D1D635F7B
	for <linux-acpi@vger.kernel.org>; Sat, 11 Feb 2006 10:33:41 +0100 (CET)
Received: from ercolino.iast.it ([127.0.0.1])
	by localhost (ercolino [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03875-03 for <linux-acpi@vger.kernel.org>;
	Sat, 11 Feb 2006 10:33:41 +0100 (CET)
Received: from [192.168.1.90] (host69-38.pool8833.interbusiness.it [88.33.38.69])
	(using TLSv1 with cipher EXP1024-RC4-SHA (56/128 bits))
	(No client certificate requested)
	by ercolino.iast.it (Mail Daemon) with ESMTP id 5228D33E35
	for <linux-acpi@vger.kernel.org>; Sat, 11 Feb 2006 10:33:41 +0100 (CET)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

Starting from 2.6.16-rc2  my laptop (Asus V6V, Centrino and Radeon X600 ) 
freezes on resuming from s3 if an X session was open before suspend.
The only way to successfully suspend and resume is to switch to console, 
suspend, resume, kill any X session and restart X.
Note: i don't use fglrx drivers.
This is the script i use to suspend (if i boot with a pre-2.6.16-rc2 kernel 
suspend and resuming with this script works regardless of X sessions)

###Start S3 Suspend/Resume Script ###
 statedir=/var/lib/vbetool/vbestate
 mkdir -p $statedir
 hwclock --systohc
 hwclock > /root/hw.p
 chvt 2
 sleep 1
 vbetool vbestate save >$statedir/vbe
 cat /dev/vcsa >$statedir/vcsa
 sync
 echo mem >/sys/power/state
 sync
 vbetool post
 vbetool vbestate restore <$statedir/vbe
 cat $statedir/vcsa >/dev/vcsa
 hwclock --hctosys
 hwclock > /root/hw.d
 /etc/init.d/console-screen.sh restart
###End###

--

IS
Iacopo Spalletti

PGP key block: http://www.spalletti.it/pgp
