From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: add input device support to hotkey subdriver
Date: Sun, 15 Jul 2007 21:12:02 +0100
Message-ID: <20070715201201.GA5518@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223334107-git-send-email-hmh@hmh.eng.br> <20070714223144.GA25782@srcf.ucam.org> <20070715181233.GG14134@khazad-dum.debian.net> <20070715184519.GD3235@srcf.ucam.org> <20070715200338.GB19066@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:40756 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbXGOUMN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2007 16:12:13 -0400
Content-Disposition: inline
In-Reply-To: <20070715200338.GB19066@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Sun, Jul 15, 2007 at 05:03:38PM -0300, Henrique de Moraes Holschuh wrote:

> I do not consider screwing up the mixer handling a harmless result.

We've shipped in this configuration for over a year. Total number of 
bugs filed? None. It's not ideal, but it's simply not true that it 
results in a high level of user confusion or a screwed up mixer.

(Context for those not aware of it - Thinkpad hardware has two mixers. 
One is associated with the sound codec and is controllable via ALSA. The 
other is Thinkpad-specific and is controlled via the hotkeys. Sending 
KEY_VOLUMEUP and KEY_VOLUMEDOWN results in both of these mixers being 
changed. However, since they're both changed in the same direction, 
nobody seems to be especially unhappy about this)

> Until then, since the default meaning of *all* KEY_ events are active in
> nature, I am against the idea of generating events that are to be handled in
> a passive way, by default.

That's simply not true. Userspace already interprets the brightness keys 
differently depending on the hardware type.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
