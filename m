From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [1/5] 2.6.22-rc2: known regressions
Date: Sun, 20 May 2007 00:05:47 +0200
Message-ID: <464F74BB.9070402@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:8179 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764704AbXESWGp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 May 2007 18:06:45 -0400
Received: by ug-out-1314.google.com with SMTP id 44so801114uga
        for <linux-acpi@vger.kernel.org>; Sat, 19 May 2007 15:06:45 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Adrian McMenamin <adrian@newgolddream.dyndns.info>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Ray Lee <ray-lk@madrabbit.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, Ben Collins <bcollins@ubuntu.com>, =?ISO-8859-2?Q?Matthias_Bl=E4sing?= <matthias.blaesing@rwth-aachen.de>

Hi all,

Here is a list of some known regressions in 2.6.22-rc2.

=46eel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Unclassified

Subject    : 2.6.22-rc2 prepatch breaks compile on Dreamcast
References : http://lkml.org/lkml/2007/5/19/75
Submitter  : Adrian McMenamin <adrian@newgolddream.dyndns.info>
Status     : Unknown



ACPI

Subject    : acpi hangs on boot
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8504
Submitter  : Matthias Bl=E4sing <matthias.blaesing@rwth-aachen.de>
Status     : Unknown

Subject    : BAT0 no longer seen, ACPI errors
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8493
Submitter  : Ben Collins <bcollins@ubuntu.com>
Status     : Unknown

Subject    : cannot change thermal trip points
References : http://lkml.org/lkml/2007/5/17/139
Submitter  : Maciej Rutecki <maciej.rutecki@gmail.com>
Status     : Unknown

Subject    : nx6125 has lost fan control
References : http://lkml.org/lkml/2007/5/16/249
Submitter  : Ray Lee <ray-lk@madrabbit.org>
Status     : Unknown



Regards,
Michal

--
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
