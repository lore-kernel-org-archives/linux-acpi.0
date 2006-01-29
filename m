From: Miernik <miernik@ffii.org>
Subject: why no duration[00000000000000000000] for C1 state?
Date: Sun, 29 Jan 2006 11:07:22 +0100
Message-ID: <20060129100722.1359.0.NOFFLE@localhost.localdomain.local>
Reply-To: Miernik <miernik@ffii.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:3254 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750901AbWA2LAh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Jan 2006 06:00:37 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1F3AIO-0004SC-8j
	for linux-acpi@vger.kernel.org; Sun, 29 Jan 2006 12:00:36 +0100
Received: from 217.17.47.111 ([217.17.47.111])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 29 Jan 2006 12:00:36 +0100
Received: from miernik by 217.17.47.111 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 29 Jan 2006 12:00:36 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On
http://ck.kolivas.org/patches/dyn-ticks/split-out/C-States-3_accounting_of_sleep_times.patch
it says: "Also track the actual time spent in C-States (C2 upwards, we
can't determine this for C1), not only the number of invocations." Why
we cannot have time spent in C1? Would it also be possible to have time
spent in C0 and/or total time of the statistics? And/or % of time spent
in each state?

-- 
Miernik             _________________________  xmpp:miernik@amessage.info
___________________/_______________________/      mailto:miernik@ffii.org
                       Save Europe from Software Patents
                http://www.gnu.org/philosophy/savingeurope.html

