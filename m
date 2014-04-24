From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [REGRESSION] Media keys cause "ACPI: \_SB_.ATKD: Unsupported event" on ASUS laptop
Date: Thu, 24 Apr 2014 19:06:03 +0200
Message-ID: <2689604.Irr3FKRzyq@vostro.rjw.lan>
References: <liocsk$le0$1@ger.gmane.org> <2784123.GhF2tcctEM@vostro.rjw.lan> <CAPWNY8X3fVAM3kcdWmg0BcQuNw84ROY+wQsh-JzfxGEt1uWFQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59982 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932522AbaDXQtl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Apr 2014 12:49:41 -0400
In-Reply-To: <CAPWNY8X3fVAM3kcdWmg0BcQuNw84ROY+wQsh-JzfxGEt1uWFQQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mantas =?utf-8?B?TWlrdWzEl25hcw==?= <grawity@gmail.com>, Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, April 24, 2014 04:31:19 PM Mantas Mikul=C4=97nas wrote:
> On Thu, Apr 24, 2014 at 1:51 PM, Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
> > On Thursday, April 24, 2014 06:21:52 AM Sitsofe Wheeler wrote:
> >> On Thu, Apr 17, 2014 at 02:11:15PM +0300, Mantas Mikul=C4=97nas wr=
ote:
> >> > After commit 1a699476e258 [two months ago], Linux has stopped
> >> > recognizing the media & function keys on my laptop's keyboard (t=
he
> >> > laptop is ASUS K52JT.206).
> >> >
> >> > When I press any of the Fn keys (Play/Pause, Stop, Prev, Next, V=
ol+,
> >> > Vol-, Mute, WiFi, Brightness +/-...), I get the following messag=
es in dmesg:
> >> >
> >> > | ACPI: \_SB_.ATKD: Unsupported event type 0x45
> >> > | ACPI: \_SB_.ATKD: Unsupported event type 0x43
> >> > | ACPI: \_SB_.ATKD: Unsupported event type 0x40
> >> > | etc.
> >>
> >> I'm seeing the same problem with an EeePC 900's volume and brightn=
ess
> >> keys:
> >> [ 90.098518] ACPI: \_SB_.ATKD: Unsupported event type 0x14
> >> [   90.785202] ACPI: \_SB_.ATKD: Unsupported event type 0x15
> >> [  457.062072] ACPI: \_SB_.ATKD: Unsupported event type 0x2e
> >> [  457.926754] ACPI: \_SB_.ATKD: Unsupported event type 0x2d
> >> [  458.418740] ACPI: \_SB_.ATKD: Unsupported event type 0x2c
> >> [  458.821482] ACPI: \_SB_.ATKD: Unsupported event type 0x2b
> >> [  459.240896] ACPI: \_SB_.ATKD: Unsupported event type 0x2a
> >
> > Does this patch help:
> >
> > ---
> >  drivers/acpi/bus.c |    5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> Yes, it seems to be working fine.

OK, thanks for verifying, below it goes with a changelog and tags.

Rafael


---
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / notify: Do not block unknown type notifications in root=
 handler

Commit 1a699476e258 "ACPI / hotplug / PCI: Hotplug notifications from
acpi_bus_notify()" changed the root notify handler, acpi_bus_notify(),
to block unknown type norifications, but it overlooked the fact that
they might be propagated to drivers via the ->notify() callback.

=46ix the problem by allowing drivers to receive unknown type
notifications via ->notify() as before.

Reported-and-tested-by: Mantas Mikul=C4=97nas <grawity@gmail.com>
Reported-and-tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -380,9 +380,8 @@ static void acpi_bus_notify(acpi_handle
 		break;
=20
 	default:
-		acpi_handle_warn(handle, "Unsupported event type 0x%x\n", type);
-		ost_code =3D ACPI_OST_SC_UNRECOGNIZED_NOTIFY;
-		goto err;
+		acpi_handle_debug(handle, "Unknown event type 0x%x\n", type);
+		break;
 	}
=20
 	adev =3D acpi_bus_get_acpi_device(handle);

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
