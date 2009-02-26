From: Richard Hughes <hughsient@gmail.com>
Subject: Re: experimental patch for toshiba_acpi
Date: Thu, 26 Feb 2009 14:03:42 +0000
Message-ID: <1235657022.3802.86.camel@hughsie-work.lan>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
	 <20090225152409.GA4015@srcf.ucam.org>
	 <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225165152.GA5981@srcf.ucam.org>
	 <a0c408570902260512t702b2575w417ef96dfa74a5bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:43975 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbZBZOEk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Feb 2009 09:04:40 -0500
Received: by an-out-0708.google.com with SMTP id c2so440008anc.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2009 06:04:37 -0800 (PST)
In-Reply-To: <a0c408570902260512t702b2575w417ef96dfa74a5bf@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Belmonte <john@neggie.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Buzzard <jonathan@buzzard.me.uk>, Charles@schwieters.org, linux-acpi@vger.kernel.org

On Thu, 2009-02-26 at 08:12 -0500, John Belmonte wrote:
> The proposed patch makes /dev/toshiba, and hence toshset, work on more
> laptops-- it's a no-brainer to anyone with a practical mindset.

Making toshset work is not a practical goal. Making hardware "just work"
without any vendor specific commands is a better goal. Exposing low
level, device specific, hardware details up through a device node isn't
a good plan at all.

Richard.


