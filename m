From: Stefan =?utf-8?q?D=C3=B6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Questions about vbestate
Date: Wed, 19 Jan 2005 11:18:18 +0100
Message-ID: <200501191118.19164.stefandoesinger@gmx.at>
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
I tried this and it didn't work. I've also found out why. It's because the =
dri=20
part of fglrx crashes after resume.

fglrx and suspend works fine if I disable DRI in xorg.conf. With dri enable=
d=20
I've found no way to resume a started X session :-(

I suppose that vbestate doesn't touch the radeon specific settings set by=20
fglrx and fglrx doesn't restore them carefully enought. If I start a secoun=
d=20
X server after S3 I can't revive the original session too because the 2nd=20
server doesn't initialize dri.

I've written a bug report to ATI yesterday and I'm waiting for a reply.

Stefan


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
