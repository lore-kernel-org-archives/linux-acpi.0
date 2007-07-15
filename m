From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: ACPI: thinkpad-acpi: add input device support
	to hotkey	subdriver
Date: Sun, 15 Jul 2007 15:12:33 -0300
Message-ID: <20070715181233.GG14134@khazad-dum.debian.net>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
	<11844223334107-git-send-email-hmh@hmh.eng.br>
	<20070714223144.GA25782@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070714223144.GA25782-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 14 Jul 2007, Matthew Garrett wrote:
> On Sat, Jul 14, 2007 at 11:11:59AM -0300, Henrique de Moraes Holschuh wrote:
> > +static u16 hotkey_keycode_map[] = {
> > +	/* Scan Codes 0x00 to 0x0B: ACPI HKEY FN+F1..F12 */
> > +	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> > +	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> > +	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> > +	/* Scan codes 0x0C to 0x0F: Other ACPI HKEY hot keys */
> > +	KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
> > +	KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
> > +	KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
> > +	KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
> 
> KEY_BRIGHTNESSUP

Only if I start filtering it out when disabled by the mask.  This key is not
to be sent to userspace unless explicitly configured to do so by something
that KNOWS it will handle it right (hal).

> > +	/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
> > +	KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
> 
> KEY_BRIGHTNESSDOWN

See above.

> > +	KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
> > +	KEY_UNKNOWN,	/* 0x12: FN+PGDOWN */
> > +	KEY_ZOOM,	/* 0x13: FN+SPACE (zoom) */
> > +	KEY_RESERVED,	/* 0x14: VOLUME UP */
> 
> KEY_VOLUMEUP

No.  This is handled in firmware in IBM thinkpads, and userspace only screws
it up.  I am tired of watching people get this routed to the AC97 mixer by
default.  That is a fringe configuration that only makes sense when using a
dock, and with the audio tied to the dock's audio port, in *all* thinkpads
but (_maybe_) the *61.

Let hal enable it if it needs it for OSD, and I sure hope HAL is wise enough
to do passive handling only for the events that come from the thinkpad event
device, because if one has an external multimedia keyboard, its volume keys
should go to the AC97/HDA mixer.

Same goes for volume down and mute.

> Why aren't we setting these sensibly?

They are, in presence of an userspace that thinks it knows better, and just
screws it up all the time.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
