From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Re: [RFC] Reliable video POSTing on resume
Date: Sat, 5 Feb 2005 17:48:43 +0100
Message-ID: <200502051748.43547.stefandoesinger@gmx.at>
References: <20050122134205.GA9354@wsc-gmbh.de> <4204B3C1.80706@rainbow-software.org> <9e473391050205074769e4f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e473391050205074769e4f10-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Samstag, 5. Februar 2005 16:47 schrieb Jon Smirl:
> On Sat, 05 Feb 2005 12:53:37 +0100, Ondrej Zary
>
> <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org> wrote:
> > I wonder how this can work:
> > a motherboard with i815 chipset (integrated VGA), Video BIOS is
> > integrated into system BIOS
> > a PCI card inserted into one of the PCI slots, configured as primary in
> > system BIOS
>
> The info needed to initialize Intel chips is public. The info needed
> to initialize most Nvidia and ATI chips is not.
DID someone ask ATI or Nvidia for this? I have the impression that everyone 
says ati doesn't help, but no one tried to get help so far.

The reset code of radeon card seems to be easy to reverse engineer. I have 
started an attempt and I have 50-60% of my radeon M9 reset code implemented 
in a 32 bit C program. I had to stop due to school reasons.

My radeonreset kernel module turns the backlight off and seems to reset the 
card's memory. I consider it dangerous because I don't know what it really 
does because I don't have the card's specs. A owner of an radeon M6 card 
tried my code too and it worked in the same way as on my M9 card, so I think 
the reset procedure is the same on all radeon cards. I think with some 
comparison of the reset code and the specs that the DRI/X.org/XFree 
developers have we can write a working reset code for radeon cards.
This won't help users of non-radeon cards of course :-(

ATI is aware of suspend/resume problems with their fglrx driver(see 
http://www.ati.com/support/infobase/4746.html). I've written a few notes to 
them, but I haven't got a reply so far(But they also told me not to expect 
one). The power management code in radeon_pm.c seems to be written by ATI. 
Alltogether I'd not call the situation hopeless.

Cheers,
Stefan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
