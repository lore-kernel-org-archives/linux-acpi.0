From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: experimental patch for toshiba_acpi
Date: Thu, 26 Feb 2009 16:01:06 +0000
Message-ID: <20090226160106.GA27049@srcf.ucam.org>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov> <20090225152409.GA4015@srcf.ucam.org> <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk> <20090225165152.GA5981@srcf.ucam.org> <a0c408570902260512t702b2575w417ef96dfa74a5bf@mail.gmail.com> <1235657022.3802.86.camel@hughsie-work.lan> <1235663518.4770.197.camel@penguin.lifesci.dundee.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48555 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756936AbZBZQBQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Feb 2009 11:01:16 -0500
Content-Disposition: inline
In-Reply-To: <1235663518.4770.197.camel@penguin.lifesci.dundee.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Buzzard <jonathan@buzzard.me.uk>
Cc: Richard Hughes <hughsient@gmail.com>, John Belmonte <john@neggie.net>, Charles@schwieters.org, linux-acpi@vger.kernel.org

On Thu, Feb 26, 2009 at 03:51:58PM +0000, Jonathan Buzzard wrote:

> Well Toshiba who in part wrote the ACPI specification take *EXACTLY* the
> same route on Windows. There is a device driver that creates a TVALD
> device (the name has changed slightly on newwer models and I cannot
> remember it off hand). To change an HCI setting you open up the TVALD
> and do a ioctl in *exactly* the same manner as you do on /dev/toshiba.
> The similarity is so striking I could almost say Toshiba copied me.

And Dell provided us with a set of userspace drivers to use their smbios 
functionality and still encouraged me to move large chunks of them to a 
kernel driver.

> Now if Toshiba who in part wrote the ACPI specification think this is
> the way to go, and the people who know the most about the HCI in the
> free software world also think this is the way to go, what are your
> qualifications to argue with them, given you have virtually no knowledge
> of the Toshiba HCI and would not appear to even own a Toshiba designed
> and manufactured laptop anyway.

You're really not selling yourself here.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
