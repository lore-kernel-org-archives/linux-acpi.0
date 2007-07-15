From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: ACPI: thinkpad-acpi: add input device support
	to hotkey subdriver
Date: Sun, 15 Jul 2007 19:45:19 +0100
Message-ID: <20070715184519.GD3235@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
	<11844223334107-git-send-email-hmh@hmh.eng.br>
	<20070714223144.GA25782@srcf.ucam.org>
	<20070715181233.GG14134@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070715181233.GG14134-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
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
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jul 15, 2007 at 03:12:33PM -0300, Henrique de Moraes Holschuh wrote:
> On Sat, 14 Jul 2007, Matthew Garrett wrote:
> > KEY_BRIGHTNESSUP
> 
> Only if I start filtering it out when disabled by the mask.  This key is not
> to be sent to userspace unless explicitly configured to do so by something
> that KNOWS it will handle it right (hal).

I'm not aware of any other application that uses it.

> > KEY_VOLUMEUP
> 
> No.  This is handled in firmware in IBM thinkpads, and userspace only screws
> it up.  I am tired of watching people get this routed to the AC97 mixer by
> default.  That is a fringe configuration that only makes sense when using a
> dock, and with the audio tied to the dock's audio port, in *all* thinkpads
> but (_maybe_) the *61.

It should either generate a KEY_VOLUMEUP or it should generate something 
explicitly defined as KEY_VOLUMEUP_PASSIVE. The proposed configuration 
(send something that does nothing, but include an arbitrary scancode) 
adds complexity and does nothing other than avoid a (harmless) odd 
result.

> Let hal enable it if it needs it for OSD, and I sure hope HAL is wise enough
> to do passive handling only for the events that come from the thinkpad event
> device, because if one has an external multimedia keyboard, its volume keys
> should go to the AC97/HDA mixer.

That's fine. One will be coming from the i8042 (or USB) and the other 
will be coming from thinkpad_acpi. We already have the information 
needed to do something sensible there - we don't need to have different 
keycodes to determine which is which.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
