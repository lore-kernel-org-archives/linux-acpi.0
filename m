From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Questions about vbestate
Date: Sat, 22 Jan 2005 13:10:47 +0000
Message-ID: <1106399447.30227.26.camel@tyrosine>
References: <200501181912.19644.stefandoesinger@gmx.at>
	 <1106096142.7368.32.camel@tyrosine>
	 <200501221205.40179.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200501221205.40179.stefandoesinger-RbZlAiThDcE@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

On Sat, 2005-01-22 at 12:05 +0100, Stefan D=C3=B6singer wrote:

> Is it possible to reset the whole video memory with vbetool? I mean, if w=
e=20
> reset the graphics processor when posting the card, we should also clean =
up=20
> the garbage in the video memory. The content in my card's memory survives=
 a=20
> card reboot, a suspend-to-ram cycle and even a system reboot. Under certa=
in=20
> circumstances this crashes both fglrx and the open source radeon driver.

That's likely to be caused by held-over internal chip state, rather than
video memory. Whether or not vbetool can do anything about that depends
on the video BIOS, really - the state saving/restore /ought/ to deal
with that, but there's no guarantee.

--=20
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
