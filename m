From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: ACPI: thinkpad-acpi: react to Lenovo ThinkPad
	differences in	hot key
Date: Sun, 15 Jul 2007 14:59:22 -0300
Message-ID: <20070715175922.GD14134@khazad-dum.debian.net>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
	<118442233665-git-send-email-hmh@hmh.eng.br>
	<20070714223932.GD25782@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070714223932.GD25782-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
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
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Matthew!

On Sat, 14 Jul 2007, Matthew Garrett wrote:

> On Sat, Jul 14, 2007 at 11:12:09AM -0300, Henrique de Moraes Holschuh wrote:
> 
> Ah, I see this one fixes some of my comments. However:
> 
> > +		KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
> > +		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
> > +		KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
> 
> > +		KEY_BRIGHTNESSUP,	/* 0x0F: FN+HOME (brightness up) */
> > +		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
> > +		KEY_BRIGHTNESSDOWN,	/* 0x10: FN+END (brightness down) */
> 
> Why this difference?

Brightness events are handled in firmware (and no, you cannot make the
firmware NOT handle it) in IBM thinkpads.  Lenovo thinkpads seem to be
moving it to userspace, so you have to generate the events and actively
handle them in the ACPI OSI or in userspace.

I generate events *only* for stuff that needs active handling by default.
Since the hotkey mask cannot really be trusted to filter out events (unless
I start filtering it in the driver *as well*... might be a good idea), I
don't add the passive keys to the keymap.

Regardless, userspace *will* have to take some action to enable the hotkeys
that are to only be used for passive monitoring.  Right now this means
enabling them in the mask, and remapping the key map.  If this is that a big
problem, I can add extra driver filtering, and make it only "enable it in
the mask".

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
