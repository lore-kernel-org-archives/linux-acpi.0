From: "Dmitry Torokhov" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI: thinkpad-acpi: make the input event mode
	the default
Date: Mon, 16 Jul 2007 11:27:35 -0400
Message-ID: <d120d5000707160827u5217722fvcffb9339b80c0c79@mail.gmail.com>
References: <20070715180529.GF14134@khazad-dum.debian.net>
	<20070715200948.GC19066@khazad-dum.debian.net>
	<20070715201346.GB5518@srcf.ucam.org>
	<20070715211421.GG19066@khazad-dum.debian.net>
	<20070715211953.GA6527@srcf.ucam.org>
	<20070715220801.GK19066@khazad-dum.debian.net>
	<20070715224914.GB7164@srcf.ucam.org>
	<20070716001239.GA31604@khazad-dum.debian.net>
	<20070716002420.GA8140@srcf.ucam.org>
	<20070716030254.GD31604@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070716030254.GD31604-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
Content-Disposition: inline
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
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 7/15/07, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org> wrote:
> On Mon, 16 Jul 2007, Matthew Garrett wrote:
> >
> > Having checked other drivers, it looks like KEY_SWITCHVIDEOMODE is the
> > one used for video toggling. If that's not actually how people are using
> > it, we need to fix that - if it is, I'd just go for it.
>
> This looks like a breakage warning to me.  Better decide once and for all
> what this keycode is supposed to do, and document it.  Because switching
> video mode is not "switch video output mode", and can easily be confused
> with "switch screen resolution", "switch video mode between expanded and
> normal" or whatever.
>

I will add a comment to input.h to the effect that KEY_SWITCHVIDEOMODE
is to switch between available outputs (LCD/Monitor/TV-Out/Whatnot).
Right now couple of RCs are using it for different purposes (cycling
through inputs I think) so we should do somethig about these.

-- 
Dmitry

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
