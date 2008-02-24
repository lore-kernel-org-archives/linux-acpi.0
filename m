From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Fwd: Re: 2.6.25-current-git hangs on boot
Date: Sun, 24 Feb 2008 14:26:37 +0100
Message-ID: <200802241426.38188.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OCXwHbQxjMWXKk5"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52706 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbYBXN2R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Feb 2008 08:28:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Soeren Sonnenburg <kernel@nn7.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

--Boundary-00=_OCXwHbQxjMWXKk5
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Venki, Len,

FYI, another configuration in which CONFIG_CPU_IDLE causes problems.

Thanks,
Rafael

--Boundary-00=_OCXwHbQxjMWXKk5
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: Soeren Sonnenburg <kernel@nn7.de>: Re: 2.6.25-current-git hangs on boot
Content-Disposition: inline

Return-Path: <kernel@nn7.de>
Received: from murder ([unix socket])
	 by ogre.sisk.pl (Cyrus v2.2.12) with LMTPA;
	 Sun, 24 Feb 2008 12:59:00 +0100
X-Sieve: CMU Sieve 2.2
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ogre.sisk.pl (Postfix) with ESMTP id 00E7D8FA22
	for <rafael@ogre.sisk.pl>; Sun, 24 Feb 2008 12:59:00 +0100 (CET)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00812-01 for <rafael@ogre.sisk.pl>; Sun, 24 Feb 2008 12:58:44 +0100 (CET)
Received: from nn7.de (nn7.de [85.214.94.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ogre.sisk.pl (Postfix) with ESMTP id 087588FD8F
	for <rjw@sisk.pl>; Sun, 24 Feb 2008 12:58:44 +0100 (CET)
Received: (qmail 11926 invoked from network); 24 Feb 2008 13:27:57 +0100
Received: from unknown (HELO no.nn7.de) (85.178.177.95)
  by nn7.de with (DHE-RSA-AES256-SHA encrypted) SMTP
  (cert sonne@nn7.de); 24 Feb 2008 13:27:57 +0100
Received: (nullmailer pid 6104 invoked by uid 1000);
	Sun, 24 Feb 2008 12:27:57 -0000
Subject: Re: 2.6.25-current-git hangs on boot
From: Soeren Sonnenburg <kernel@nn7.de>
To: "Rafael J\. Wysocki" <rjw@sisk.pl>
Cc: Oliver Pinter <oliver.pntr@gmail.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Venki Pallipadi <venkatesh.pallipadi@intel.com>
In-Reply-To: <200802241218.04617.rjw@sisk.pl>
References: <1203789325.4063.9.camel@localhost>
	 <6101e8c40802231100t3af57018r139de0b52cd556b5@mail.gmail.com>
	 <1203833710.4006.3.camel@localhost>  <200802241218.04617.rjw@sisk.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 24 Feb 2008 13:27:56 +0100
Message-Id: <1203856077.4356.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.3 
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
X-Length: 2590
X-UID: 564686

On Sun, 2008-02-24 at 12:18 +0100, Rafael J. Wysocki wrote:
> On Sunday, 24 of February 2008, Soeren Sonnenburg wrote:
> > On Sat, 2008-02-23 at 20:00 +0100, Oliver Pinter wrote:
> > > the pci=nommconf kernel parameter helped it?
> > 
> > yes indeed, this switch reliably helps to over come the hang at *this
> > stage* (I tried booting with booth the switch and w/o).
> > 
> > however with 50% chance I still see a hang directly after
> > 
> > cpuidle: using governor ladder
> 
> Do you have CONFIG_CPU_IDLE set?  If you have, please try to unset it and
> retest.

Yes I had. When disabling that option booting 10 times in a row worked
without problems.

Soeren


--Boundary-00=_OCXwHbQxjMWXKk5--
