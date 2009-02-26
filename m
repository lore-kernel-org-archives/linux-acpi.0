From: Jonathan Buzzard <jonathan@buzzard.me.uk>
Subject: Re: experimental patch for toshiba_acpi
Date: Thu, 26 Feb 2009 15:51:58 +0000
Message-ID: <1235663518.4770.197.camel@penguin.lifesci.dundee.ac.uk>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
	 <20090225152409.GA4015@srcf.ucam.org>
	 <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225165152.GA5981@srcf.ucam.org>
	 <a0c408570902260512t702b2575w417ef96dfa74a5bf@mail.gmail.com>
	 <1235657022.3802.86.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.lifesci.dundee.ac.uk ([134.36.67.240]:65310 "EHLO
	frigg.compbio.dundee.ac.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753578AbZBZPwN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Feb 2009 10:52:13 -0500
In-Reply-To: <1235657022.3802.86.camel@hughsie-work.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: John Belmonte <john@neggie.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Charles@schwieters.org, linux-acpi@vger.kernel.org


On Thu, 2009-02-26 at 14:03 +0000, Richard Hughes wrote:
> On Thu, 2009-02-26 at 08:12 -0500, John Belmonte wrote:
> > The proposed patch makes /dev/toshiba, and hence toshset, work on more
> > laptops-- it's a no-brainer to anyone with a practical mindset.
> 
> Making toshset work is not a practical goal.

I suggest you get a dictionary out and look up the work practical.
Because making it works is eminently practical.

>  Making hardware "just work"
> without any vendor specific commands is a better goal. Exposing low
> level, device specific, hardware details up through a device node isn't
> a good plan at all.
> 

Well Toshiba who in part wrote the ACPI specification take *EXACTLY* the
same route on Windows. There is a device driver that creates a TVALD
device (the name has changed slightly on newwer models and I cannot
remember it off hand). To change an HCI setting you open up the TVALD
and do a ioctl in *exactly* the same manner as you do on /dev/toshiba.
The similarity is so striking I could almost say Toshiba copied me.

Now if Toshiba who in part wrote the ACPI specification think this is
the way to go, and the people who know the most about the HCI in the
free software world also think this is the way to go, what are your
qualifications to argue with them, given you have virtually no knowledge
of the Toshiba HCI and would not appear to even own a Toshiba designed
and manufactured laptop anyway.


JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan (at) buzzard.me.uk
Fife, United Kingdom.

