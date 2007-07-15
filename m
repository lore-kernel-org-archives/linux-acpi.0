From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: ACPI: thinkpad-acpi: make the input event mode
	the default
Date: Sun, 15 Jul 2007 23:49:14 +0100
Message-ID: <20070715224914.GB7164@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
	<11844223341511-git-send-email-hmh@hmh.eng.br>
	<20070714223315.GB25782@srcf.ucam.org>
	<20070715180529.GF14134@khazad-dum.debian.net>
	<20070715183823.GC3235@srcf.ucam.org>
	<20070715200948.GC19066@khazad-dum.debian.net>
	<20070715201346.GB5518@srcf.ucam.org>
	<20070715211421.GG19066@khazad-dum.debian.net>
	<20070715211953.GA6527@srcf.ucam.org>
	<20070715220801.GK19066@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070715220801.GK19066-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
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
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jul 15, 2007 at 07:08:01PM -0300, Henrique de Moraes Holschuh wrote:
> On Sun, 15 Jul 2007, Matthew Garrett wrote:
> > Right now, the hotkey functionality of the driver is not terribly useful 
> > without (bleeding-edge) userspace. This is inconsistent with the 
> > majority of input drivers which do something broadly sane in that 
> > situation.
> 
> It works better with non-bleeding-edge userspace the way I did it, as far as
> I know. So I'll need some explanations about what I should be doing
> differently.
> 
> Here's my view on things:
> 
> Non-bleeding-edge userspace screws up volume control if I send events.  And
> so does bleeding-edge userspace for that matter, AFAIK.

No, it doesn't. It interacts in a way that you may not consider to be 
ideal - the vast majority of our users appear to prefer it to the 
previous behaviour, so it's better than nothing.

> Non-bleeding-edge userspace screws up brightness control if I send events.

No. Nothing will screw up if you send brightness events.

> Bleeding-edge userspace needs to be told it exists, anyway, to make proper
> use of it, and can be told to enable it on the driver while at it.

We've been listening for KEY_BRIGHTNESS* on Thinkpads for over a year. 
It's already implemented and works fine.

> Non-bleeding-edge userspace that is not broken can remap keys already.
> FN+F1 generating KEY_FN_F1 makes a lot more sense to someone which has a
> blank FN+F1 key, than it generating "KEY_FOOBAR".

That's fine. Send KEY_FN_F1 if there's no label.

> So exactly what should I be changing to make it more useful?  WHAT hot keys
> do you want mapped by default, and to which key codes?  And forget the ones
> that need passive handling, these are not mapped for a very different
> reason.

On a machine with a glyph, the driver should generate a keycode 
appropriate for that glyph.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
