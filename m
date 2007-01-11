From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [Acpi4asus-user] Experimental version, need testing and review.
Date: Thu, 11 Jan 2007 12:53:03 +0100
Message-ID: <200701111253.03533.corentincj@iksaif.net>
References: <200612301115.04227.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:33724 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030281AbXAKLxG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jan 2007 06:53:06 -0500
In-Reply-To: <200612301115.04227.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: acpi4asus-user@lists.sourceforge.net
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Timo Hoenig <thoenig@suse.de>, Daniel Gollub <dgollub@suse.de>

Le samedi 30 d=E9cembre 2006 11:15, Corentin CHARY a =E9crit :
> Hi,
> To add support for a new model in the current code, we had to get the=
 dsdt,
> search the right methods by hand, add them in the model_data array. B=
ut
> methods like "SDSP",  "GPLV", "SPLV" are always the same. And there a=
re
> limited name for display_get methods : ""\\_SB.PCI0.P0Px.VGA.GETD", "=
ACTD",
> etc ...
> So I decided to recode the whole detection system, and it's now more =
like
> the ibm_acpi one.
> We give to the driver methods found in models we know, and the driver
> search if they are in the current dsdt.
>
> I also found a method, present in all new models: "RSTS" wich return =
the
> status of wireless device. It's very usefull, as we don't need wled_s=
tatus
> or bt_status anymore.
> I also removed all xled_status, because we only had some pour mled_st=
atus.
>
> I tested this code on A6J, F3J and A6T : it works perfectly.
>
> But it's probably full of bugs.
>
> So if anyone could test it, and repport what doesn't work, if the lap=
top
> burst into flames, etc ...
>
> http://xf.iksaif.net/acpi4asus/experimental/

Hi, there is a new experimental version.
http://xf.iksaif.net/acpi4asus/experimental/

Changes :
- Led are now handled via /sys/class/leds
- wled_set is now wl_switch, because in some models (like my A6JC), WLE=
D is=20
used to switch the wireless device=20
- lcd_status removed, this method was different in all the dsdt, we now=
 use=20
hotk->status to keep the lcd backlight status, assuming it's ON by defa=
ult.
- /proc/acpi/asus/wled is now  /proc/acpi/asus/wireless
- /proc/acpi/asus/lcd have been removed, you can=20
use /sys/class/backlight/asus/power now
- /proc/acpi/asus/brn removed, use /sys/class/backlight/brightness

Notes:
- /proc/acpi/asus/disp will be moved soon with the new display class.
- The printk in asus_handle_init() will be removed later.

Problems :
- Does it work ? (only tested on A6T, A6J and F3J)
- What does "echo 1 > /proc/acpi/asus/wireless" on your model ?
- What should we do with /proc/acpi/asus/[wireless,bluetooth,lslvl,lssw=
] (move=20
to /sys/class/misc ?)  ?
- Maybe it's time to move it to misc/asus-laptop.c ? (see diffstat belo=
w)

diffstat diff-asus_acpi-0.31-asus_acpi-experimental.patch
 asus_acpi.c | 1837=20
++++++++++++++++--------------------------------------------
 1 file changed, 504 insertions(+), 1333 deletions(-)

When I have enough feedback, I will send patchs to linux-acpi@vger.kern=
el.org,=20
but I need to know if this driver is usable before.

--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
