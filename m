From: Pavel Troller <patrol@sinus.cz>
Subject: Re: "ATA: abnormal status" after wakeup from STR
Date: Tue, 28 Feb 2006 07:11:43 +0100
Message-ID: <20060228061143.GA23692@tangens.sinus.cz>
References: <20060228042336.GA20450@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:37552 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1751848AbWB1GLp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Feb 2006 01:11:45 -0500
Received: from tangens.sinus.cz (patrol@localhost [127.0.0.1])
	by tangens.sinus.cz (8.13.5/8.13.5) with ESMTP id k1S6BhuL023990
	for <linux-acpi@vger.kernel.org>; Tue, 28 Feb 2006 07:11:43 +0100
Received: (from patrol@localhost)
	by tangens.sinus.cz (8.13.5/8.13.5/Submit) id k1S6BhJV023989
	for linux-acpi@vger.kernel.org; Tue, 28 Feb 2006 07:11:43 +0100
Content-Disposition: inline
In-Reply-To: <20060228042336.GA20450@tangens.sinus.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

> Hi!
>   I'm observing a problem on two different motherboards from MSI, one equipped
> with VIA chipset (for Athlon) and the other with Intel (for P-4). The problem,
> however, looks the same.
>   When awaking from STR, at the whole end, there appears:
> Restarting tasks...<4>ATA: abnormal status 0x80 on port 0xE907
> abnormal status 0x80 on port 0xE907
> abnormal status 0x80 on port 0xE907
> done
> ata1: command 0x35 timeout, stat 0x50 hosts_stat 0x1
>   The system then continues to operate with no visible damage.
>   In /proc/ioports I see the IO port assigned to libata. The system uses a SATA
> disk, so it's related.
>   The timeout mentioned in the message is something about 30 seconds. The time
> to wake up from STR is very long due to this.
>   I have the following questions:
>   1) Is it safe to operate the system after such an event ? Is the SATA iface
> in sane state and is it able to work reliably ?
>   2) Is there a known method to fix the problem now ? I've read something about
> SATA patches but didn't experiment with anything yet. Would you recommend me
> to try something ?
>               With regards, Pavel Troller
> 	      
> P.S. I forgot to say, it's on 2.6.15.4.
Hi!
  Replying to myself with new information:
  I've just tried 2.6.16-rc5 and results are much worse - the disk is dead.
  On resume, the following occurs:

ATA: abnormal status 0x80 on port 0xE907
ATA: abnormal status 0x80 on port 0xE907
ATA: abnormal status 0x80 on port 0xE907
ata1: qc timeout (cmd 0xef)
ata1: failed to set xfermode, disabled
ata1: dev 0 configured for UDMA/133
Restarting tasks...<6>sd 0:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, dev sda, sector 6511
sd 0:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, dev sda, sector 6519
sd 0:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, dev sda, sector 6527
Buffer I/O error on device sda1, logical block 808
lost page write due to I/O error on sda1
Aborting journal on device sda1.

With regards, Pavel Troller
