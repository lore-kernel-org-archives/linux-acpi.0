From: Stefan =?utf-8?q?D=C3=B6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Questions about vbestate
Date: Sat, 22 Jan 2005 16:11:53 +0100
Message-ID: <200501221611.53972.stefandoesinger@gmx.at>
References: <200501181912.19644.stefandoesinger@gmx.at> <200501221205.40179.stefandoesinger@gmx.at> <1106399447.30227.26.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1106399447.30227.26.camel@tyrosine>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Samstag, 22. Januar 2005 14:10 schrieb Matthew Garrett:
> On Sat, 2005-01-22 at 12:05 +0100, Stefan D=C3=B6singer wrote:
> > Is it possible to reset the whole video memory with vbetool? I mean, if
> > we reset the graphics processor when posting the card, we should also
> > clean up the garbage in the video memory. The content in my card's memo=
ry
> > survives a card reboot, a suspend-to-ram cycle and even a system reboot.
> > Under certain circumstances this crashes both fglrx and the open source
> > radeon driver.
>
> That's likely to be caused by held-over internal chip state, rather than
> video memory. Whether or not vbetool can do anything about that depends
> on the video BIOS, really - the state saving/restore /ought/ to deal
> with that, but there's no guarantee.
If I switch between the 2 drivers, the X server crashes on load after a sys=
tem=20
reboot(at least it happened with older versions of the drivers). A part of =
my=20
old desktop image appears when I attempt to start the server. That's why I=
=20
think that some content in the video memory survives a reboot.

I'll need the help of ATI with the fglrx driver. I contacted ATI but didn't=
=20
get a reply so far. :-(

What's the state of Nvidia cards here? Do they work with suspend-to-ram?

Stefan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
