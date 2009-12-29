From: tytso@mit.edu
Subject: Re: [PATCH 5/5] thinkpad-acpi: improve Kconfig help text
Date: Tue, 29 Dec 2009 09:21:32 -0500
Message-ID: <20091229142132.GE4429@thunk.org>
References: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
 <1261875137-27565-6-git-send-email-hmh@hmh.eng.br>
 <20091228133006.GD4429@thunk.org>
 <20091228133522.GD19362@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from THUNK.ORG ([69.25.196.29]:60049 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbZL2OVk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2009 09:21:40 -0500
Content-Disposition: inline
In-Reply-To: <20091228133522.GD19362@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Mon, Dec 28, 2009 at 11:35:22AM -0200, Henrique de Moraes Holschuh wrote:
> On Mon, 28 Dec 2009, tytso@mit.edu wrote:
> > By the way, just as a point of information, Ubuntu Karmic seems to
> > have some kind of bug with their sound system (I suspect their
> > Pulseaudio integration) which cases sound to be completely
> > non-functional if ALSA is built in.  I had to build ALSA as modules in
> > order for Ubuntu to work correctly.
> 
> Maybe they are depending on module parameters for it to work, and adding
> those automagically behind your back in the modprobe.d config stuff but
> ignoring the kernel command line?

For a T400?  I don't think so.  #1, the only thing in /etc/modprobe.d
is:

options snd-hda-intel power_save=10 power_save_controller=N

#2, building sound into the kernel worked fine with Ubuntu Jaunty; the
exact same kernel broke when I upgraded the userspace to Ubuntu
Karmic.

						- Ted
