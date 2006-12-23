From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [PATCH 0/22] acpi4asus sync with 0.31
Date: Sat, 23 Dec 2006 13:27:32 +0100
Message-ID: <200612231327.33301.corentincj@iksaif.net>
References: <200612192217.43660.corentincj@iksaif.net> <20061221011705.GG29711@debian> <200612222111.52411.lenb@kernel.org>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:35861 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbWLWM1f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Dec 2006 07:27:35 -0500
In-Reply-To: <200612222111.52411.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Julien Lerouge <julien.lerouge@m4x.org>, linux-acpi@vger.kernel.org, sziwan@users.sourceforge.net, acpi4asus-user@lists.sourceforge.net

ACK

Le samedi 23 d=E9cembre 2006 03:11, Len Brown a =E9crit=A0:
> Thanks Julien, I'll update MAINTAINERS patch below.
>
> Corentin, please ACK or NAK (note, I put your URL in there too)
>
> I'll leave Karol's entry alone till I hear from him.
>
> Corentin,
> Do you agree that patches for asus_acpi should always appear on the
> acpi4asus mailing list and get an ACK from you before being applied
> upstream? (The only answer is yes:-)  I'll NAK them now:-)
Yes

> But to apply your series, we need to first iron out a couple of logis=
tics.
>
> Per Documentation/SubmittingPatches
>
> From: Original Author <author@example.com>
> must appear on each patch to credit the original author.
> Clarity on the Subject: line about what changed is important.
> Important to keep cosmetic vs functional changes in different patches
> and document such -- looks like you've done a good job of that --
> though ideally the cosmetic patches come _after_ the functional ones
> in case somebody wants to apply functional w/o cosmetic -- but not a =
hard
> rule. Check-in comments go into the permanent record, so they don't
> need to say thing like "this patch" etc, since that is implicit etc.
>
> The series you sent is from you and signed-off-by you, which credits =
nobody
> else. That is fine if you are the original author and only contributo=
r, but
> needs to be updated if not.
Most of the patch I get were unusable. Some of them were very usefull (=
but I=20
had to rewrite them), I added authors in asus_acpi.c header, but forgot=
 them=20
in the mails.

> Also, the e-mail patches must apply and not get garbled by your maile=
r due
> to line-wrap per my previous message.
Ok, I will re-send the whole series. Maybe I should join them to avoid =
stupid=20
mistakes like that ? (Or I can just uncheck line-wrap ^^)

> The patch series will ideally apply on top of any asus_acpi patches a=
lready
> in my tree. But if not, then at a minimum they must apply to Linus' t=
ree --
> which is where you are now and I can attempt to merge any conflicts. =
 If
> you'd rather merge the conflicts, then make sure the series you send
> applied to my tree.
I can re-do the whole series to apply to your tree. If I do that, I wil=
l also=20
include some change from the CVS (3 new models, some cleanups, new led)=
=2E I=20
can also just re-send the series as it is. As you want.
Anyway, I can't do anything before next week.

> Re: development strategy
> Asside from supporting your users, there are a couple of "big picture=
"
> things to be aware of. It is clear that we need platform-specific dri=
vers
> like asus_acpi, and always will. However, to the extent that we creat=
e
> special API's to user-space in the form of /proc or /sysfs files that
> appear only when that driver is loaded, we've failed.
>
> We need to move towards common interfaces that make it simple for use=
rs and
> programmers to talk to the kernel drivers, the backlight and led clas=
ses
> are good examples, and input layer for keyboard events is another.  I=
n
> these cases the user or utility doesn't know or care about the model =
of
> laptop they have or the way that the feature is implemented.  So whil=
e
> /proc/acpi/asus_acpi files were practical for a prototype, they are w=
hat we
> want to move _away_ from, and we should be working on deleting them a=
nd not
> changing what is there and not adding any more /proc files.
>
> Indeed, in the long term, all of /proc/acpi will be removed in favor =
of
> generic /sys interfaces -- as ACPI itself is an implementation depend=
ent
> way of making features available to the user -- ie. not all systems h=
ave
> ACPI...
>
It's why I will try to add led support in the next release :). There is=
 also=20
the new display class.

>
> thanks,
> -Len
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d708702..68f72c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -404,13 +404,13 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>
>  ASUS ACPI EXTRAS DRIVER
> +P:	Corentin Chary
> +M:	corentincj@iksaif.net
>  P:	Karol Kozimor
>  M:	sziwan@users.sourceforge.net
> -P:	Julien Lerouge
> -M:	julien.lerouge@free.fr
>  L:	acpi4asus-user@lists.sourceforge.net
>  W:	http://sourceforge.net/projects/acpi4asus
> -W:	http://julien.lerouge.free.fr
> +W:	http://xf.iksaif.net/acpi4asus
>  S:	Maintained
>
>  ATA OVER ETHERNET DRIVER

Thanks
--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
