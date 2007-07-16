From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: ACPI: thinkpad-acpi: make the input event mode
	the default
Date: Mon, 16 Jul 2007 01:24:20 +0100
Message-ID: <20070716002420.GA8140@srcf.ucam.org>
References: <20070714223315.GB25782@srcf.ucam.org>
	<20070715180529.GF14134@khazad-dum.debian.net>
	<20070715183823.GC3235@srcf.ucam.org>
	<20070715200948.GC19066@khazad-dum.debian.net>
	<20070715201346.GB5518@srcf.ucam.org>
	<20070715211421.GG19066@khazad-dum.debian.net>
	<20070715211953.GA6527@srcf.ucam.org>
	<20070715220801.GK19066@khazad-dum.debian.net>
	<20070715224914.GB7164@srcf.ucam.org>
	<20070716001239.GA31604@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070716001239.GA31604-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
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
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jul 15, 2007 at 09:12:40PM -0300, Henrique de Moraes Holschuh wrote:
> On Sun, 15 Jul 2007, Matthew Garrett wrote:
> > No, it doesn't. It interacts in a way that you may not consider to be 
> > ideal - the vast majority of our users appear to prefer it to the 
> > previous behaviour, so it's better than nothing.
> 
> I don't go for "better than nothing", when there is a way to have it right
> (and there is: an alsa mixer, or an extension to the input layer).

Certainly. Once it's possible to do it the right way, we can do it the 
right way :)

> > No. Nothing will screw up if you send brightness events.
> 
> It can, if it feed backs a brightness up order to the kernel, either
> through thinkpad-acpi, or through the ACPI video driver at the wrong time
> (before the thinkpad firmware did it).  And before you think the firmware
> might be doing something sane for a change, I've had reports of more than
> half-a-second delay on a X60s without the latest EC between a brightness
> change order, and the hardware responding to it.
> 
> A bad feedback will either increase brightness once with two writes (waste
> of resources, but the user won't notice, and I hope the thinkpad hardware is
> not so crappy as to bother the inverter in this case), increase twice, or
> cause a loop (got a report, don't know how it happened, but I *do* know the
> code has no defense --yet-- against such a loop) that makes it increase the
> brightness all the way up or all the way down until you press some other key
> that disturbs the loop.

The only code currently listening for KEY_BRIGHTNESS* on Thinkpads is 
gnome-power-manager, and that uses the Hal information to check whether 
it needs to behave passively or actively and so does the right thing. 
Anything else is either Thinkpad-specific and doesn't listen for 
KEY_BRIGHTNESS or listens for KEY_BRIGHTNESS and doesn't know how to 
control the Thinkpad hardware. As a result, sending KEY_BRIGHTNESS can't 
break any existing software.

> > We've been listening for KEY_BRIGHTNESS* on Thinkpads for over a year. 
> > It's already implemented and works fine.
> 
> If everything did it right, I would have never heard of it.  Note that I am
> not accusing HAL of breakage, I am talking about *userspace*.  I am *not*
> sure if hal is what broke it, and, if it indeed was hal, whether it was new
> enough.  I am sure bleeding-edge hal does something sensible for brightness,
> and I have no reasons not to believe you that one-year-old hal will do
> something wrong, either.  But there is other userspace, AND much older hal.

We had a broken version of hal in a development version of Ubuntu. No 
release version (of Ubuntu or hal) has ever had this bug.

> > That's fine. Send KEY_FN_F1 if there's no label.
> 
> Isn't that what I am doing right now?  That's why I asked you which key
> codes I was missing when you complained about it. I really don't know of
> any.

I hadn't read all the way through the patch series before sending my 
initial mail, so the one that added more keys fixes most of my concerns.

> > On a machine with a glyph, the driver should generate a keycode 
> > appropriate for that glyph.
> 
> It already does so for every key with a glyph that requires active handling
> AND which is present on most thinkpads AND for which I could find a sensible
> keycode.
> 
> Oh, I miss an undock/eject generic device keycode, too.  Can't use EJECTCD
> to undock...
> 
> Again, what you want me to change in that default key code matrix that is
> not a passive-action key?  I aimed to do the best I could according to the
> info I have (http://thinkwiki.org/wiki/Default_meanings_of_special_keys).

Having checked other drivers, it looks like KEY_SWITCHVIDEOMODE is the 
one used for video toggling. If that's not actually how people are using 
it, we need to fix that - if it is, I'd just go for it.

As for the passive keys - I can (with a very high level of certainty) 
assert that there is no existing userspace that will be broken by 
sending the brightness keys. We can quibble over the volume ones, but 
even there the breakage is minimal.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
