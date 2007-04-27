From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: 2.6.21-rc7: known regressions
Date: Sat, 28 Apr 2007 00:38:07 +0200
Message-ID: <6bffcb0e0704271538v435bfd45u7e06a7f5f5e9a8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:4577 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757499AbXD0WiJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Apr 2007 18:38:09 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1288745nzf
        for <linux-acpi@vger.kernel.org>; Fri, 27 Apr 2007 15:38:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Riccardo Ricci <rricci@nuovanetmore.it>, "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, David Brownell <david-b@pacbell.net>, Jeff Mahoney <jeffm@suse.com>, reiserfs-dev@namesys.com

Hi all,

Here is a list of known regressions reported after 2.6.21 release.

=46eel free to add new regressions/remove fixed etc.
http://lkr.wikidot.com/list

Subject : 2.6.21 don't boot, it stops after ACPI: PCI Interrupt Link
[LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15).
References : http://lkml.org/lkml/2007/4/27/400
Submitter : Riccardo Ricci <rricci@nuovanetmore.it>
Status : unknown

Subject : ACPI interpreter errors
References : http://lkml.org/lkml/2007/4/27/206
Submitter : Udo A. Steinberg <us15@os.inf.tu-dresden.de>
Status : unknown

Subject : reiserfs =97 circular locking
References : http://lkml.org/lkml/2007/4/26/648
Submitter : David Brownell <david-b@pacbell.net>
Handled-By : Jeff Mahoney <jeffm@suse.com>
Status : patch available http://lkml.org/lkml/2007/4/27/332

Regards,
Michal

--=20
Michal K. K. Piotrowski
LTG - Linux Testers Group (PL)
(http://www.stardust.webpages.pl/ltg/)
LTG - Linux Testers Group (EN)
(http://www.stardust.webpages.pl/linux_testers_group_en/)
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
