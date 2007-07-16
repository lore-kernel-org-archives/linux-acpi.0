From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: add input device support to hotkey subdriver
Date: Mon, 16 Jul 2007 19:37:16 +0100
Message-ID: <20070716183716.GA21384@srcf.ucam.org>
References: <20070715181233.GG14134@khazad-dum.debian.net> <20070715184519.GD3235@srcf.ucam.org> <20070715200338.GB19066@khazad-dum.debian.net> <20070715201201.GA5518@srcf.ucam.org> <20070715205934.GF19066@khazad-dum.debian.net> <20070715210405.GA6216@srcf.ucam.org> <20070715215453.GJ19066@khazad-dum.debian.net> <d120d5000707160846m541ddd33uccdb5387ee9ee1c3@mail.gmail.com> <20070716155103.GB19199@srcf.ucam.org> <20070716181911.GA13710@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:56497 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbXGPSh2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jul 2007 14:37:28 -0400
Content-Disposition: inline
In-Reply-To: <20070716181911.GA13710@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, Jul 16, 2007 at 03:19:11PM -0300, Henrique de Moraes Holschuh wrote:

> Anyway, if the input layer is really not the place for "passive key
> presses", then my decision to not issue input events for such stuff is the
> correct one.

That wasn't my interpretation of what Dmitry said - it's not a generic 
event layer, but when you have keys that generate events that would be 
useful to userspace then I think it makes absolute sense to send them.

> Brightness can be notified through ACPI (ACPI 3.0b has standard events for
> this), or it could be done through an improved backlight sysfs class.  It
> will require work either way, because you don't want ACPI video processing
> these synthezised events, or because you need to get backlight to be
> poll()/select() or inotify()-friendly if you don't want to add another
> dumbass userspace polling loop.

The simple fact of the matter is that when you get outside the range of 
the standard qwerty keys, the semantics of the buttons become hardware 
dependent. The behaviour of KEY_SWITCHVIDEOMODE is going to vary wildly 
between hardware. Wlan control may be active or passive (and the 
standard adopted there appears to be to send KEY_WLAN regardless). Dells 
will trigger a dock unplug event automatically if you hit the dock 
unplug button - Thinkpads won't.

I think it makes absolute sense to get these notifications in the same 
way wherever possible, and then let userspace handle them as 
appropriate. On modern Thinkpads I need to alter whichever backlight 
interface is most appropriate to the machine in question (something that 
itself is going to differ between Thinkpads and, say, Macs) whereas in 
older ones I just want to pop up a notification with the new brightness. 

I realise your concern about breaking existing userspace, but as far as 
I can tell there /is/ no existing userspace to break. Hal does the right 
thing already, and there's nothing else that listens for key brightness 
events on Thinkpads.

> Built-in headphone/speaker volume can be notified and controlled through an
> ALSA mixer.  It won't be a nice poll-less thing, but I can trap the ACPI hot
> key events as a hint to update the mixer state, and if ALSA lets me do it,
> issue mixer changed notifications.

ALSA lets you do that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
