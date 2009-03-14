From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: experimental patch for toshiba_acpi
Date: Sat, 14 Mar 2009 10:02:09 +0300
Message-ID: <E1LiNsv-000CIz-00.arvidjaar-mail-ru@mx38.mail.ru>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov> <20090225152409.GA4015@srcf.ucam.org> <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk> <20090225165152.GA5981@srcf.ucam.org> <a0c408570902260512t702b2575w417ef96dfa74a5bf@mail.gmail.com> <1235657022.3802.86.camel@hughsie-work.lan> <1235663518.4770.197.camel@penguin.lifesci.dundee.ac.uk> <1235753349.5444.53.camel@localhost.localdomain> <20090228151933.GC17541@khazad-dum.debian.net> <alpine.LFD.2.00.0903122102490.24376@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx38.mail.ru ([94.100.176.52]:53557 "EHLO mx38.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752328AbZCNHCU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Mar 2009 03:02:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Len Brown wrote:

> 
> BTW. I notice that both toshiba_acpi and toshiba ship in Fedora
> and can load on my satellite pro.  However, fedora doesn't ship
> toshset -- is toshiba and /dev/toshiba useful without it?
> 

Yes,  there are other utils using this interface; e.g. Mandriva ships 
toshutils with

/usr/bin/alarm
/usr/bin/dispswitch
/usr/bin/fan
/usr/bin/hotkey
/usr/bin/ownerstring
/usr/bin/svpw
/usr/bin/tbacklight
/usr/bin/tdocked
/usr/bin/thotswap
/usr/bin/tpasswd


