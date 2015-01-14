From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] TCO Watchdog warning interrupt driver creation
Date: Wed, 14 Jan 2015 10:16:57 -0800
Message-ID: <20150114181657.GB13907@roeck-us.net>
References: <B9C02DB17496AC4197F41A146D371B9B075AF9DE@hasmsx107.ger.corp.intel.com>
 <20141211040404.GA28797@vmdeb7>
 <5489AA6B.9080802@roeck-us.net>
 <B9C02DB17496AC4197F41A146D371B9B075C5FE3@hasmsx107.ger.corp.intel.com>
 <E73BFCB9-87CB-447D-839C-9ED4031FC6E2@infradead.org>
 <B9C02DB17496AC4197F41A146D371B9B075C6189@hasmsx107.ger.corp.intel.com>
 <54AF6288.6040305@roeck-us.net>
 <B9C02DB17496AC4197F41A146D371B9B075CC9FA@hasmsx107.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <B9C02DB17496AC4197F41A146D371B9B075CC9FA@hasmsx107.ger.corp.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Muller, Francois-nicolas" <francois-nicolas.muller@intel.com>
Cc: Darren Hart <dvhart@infradead.org>, "'platform-driver-x86@vger.kernel.org'" <platform-driver-x86@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 14, 2015 at 04:32:33PM +0000, Muller, Francois-nicolas wrot=
e:
> Thanks for your review, my comments embedded below.
> I'm sending the new version of the patch in the following email.
> Fran=E7ois-Nicolas
>=20
=2E..
> >>
> >> +static const struct acpi_device_id iTCO_wdt_ids[] =3D {
> >> +	{"8086229C", 0},
> >> +	{"", 0},
> >> +};
> >> +MODULE_DEVICE_TABLE(acpi, iTCO_wdt_ids);
> >> +
> >
> >Doesn't that result in auto-loading the driver ?
>=20
> The driver is loaded only when Bios exposes the acpi device and the b=
oot param warn_irq is true.
> Could you clarify ? I don't understand the issue.=20
>=20
Unless I am missing something, you are making two changes
in a single patch.

- auto-load driver if acpi device is exposed by bios
- Add interrupt handling support

I suggested to separate those changes into two patches.

Guenter
