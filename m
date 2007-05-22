From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: HP Compaq nc6320 Suspend / Resume (changes in behaviour)
Date: Tue, 22 May 2007 19:49:01 +0100
Message-ID: <1179859741.27532.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:60312 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756952AbXEVSUQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 May 2007 14:20:16 -0400
Received: from epec1135.eng.cam.ac.uk ([129.169.173.33]:41664)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:465)
	with esmtpsa (LOGIN:pcjc2) (SSLv3:RC4-MD5:128)
	id 1HqYTk-0004Yz-TA (Exim 4.63) for linux-acpi@vger.kernel.org
	(return-path <pcjc2@cam.ac.uk>); Tue, 22 May 2007 18:49:00 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I just updated my bios to HP's latest, and have recently been upgraded
to Ubuntu Gutsy kernel version:

Linux version 2.6.22-1-generic (buildd@palmer) (gcc version 4.1.3
20070423 (prerelease) (Ubuntu 4.1.2-3ubuntu3)) #1 SMP Mon Apr 30
10:49:22 GMT 2007

For the first time ever, suspend to ram works!

Unfortunately, hibernation has broken. This happened somewhere between
Feisty's 2.6.20 kernel and the one I'm using now. (Although it could
have been an update released in Feisty which broke things).

I can hibernate, but after a short while being booted back up (and
perhaps accessing some ACPI related thing, e.g. cpu scaling, unplugging
AC etc.. it will crash (and due to being in X11 at the time, I've got no
useful debug output to go on).

Does anyone know specifically if something changed to fix suspend, (with
SATA drives no less!), or anything which may have broken hibernate.
(Which was broken before I updated from bios F.06 to the latest today)

After resume from suspend, I see:

dmesg  | grep ACPI | grep Error
[ 4763.428000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C241] (Node df94c9dc), AE_AML_PACKAGE_LIMIT
[ 4763.428000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C002.C0DC.C349._STM] (Node df94fba8), AE_AML_PACKAGE_LIMIT
[ 6417.528000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C241] (Node df94c9dc), AE_AML_PACKAGE_LIMIT
[ 6417.528000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C002.C0DC.C349._STM] (Node df94fba8), AE_AML_PACKAGE_LIMIT

Is this anything to worry about - should I post a dsdt for the new bios?

Kind regards,

-- 
Peter Clifton

Electrical Engineering Division,
Engineering Department,
University of Cambridge,
9, JJ Thomson Avenue,
Cambridge
CB3 0FA

Tel: +44 (0)7729 980173 - (No signal in the lab!)

