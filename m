From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] mailbox: add ACPI support for mailbox framework
Date: Sat, 11 Apr 2015 01:42:42 +0200
Message-ID: <3022123.nmnOLI8qhE@vostro.rjw.lan>
References: <1427836680-13008-1-git-send-email-fkan@apm.com> <11619620.g1RKbURH6u@vostro.rjw.lan> <CAL85gmCHWoVEhxS=bVFrMZbE8NMfmFn6e=g6KG7PMKHRURJ4XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51049 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752657AbbDJXSP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Apr 2015 19:18:15 -0400
In-Reply-To: <CAL85gmCHWoVEhxS=bVFrMZbE8NMfmFn6e=g6KG7PMKHRURJ4XA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Kan <fkan@apm.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, patches <patches@apm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday, April 07, 2015 03:58:36 PM Feng Kan wrote:
> On Tue, Apr 7, 2015 at 4:37 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, April 07, 2015 11:41:43 AM Mika Westerberg wrote:
> >> On Thu, Apr 02, 2015 at 11:04:24AM -0700, Feng Kan wrote:
> >> > On Thu, Apr 2, 2015 at 2:07 AM, Mika Westerberg
> >> > <mika.westerberg@linux.intel.com> wrote:
> >> > > On Wed, Apr 01, 2015 at 10:01:45AM -0700, Feng Kan wrote:
> >> > >> On Wed, Apr 1, 2015 at 12:45 AM, Mika Westerberg
> >> > >> <mika.westerberg@linux.intel.com> wrote:
> >> > >> > On Tue, Mar 31, 2015 at 02:18:00PM -0700, Feng Kan wrote:
> >> > >> >> This will add support for ACPI parsing of the mboxes attribute
> >> > >> >> when booting with ACPI table. The client will have a attribute
> >> > >> >> mimic the dts call "mboxes". In the ACPI case, the client will
> >> > >> >> mark "mboxes" with the ACPI HID of the mbox it wishes to use.
> >> > >> >>
> >> > >> >>       Name (_DSD, Package () {
> >> > >> >>               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >> > >> >>               Package () {
> >> > >> >>                       Package (2) {"mboxes", "ACPIHID"},
> >> > >> >>               }
> >> > >> >>       })
> >> > >> >
> >> > >> > Instead of this, why not match against the DT compatible property?
> >> > >> >
> >> > >> >         Name (_HID, "PRP0001")
> >> > >> >
> >> > >> >         Name (_DSD, Package () {
> >> > >> >                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >> > >> >                 Package () {
> >> > >> >                         Package (2) {"compatible", "your-dt-compatible-string"},
> >> > >> >                 }
> >> > >> >         })
> >> > >> I think my description was not clear enough. The _DSD section is not
> >> > >> meant to identify the mailbox driver, but used by the acpi node that will
> >> > >> request the mailbox channel. The dts version would be as below.
> >> > >>
> >> > >>    mailbox: {
> >> > >>    }
> >> > >>
> >> > >>    user-mbox: {
> >> > >>       mboxes: <&mailbox 0>
> >> > >>    }
> >> > >>
> >> > >> The mboxes attribute in the user of the mbox has to specify the HID of the
> >> > >> mbox in order to retrieve channel pointer.
> >> > >
> >> > > Okay, then I think you can use reference instead of _HID, like
> >> > >
> >> > >         // The mailbox device
> >> > >         Device (MLBX) {
> >> > >         }
> >> > >
> >> > >         // User-mbox device
> >> > >         Device (USBX) {
> >> > >                 Name (_DSD, Package () {
> >> > >                         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >> > >                         Package () {
> >> > >                                 Package () {"mboxes", Package () {^^MLBX, 0}}),
> >> > >                         }
> >> > >                 })
> >> > >         }
> >> >
> >> > Thanks, will try this. A side question on your previous reply. Would you
> >> > prefer a new driver using the PRP0001 or an actual proper HID.
> >>
> >> If you have existing DT bindings for this, then PRP0001 is fine.
> >> Otherwise you should use the proper _HID for this particular device.
> >
> > To be precise, PRP0001 specifically means "Use the 'compatible' property
> > to find the driver for this device", so if *that* is what you want to do,
>
> I am a bit uneasy about this. I understand the application of this. For a system
> that is both DT and ACPI compatible, this would open up a flood of PRP0001
> device drivers. What is the guideline here? Is this PRP0001 only exist
> to support legacy devices that do not have a proper HID.
>

For Windows-compatible firmware it generally would be better to use PRP0001 in
a _CID and make the _HID return a proper device ID that could be matched by a
Windows driver.

Then, the PRP0001 makes it possible to match drivers using the existing DT
device identification without having to add the ACPI device IDs to those
drivers in order to enable them to work with newfangled ACPI tables.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
