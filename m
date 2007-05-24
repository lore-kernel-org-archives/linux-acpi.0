From: Thomas Renninger <trenn@suse.de>
Subject: Re: HP Compaq nc6320 Suspend / Resume (changes in behaviour)
Date: Thu, 24 May 2007 20:51:39 +0200
Message-ID: <1180032699.16396.161.camel@queen.suse.de>
References: <1179859741.27532.8.camel@localhost>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:42548 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbXEXSvl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 May 2007 14:51:41 -0400
In-Reply-To: <1179859741.27532.8.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: linux-acpi@vger.kernel.org

On Tue, 2007-05-22 at 19:49 +0100, Peter Clifton wrote:
> Hi,
> 
> I just updated my bios to HP's latest, and have recently been upgraded
> to Ubuntu Gutsy kernel version:
> 
> Linux version 2.6.22-1-generic (buildd@palmer) (gcc version 4.1.3
> 20070423 (prerelease) (Ubuntu 4.1.2-3ubuntu3)) #1 SMP Mon Apr 30
> 10:49:22 GMT 2007
> 
> For the first time ever, suspend to ram works!
> 
> Unfortunately, hibernation has broken. This happened somewhere between
> Feisty's 2.6.20 kernel and the one I'm using now. (Although it could
> have been an update released in Feisty which broke things).
> 
> I can hibernate, but after a short while being booted back up (and
> perhaps accessing some ACPI related thing, e.g. cpu scaling, unplugging
> AC etc.. it will crash (and due to being in X11 at the time, I've got no
> useful debug output to go on).
> 
> Does anyone know specifically if something changed to fix suspend, (with
> SATA drives no less!), or anything which may have broken hibernate.
> (Which was broken before I updated from bios F.06 to the latest today)
> 
> After resume from suspend, I see:
> 
> dmesg  | grep ACPI | grep Error
> [ 4763.428000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C241] (Node df94c9dc), AE_AML_PACKAGE_LIMIT
> [ 4763.428000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C002.C0DC.C349._STM] (Node df94fba8), AE_AML_PACKAGE_LIMIT
> [ 6417.528000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C241] (Node df94c9dc), AE_AML_PACKAGE_LIMIT
> [ 6417.528000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C002.C0DC.C349._STM] (Node df94fba8), AE_AML_PACKAGE_LIMIT
> 
> Is this anything to worry about - should I post a dsdt for the new bios?

STR works (also the disk(s)?)?

This is strange, bug:
http://bugzilla.kernel.org/show_bug.cgi?id=8456
is about broken SATA disks after STR.

If you think this is related to bug #8456, you might want to add
yourself there or open a new bug if you think it's not.

You might want to add htejun@gmail.com (Tejun Heo), who did the latest
ACPI SATA changes. Best you also add acpidump output and also CC me,
pls.

   Thomas


