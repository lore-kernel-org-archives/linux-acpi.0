From: Pavel Troller <patrol@sinus.cz>
Subject: "ATA: abnormal status" after wakeup from STR
Date: Tue, 28 Feb 2006 05:23:36 +0100
Message-ID: <20060228042336.GA20450@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:62348 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1750795AbWB1EXi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Feb 2006 23:23:38 -0500
Received: from tangens.sinus.cz (patrol@localhost [127.0.0.1])
	by tangens.sinus.cz (8.13.5/8.13.5) with ESMTP id k1S4NaSX020869
	for <linux-acpi@vger.kernel.org>; Tue, 28 Feb 2006 05:23:36 +0100
Received: (from patrol@localhost)
	by tangens.sinus.cz (8.13.5/8.13.5/Submit) id k1S4NauA020868
	for linux-acpi@vger.kernel.org; Tue, 28 Feb 2006 05:23:36 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!
  I'm observing a problem on two different motherboards from MSI, one equipped
with VIA chipset (for Athlon) and the other with Intel (for P-4). The problem,
however, looks the same.
  When awaking from STR, at the whole end, there appears:
Restarting tasks...<4>ATA: abnormal status 0x80 on port 0xE907
abnormal status 0x80 on port 0xE907
abnormal status 0x80 on port 0xE907
done
ata1: command 0x35 timeout, stat 0x50 hosts_stat 0x1
  The system then continues to operate with no visible damage.
  In /proc/ioports I see the IO port assigned to libata. The system uses a SATA
disk, so it's related.
  The timeout mentioned in the message is something about 30 seconds. The time
to wake up from STR is very long due to this.
  I have the following questions:
  1) Is it safe to operate the system after such an event ? Is the SATA iface
in sane state and is it able to work reliably ?
  2) Is there a known method to fix the problem now ? I've read something about
SATA patches but didn't experiment with anything yet. Would you recommend me
to try something ?
              With regards, Pavel Troller
	      
P.S. I forgot to say, it's on 2.6.15.4.
