From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [REGRESSION] Media keys cause "ACPI: \_SB_.ATKD: Unsupported event" on ASUS laptop
Date: Thu, 24 Apr 2014 12:51:01 +0200
Message-ID: <2784123.GhF2tcctEM@vostro.rjw.lan>
References: <liocsk$le0$1@ger.gmane.org> <20140424052151.GA9449@sucs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140424052151.GA9449@sucs.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: Mantas =?utf-8?B?TWlrdWzEl25hcw==?= <grawity@gmail.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, April 24, 2014 06:21:52 AM Sitsofe Wheeler wrote:
> On Thu, Apr 17, 2014 at 02:11:15PM +0300, Mantas Mikul=C4=97nas wrote=
:
> > After commit 1a699476e258 [two months ago], Linux has stopped
> > recognizing the media & function keys on my laptop's keyboard (the
> > laptop is ASUS K52JT.206).
> >=20
> > When I press any of the Fn keys (Play/Pause, Stop, Prev, Next, Vol+=
,
> > Vol-, Mute, WiFi, Brightness +/-...), I get the following messages =
in dmesg:
> >=20
> > | ACPI: \_SB_.ATKD: Unsupported event type 0x45
> > | ACPI: \_SB_.ATKD: Unsupported event type 0x43
> > | ACPI: \_SB_.ATKD: Unsupported event type 0x40
> > | etc.
>=20
> I'm seeing the same problem with an EeePC 900's volume and brightness
> keys:
> [   90.098518] ACPI: \_SB_.ATKD: Unsupported event type 0x14
> [   90.785202] ACPI: \_SB_.ATKD: Unsupported event type 0x15
> [  457.062072] ACPI: \_SB_.ATKD: Unsupported event type 0x2e
> [  457.926754] ACPI: \_SB_.ATKD: Unsupported event type 0x2d
> [  458.418740] ACPI: \_SB_.ATKD: Unsupported event type 0x2c
> [  458.821482] ACPI: \_SB_.ATKD: Unsupported event type 0x2b
> [  459.240896] ACPI: \_SB_.ATKD: Unsupported event type 0x2a

Does this patch help:

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
