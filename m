From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: experimental patch for toshiba_acpi
Date: Sat, 14 Mar 2009 12:05:40 +0000
Message-ID: <20090314120540.GA16151@srcf.ucam.org>
References: <20090225152409.GA4015@srcf.ucam.org> <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk> <20090225165152.GA5981@srcf.ucam.org> <a0c408570902260512t702b2575w417ef96dfa74a5bf@mail.gmail.com> <1235657022.3802.86.camel@hughsie-work.lan> <1235663518.4770.197.camel@penguin.lifesci.dundee.ac.uk> <1235753349.5444.53.camel@localhost.localdomain> <20090228151933.GC17541@khazad-dum.debian.net> <alpine.LFD.2.00.0903122102490.24376@localhost.localdomain> <E1LiNsv-000CIz-00.arvidjaar-mail-ru@mx38.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39081 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbZCNMFr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Mar 2009 08:05:47 -0400
Content-Disposition: inline
In-Reply-To: <E1LiNsv-000CIz-00.arvidjaar-mail-ru@mx38.mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sat, Mar 14, 2009 at 10:02:09AM +0300, Andrey Borzenkov wrote:

> /usr/bin/alarm

Should be hooked into the rtc interface, but I'd be surprised if it 
doesn't just work with the existing alarm infrastructure.

> /usr/bin/dispswitch

Should be hooked into the video output class.

> /usr/bin/fan

Should be an hwmon or thermal device.

> /usr/bin/hotkey

Unneeded now.

> /usr/bin/tbacklight

There's already a backlight class device.

> /usr/bin/tdocked

Should be a platform device emitting dock events.

> /usr/bin/thotswap

Should already be unnecessary on any ACPI system - impossible to make 
work properly without being in the kernel.

> /usr/bin/ownerstring
> /usr/bin/svpw
> /usr/bin/tpasswd

These are the ones of interest.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
