From: Stefan =?utf-8?q?D=C3=B6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Questions about vbestate
Date: Sat, 22 Jan 2005 12:05:40 +0100
Message-ID: <200501221205.40179.stefandoesinger@gmx.at>
References: <200501181912.19644.stefandoesinger@gmx.at> <1106096142.7368.32.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1106096142.7368.32.camel@tyrosine>
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

Am Mittwoch, 19. Januar 2005 01:55 schrieb Matthew Garrett:
> On Tue, 2005-01-18 at 19:12 +0100, Stefan D=C3=B6singer wrote:
> > *If I save the card's state with vbesate before calling the post-routine
> > and restoring the state afterwards makes switching back to X work again.
>
> I'd recommend saving the vbe state on boot, and not on every suspend.
> I'm not sure why, but there certainly seems to be some amount of
> information that's lost otherwise. Saving on suspend seems to make a
> large amount of hardware unhappy - I've only found one machine that
> complains about it on boot.

Is it possible to reset the whole video memory with vbetool? I mean, if we=
=20
reset the graphics processor when posting the card, we should also clean up=
=20
the garbage in the video memory. The content in my card's memory survives a=
=20
card reboot, a suspend-to-ram cycle and even a system reboot. Under certain=
=20
circumstances this crashes both fglrx and the open source radeon driver.

Stefan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
