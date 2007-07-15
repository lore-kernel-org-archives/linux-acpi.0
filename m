From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: ACPI: thinkpad-acpi: add input device
	support	to hotkey subdriver
Date: Sun, 15 Jul 2007 17:03:38 -0300
Message-ID: <20070715200338.GB19066@khazad-dum.debian.net>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
	<11844223334107-git-send-email-hmh@hmh.eng.br>
	<20070714223144.GA25782@srcf.ucam.org>
	<20070715181233.GG14134@khazad-dum.debian.net>
	<20070715184519.GD3235@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070715184519.GD3235-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
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
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 15 Jul 2007, Matthew Garrett wrote:
> > No.  This is handled in firmware in IBM thinkpads, and userspace only screws
> > it up.  I am tired of watching people get this routed to the AC97 mixer by
> > default.  That is a fringe configuration that only makes sense when using a
> > dock, and with the audio tied to the dock's audio port, in *all* thinkpads
> > but (_maybe_) the *61.
> 
> It should either generate a KEY_VOLUMEUP or it should generate something 
> explicitly defined as KEY_VOLUMEUP_PASSIVE. The proposed configuration 

Well, it will someday (2.6.24)? be an alsa mixer.  The mixer generates
events when changed, and you could get that info from there.

I'd be happy to provide a VOLUMEUP_PASSIVE, but it doesn't exist.  I'd be
even happier to have an EV_KEYNOTIFY to use instead of EV_KEY that has the
explicit notion that "something else will handle the active effects of this
key, this is a FYI event only".

> (send something that does nothing, but include an arbitrary scancode) 

It doesn't send anything on the input device if it is set to KEY_RESERVED.
It does send an ACPI ibm/hotkey event, but that is a compatibility
interface.

> adds complexity and does nothing other than avoid a (harmless) odd 
> result.

I do not consider screwing up the mixer handling a harmless result.

> > Let hal enable it if it needs it for OSD, and I sure hope HAL is wise enough
> > to do passive handling only for the events that come from the thinkpad event
> > device, because if one has an external multimedia keyboard, its volume keys
> > should go to the AC97/HDA mixer.
> 
> That's fine. One will be coming from the i8042 (or USB) and the other 
> will be coming from thinkpad_acpi. We already have the information 
> needed to do something sensible there - we don't need to have different 
> keycodes to determine which is which.

Good.   Not that I'd have anything against giving you an explicitly
*passive* event, but there is no such a beast.  Give one to me, and I shall
use it.

Until then, since the default meaning of *all* KEY_ events are active in
nature, I am against the idea of generating events that are to be handled in
a passive way, by default.

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
