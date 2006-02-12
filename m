From: Bob McKay <urilabob@gmail.com>
Subject: ASUS P5WD2-E motherboard and ACPI in Fedora Core 4
Date: Sun, 12 Feb 2006 17:09:02 +0900
Message-ID: <21b1bb250602120009n4fe85ac7he78b6675ab47c42b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.202]:47645 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932325AbWBLIJD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Feb 2006 03:09:03 -0500
Received: by uproxy.gmail.com with SMTP id m2so359698ugc
        for <linux-acpi@vger.kernel.org>; Sun, 12 Feb 2006 00:09:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I recently installed FC4 ('install everything' option) on system based
on ASUS P5WD2E motherboard running P4 3.0G cpu. The install appeared
to be OK. When booted, the ethernet ports fail to be detected (in
particular, system-config-network shows no ethernet ports). The only
obvious error in /var/log/messages reports an AE_BAD_HEADER from
ACPI-1138 in the sequence following 'Initializing IPSec netlink
socket', so I'm assuming this is an ACPI problem. I haven't been able
to find anything in the acpi or asus mailing lists about this (most of
the comments about acpi seem to relate to asus laptops rather than to
desktop motherboards).

I'd really appreciate suggestions as to what to do. One option, of
course, is to turn acpi off. I assume I'm not going to fry anything on
a desktop with loads of cooling by doing this? (I'm not doing any
overclocking or anything fancy).

Since I'm running the FC4 current kernel (2.6.11) rather than the
latest kernel (and not confident to go upgrading the kernel), I've
reported it to bugzilla.redhat.com (bug 180901) and to asus, rather
than to the acpi bugzilla, but I thought I should mention it here as a
problem, because doubtless others are going to hit the same problem,
both in fedora and other distros
   Best WIshes
   Bob
