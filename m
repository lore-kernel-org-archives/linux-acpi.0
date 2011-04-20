From: Tarcisio Praciano-Pereira <tarcisio@member.ams.org>
Subject: send the above DMI info to kernel.org - sending
Date: Wed, 20 Apr 2011 19:11:27 -0300
Message-ID: <20110420221127.GA3243@cap01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52033 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1DTWLl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Apr 2011 18:11:41 -0400
Received: by ywj3 with SMTP id 3so340042ywj.19
        for <linux-acpi@vger.kernel.org>; Wed, 20 Apr 2011 15:11:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


As you have asked.
Well I read this because I had a hang up, so I have also send the lines at
the end of hanging point to you in the hope to know perhaps the reason why
this machine hang up, if possible.


Tarcisio
Linux user number 370344
FSF member  # 6657

Apr 20 18:30:08 cap01 kernel: [    0.236014] Brought up 2 CPUs
Apr 20 18:30:08 cap01 kernel: [    0.236014] Total of 2 processors activated (12007.21 BogoMIPS).
Apr 20 18:30:08 cap01 kernel: [    0.236014] net_namespace: 660 bytes
Apr 20 18:30:08 cap01 kernel: [    0.236014] Booting paravirtualized kernel on bare hardware
Apr 20 18:30:08 cap01 kernel: [    0.236014] NET: Registered protocol family 16
Apr 20 18:30:08 cap01 kernel: [    0.236014] ACPI: bus type pci registered
Apr 20 18:30:08 cap01 kernel: [    0.236014] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
Apr 20 18:30:08 cap01 kernel: [    0.255214] PCI: Using configuration type 1 for base access
Apr 20 18:30:08 cap01 kernel: [    0.255222] Setting up standard PCI resources
Apr 20 18:30:08 cap01 kernel: [    0.265591] ACPI: BIOS _OSI(Linux) query ignored
Apr 20 18:30:08 cap01 kernel: [    0.265593] ACPI: DMI System Vendor:         
Apr 20 18:30:08 cap01 kernel: [    0.265594] ACPI: DMI Product Name:         
Apr 20 18:30:08 cap01 kernel: [    0.265595] ACPI: DMI Product Version:         
Apr 20 18:30:08 cap01 kernel: [    0.265596] ACPI: DMI Board Name: DG41RQ
Apr 20 18:30:08 cap01 kernel: [    0.265597] ACPI: DMI BIOS Vendor: Intel Corp.
Apr 20 18:30:08 cap01 kernel: [    0.265598] ACPI: DMI BIOS Date: 12/23/2009
Apr 20 18:30:08 cap01 kernel: [    0.265598] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
Apr 20 18:30:08 cap01 kernel: [    0.265600] ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kerne
l.org
======================== 
what may have happened here?  desktop hanged up?

Apr 20 18:30:08 cap01 kernel: [    9.425794] EXT3 FS on sda11, internal journal
Apr 20 18:30:08 cap01 kernel: [    9.425799] EXT3-fs: mounted filesystem with ordered data mode.
Apr 20 18:30:08 cap01 kernel: [    9.456159] kjournald starting.  Commit interval 5 seconds
Apr 20 18:30:08 cap01 kernel: [    9.456566] EXT3 FS on sda3, internal journal
Apr 20 18:30:08 cap01 kernel: [    9.456566] EXT3-fs: mounted filesystem with ordered data mode.
Apr 20 18:30:08 cap01 kernel: [    9.476063] kjournald starting.  Commit interval 5 seconds
Apr 20 18:30:08 cap01 kernel: [    9.477426] EXT3 FS on sda8, internal journal
Apr 20 18:30:08 cap01 kernel: [    9.477426] EXT3-fs: mounted filesystem with ordered data mode.
Apr 20 18:30:08 cap01 kernel: [    9.483211] kjournald starting.  Commit interval 5 seconds
Apr 20 18:30:08 cap01 kernel: [    9.488063] EXT3 FS on sda7, internal journal
Apr 20 18:30:08 cap01 kernel: [    9.488063] EXT3-fs: mounted filesystem with ordered data mode.
Apr 20 18:30:08 cap01 rsyslogd: [origin software="rsyslogd" swVersion="3.18.6" x-pid="2230" x-info="http://www.rsyslog.c
om"] restart
Apr 20 18:30:09 cap01 kernel: [   15.131754] NET: Registered protocol family 10
Apr 20 18:30:09 cap01 kernel: [   15.131754] lo: Disabled Privacy Extensions


Apr 20 18:30:10 cap01 kernel: [   15.995677] lp0: using parport0 (interrupt-driven).
Apr 20 18:30:10 cap01 kernel: [   16.027676] ppdev: user-space parallel port driver
----------------------------------  ???????  -----------------------------
Apr 20 18:43:25 cap01 kernel: imklog 3.18.6, log source = /proc/kmsg started.
Apr 20 18:43:25 cap01 kernel: [    0.000000] Initializing cgroup subsys cpuset
Apr 20 18:43:25 cap01 kernel: [    0.000000] Initializing cgroup subsys cpu
Apr 20 18:43:25 cap01 kernel: [    0.000000] Linux version 2.6.26-2-686 (Debian 2.6.26-26lenny2) (dannf@debian.org) (gcc
 version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 SMP Thu Jan 27 00:28:05 UTC 2011




