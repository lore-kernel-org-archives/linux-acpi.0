From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] mailbox: add ACPI support for mailbox framework
Date: Tue, 07 Apr 2015 13:37:56 +0200
Message-ID: <11619620.g1RKbURH6u@vostro.rjw.lan>
References: <1427836680-13008-1-git-send-email-fkan@apm.com> <CAL85gmA1mjcX6FEmUHipn0iSzpti2z6D4++7Q3gxGiPGZaE_Cw@mail.gmail.com> <20150407084143.GP17830@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62344 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752479AbbDGLNd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2015 07:13:33 -0400
In-Reply-To: <20150407084143.GP17830@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Feng Kan <fkan@apm.com>, patches <patches@apm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday, April 07, 2015 11:41:43 AM Mika Westerberg wrote:
> On Thu, Apr 02, 2015 at 11:04:24AM -0700, Feng Kan wrote:
> > On Thu, Apr 2, 2015 at 2:07 AM, Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > On Wed, Apr 01, 2015 at 10:01:45AM -0700, Feng Kan wrote:
> > >> On Wed, Apr 1, 2015 at 12:45 AM, Mika Westerberg
> > >> <mika.westerberg@linux.intel.com> wrote:
> > >> > On Tue, Mar 31, 2015 at 02:18:00PM -0700, Feng Kan wrote:
> > >> >> This will add support for ACPI parsing of the mboxes attribute
> > >> >> when booting with ACPI table. The client will have a attribute
> > >> >> mimic the dts call "mboxes". In the ACPI case, the client will
> > >> >> mark "mboxes" with the ACPI HID of the mbox it wishes to use.
> > >> >>
> > >> >>       Name (_DSD, Package () {
> > >> >>               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > >> >>               Package () {
> > >> >>                       Package (2) {"mboxes", "ACPIHID"},
> > >> >>               }
> > >> >>       })
> > >> >
> > >> > Instead of this, why not match against the DT compatible property?
> > >> >
> > >> >         Name (_HID, "PRP0001")
> > >> >
> > >> >         Name (_DSD, Package () {
> > >> >                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > >> >                 Package () {
> > >> >                         Package (2) {"compatible", "your-dt-compatible-string"},
> > >> >                 }
> > >> >         })
> > >> I think my description was not clear enough. The _DSD section is not
> > >> meant to identify the mailbox driver, but used by the acpi node that will
> > >> request the mailbox channel. The dts version would be as below.
> > >>
> > >>    mailbox: {
> > >>    }
> > >>
> > >>    user-mbox: {
> > >>       mboxes: <&mailbox 0>
> > >>    }
> > >>
> > >> The mboxes attribute in the user of the mbox has to specify the HID of the
> > >> mbox in order to retrieve channel pointer.
> > >
> > > Okay, then I think you can use reference instead of _HID, like
> > >
> > >         // The mailbox device
> > >         Device (MLBX) {
> > >         }
> > >
> > >         // User-mbox device
> > >         Device (USBX) {
> > >                 Name (_DSD, Package () {
> > >                         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > >                         Package () {
> > >                                 Package () {"mboxes", Package () {^^MLBX, 0}}),
> > >                         }
> > >                 })
> > >         }
> > 
> > Thanks, will try this. A side question on your previous reply. Would you
> > prefer a new driver using the PRP0001 or an actual proper HID.
> 
> If you have existing DT bindings for this, then PRP0001 is fine.
> Otherwise you should use the proper _HID for this particular device.

To be precise, PRP0001 specifically means "Use the 'compatible' property
to find the driver for this device", so if *that* is what you want to do,
you can use PRP0001 as the _HID.  For Windows (and such) compatibility, you
can provide a _CID whith a (list of) proper device ID(s) in addition to that.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
