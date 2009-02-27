From: Richard Hughes <hughsient@gmail.com>
Subject: Re: experimental patch for toshiba_acpi
Date: Fri, 27 Feb 2009 16:49:09 +0000
Message-ID: <1235753349.5444.53.camel@localhost.localdomain>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
	 <20090225152409.GA4015@srcf.ucam.org>
	 <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225165152.GA5981@srcf.ucam.org>
	 <a0c408570902260512t702b2575w417ef96dfa74a5bf@mail.gmail.com>
	 <1235657022.3802.86.camel@hughsie-work.lan>
	 <1235663518.4770.197.camel@penguin.lifesci.dundee.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f178.google.com ([209.85.218.178]:54890 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653AbZB0QuE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Feb 2009 11:50:04 -0500
Received: by bwz26 with SMTP id 26so1110516bwz.37
        for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2009 08:50:00 -0800 (PST)
In-Reply-To: <1235663518.4770.197.camel@penguin.lifesci.dundee.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Buzzard <jonathan@buzzard.me.uk>
Cc: John Belmonte <john@neggie.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Charles@schwieters.org, linux-acpi@vger.kernel.org

On Thu, 2009-02-26 at 15:51 +0000, Jonathan Buzzard wrote:
> Now if Toshiba who in part wrote the ACPI specification think this is
> the way to go, and the people who know the most about the HCI in the
> free software world also think this is the way to go, what are your
> qualifications to argue with them, given you have virtually no
> knowledge of the Toshiba HCI and would not appear to even own a
> Toshiba designed and manufactured laptop anyway.

I still own a Satellite Pro A10, model number PSA15E-03U7V-EN. I no
longer use it day-to-day, as it's so very slow compared to my T61.

I know exactly what HCI is, how it works, and have a good idea of what
it can do. I've written patches for the toshiba_acpi driver before for
the key mapping functionality.

In the meantime, you've insulted me enough for one email thread.

Len, I would agree with Matthew that the patch should not be merged, and
that any missing functionality should be added to the existing ACPI
driver.

Richard.


