From: Olivier Berger <oberger@ouvaton.org>
Subject: Incorrect ACPI blacklisting of ASUS P4B266 ?
Date: Sat, 28 Mar 2009 16:32:49 +0100
Message-ID: <87k5691x3y.fsf@olivierberger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:48722 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbZC1PeQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 11:34:16 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 4F667CAC2AA
	for <linux-acpi@vger.kernel.org>; Sat, 28 Mar 2009 16:34:08 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net

Hi.

There are quite a lot of reports of people having problems managing
poweroff of their ASUS P4B266 based systems.

It seems that providing acpi=force as a boot param is quite succesful.

Maybe that should be fixed WRT to the blacklisting... hence reporting
as advised in the kernel source (arch/x86/kernel/acpi/boot.c).

I unfortunately couldn't identify the reason why such a blacklisting
was setup, as it seems to come from long time ago.

Hope this helps,

Best regards.
-- 
Olivier BERGER 
(OpenPGP: 1024D/B4C5F37F)
http://www.olivierberger.com/weblog/
