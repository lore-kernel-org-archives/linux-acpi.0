From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: ACPI: thinkpad-acpi: add input device support
	to hotkey subdriver
Date: Sun, 15 Jul 2007 23:45:11 +0100
Message-ID: <20070715224511.GA7164@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
	<11844223334107-git-send-email-hmh@hmh.eng.br>
	<20070714223144.GA25782@srcf.ucam.org>
	<20070715181233.GG14134@khazad-dum.debian.net>
	<20070715184519.GD3235@srcf.ucam.org>
	<20070715200338.GB19066@khazad-dum.debian.net>
	<20070715201201.GA5518@srcf.ucam.org>
	<20070715205934.GF19066@khazad-dum.debian.net>
	<20070715210405.GA6216@srcf.ucam.org>
	<20070715215453.GJ19066@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070715215453.GJ19066-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jul 15, 2007 at 06:54:53PM -0300, Henrique de Moraes Holschuh wrote:
> On Sun, 15 Jul 2007, Matthew Garrett wrote:
> > Hal is the only piece of userspace that knows how to speak to more than 
> > one type of backlight in any useful way, which makes it the de-facto 
> > reference for how userspace interprets these keys.
> 
> Since when does system-specific programs not count?

If they're Thinkpad-specific, they're already doing the right thing. If 
they're specific to another model, they're not running on a Thinkpad.

> > The fact that keys share event codes doesn't mean that these keycodes 
> > are going to have identical semantics on all hardware. One solution to 
> > that would be to avoid ever sending these keycodes, but that would make 
> > having them defined in the first place a bit silly. Since they /are/ 
> > there, it makes sense to use them.
> 
> I see a keycode defined in the USB HID spec for use in stuff that only knows
> active handling -- passive doesn't even make any sense for them -- and its
> reflect on the kernel input layer.
> 
> There _are_ a few platforms where *one* of the built-in devices need a
> different handling, and that's just because the firmware won't cooperate.
> But if I plug a USB keyboard on a thinkpad, for example, I need the proper
> (active) handling of the event.

That's fine. You know that the event came from an external keyboard, so 
you know that it has to be handled actively.

> I definately think "avoid ever sending these keycodes" in this instance is
> the right way to go, until we can actually issue a "this is a passive key
> press" event.

As I said, the existing userspace implementation disagrees. I'd prefer 
to avoid breaking that.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
