From: Jonathan Buzzard <jonathan@buzzard.me.uk>
Subject: Re: experimental patch for toshiba_acpi
Date: Fri, 27 Feb 2009 17:18:34 +0000
Message-ID: <1235755114.18161.19.camel@penguin.lifesci.dundee.ac.uk>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
	 <20090225152409.GA4015@srcf.ucam.org>
	 <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225165152.GA5981@srcf.ucam.org>
	 <a0c408570902260512t702b2575w417ef96dfa74a5bf@mail.gmail.com>
	 <1235657022.3802.86.camel@hughsie-work.lan>
	 <1235663518.4770.197.camel@penguin.lifesci.dundee.ac.uk>
	 <1235753349.5444.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.lifesci.dundee.ac.uk ([134.36.67.240]:61713 "EHLO
	frigg.compbio.dundee.ac.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754013AbZB0RSp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Feb 2009 12:18:45 -0500
In-Reply-To: <1235753349.5444.53.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: John Belmonte <john@neggie.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Charles@schwieters.org, linux-acpi@vger.kernel.org


On Fri, 2009-02-27 at 16:49 +0000, Richard Hughes wrote:
> On Thu, 2009-02-26 at 15:51 +0000, Jonathan Buzzard wrote:
> > Now if Toshiba who in part wrote the ACPI specification think this is
> > the way to go, and the people who know the most about the HCI in the
> > free software world also think this is the way to go, what are your
> > qualifications to argue with them, given you have virtually no
> > knowledge of the Toshiba HCI and would not appear to even own a
> > Toshiba designed and manufactured laptop anyway.
> 
> I still own a Satellite Pro A10, model number PSA15E-03U7V-EN. I no
> longer use it day-to-day, as it's so very slow compared to my T61.
> 

I am pretty sure that this is not a Toshiba designed and manufactured
laptop, but is one of their Compal OEM jobs with a Phoenix BIOS. The
Toshiba HCI that I am talking about is not relevant on such a laptop.

> I know exactly what HCI is, how it works, and have a good idea of what
> it can do. I've written patches for the toshiba_acpi driver before for
> the key mapping functionality.

Except you don't. By your own admission you thought that you could set
things like the supervisor, and user passwords via the BIOS. I notice
that nobody has suggested a safe way to do this via echoing stuff in a
proc interface...

You also questioned whether it is possible to brick a Toshiba laptop
using the HCI. If you genuinely understood what it did and was capable
of you would not question that. You can do *ANYTHING* purely using the
HCI.

> In the meantime, you've insulted me enough for one email thread.

You have told me what I should be able to do under Linux. You told me
that if I want to change BIOS settings I have to reboot because you
don't think exposing the HCI interface is a good idea. You have told me
that if I want to change the ownerstring I should boot Windows. You have
told me that I want to change the supervisor and user passwords I should
again boot Windows. If you find my response to your dictation of what I
should be able to do insulting look in the mirror.

> Len, I would agree with Matthew that the patch should not be merged, and
> that any missing functionality should be added to the existing ACPI
> driver.

Nobody has at this time suggested a workable alternative. It is also not
possible to add all the functionality to the existing ACPI drive in the
manner in which you suggest. I accept you could add some, but all is not
possible. 

Give that it is not possible to add do what you suggest we need a plan
B. If you cannot come up with a plan B and nobody has then the patch
should go in.


JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan (at) buzzard.me.uk
Fife, United Kingdom.

