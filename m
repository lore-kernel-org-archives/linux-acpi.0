From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Linux 2.6.16-rc3
Date: Mon, 13 Feb 2006 01:59:15 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1CF@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr15.intel.com ([192.55.52.69]:30095 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751080AbWBMHBs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2006 02:01:48 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>, James Bottomley <James.Bottomley@steeleye.com>, "David S. Miller" <davem@davemloft.net>, Greg KH <greg@kroah.com>, linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net, "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>, sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>, "Carlo E. Prelz" <fluido@fluido.as>linux-usb-devel@lists.sourceforge.net, =?iso-8859-1?Q?Gerrit_Bruchh=E4user?= <gbruchhaeuser@gmx.de>, Nicolas.Mailhot@LaPoste.net, Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, Patrizio Bassi <patrizio.bassi@gmail.com>, =?iso-8859-1?Q?Bj=F6rn_Nilsson?= <bni.swe@gmail.com>, Andrey Borzenkov <arvidjaar@mail.ru>, "P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>, jinhong hu <jinhong.hu@gmail.com>, Andrew

 
>- http://bugzilla.kernel.org/show_bug.cgi?id=6049 - another acpi
>  regression.  We have the actual offending commit here.

per my note in the bug report, I believe that this failure
is not related to the "offending commit", and thus that commit
should not be reverted.  I believe that this failure is because
the system is booted with "pci=noacpi" in IOAPIC mode --
and unsuportable configuration -- and will endeavor to confirm...

thanks,
-Len
