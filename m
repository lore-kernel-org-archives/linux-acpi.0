From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] mailbox: add ACPI support for mailbox framework
Date: Tue, 7 Apr 2015 11:41:43 +0300
Message-ID: <20150407084143.GP17830@lahna.fi.intel.com>
References: <1427836680-13008-1-git-send-email-fkan@apm.com>
 <20150401074553.GV1524@lahna.fi.intel.com>
 <CAL85gmDE5qD2tTABuz-6ccoVtnN4zN1Vbyyz+nQbdhT74UH37A@mail.gmail.com>
 <20150402090702.GD17830@lahna.fi.intel.com>
 <CAL85gmA1mjcX6FEmUHipn0iSzpti2z6D4++7Q3gxGiPGZaE_Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL85gmA1mjcX6FEmUHipn0iSzpti2z6D4++7Q3gxGiPGZaE_Cw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Kan <fkan@apm.com>
Cc: patches <patches@apm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 02, 2015 at 11:04:24AM -0700, Feng Kan wrote:
> On Thu, Apr 2, 2015 at 2:07 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Wed, Apr 01, 2015 at 10:01:45AM -0700, Feng Kan wrote:
> >> On Wed, Apr 1, 2015 at 12:45 AM, Mika Westerberg
> >> <mika.westerberg@linux.intel.com> wrote:
> >> > On Tue, Mar 31, 2015 at 02:18:00PM -0700, Feng Kan wrote:
> >> >> This will add support for ACPI parsing of the mboxes attribute
> >> >> when booting with ACPI table. The client will have a attribute
> >> >> mimic the dts call "mboxes". In the ACPI case, the client will
> >> >> mark "mboxes" with the ACPI HID of the mbox it wishes to use.
> >> >>
> >> >>       Name (_DSD, Package () {
> >> >>               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >> >>               Package () {
> >> >>                       Package (2) {"mboxes", "ACPIHID"},
> >> >>               }
> >> >>       })
> >> >
> >> > Instead of this, why not match against the DT compatible property?
> >> >
> >> >         Name (_HID, "PRP0001")
> >> >
> >> >         Name (_DSD, Package () {
> >> >                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >> >                 Package () {
> >> >                         Package (2) {"compatible", "your-dt-compatible-string"},
> >> >                 }
> >> >         })
> >> I think my description was not clear enough. The _DSD section is not
> >> meant to identify the mailbox driver, but used by the acpi node that will
> >> request the mailbox channel. The dts version would be as below.
> >>
> >>    mailbox: {
> >>    }
> >>
> >>    user-mbox: {
> >>       mboxes: <&mailbox 0>
> >>    }
> >>
> >> The mboxes attribute in the user of the mbox has to specify the HID of the
> >> mbox in order to retrieve channel pointer.
> >
> > Okay, then I think you can use reference instead of _HID, like
> >
> >         // The mailbox device
> >         Device (MLBX) {
> >         }
> >
> >         // User-mbox device
> >         Device (USBX) {
> >                 Name (_DSD, Package () {
> >                         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >                         Package () {
> >                                 Package () {"mboxes", Package () {^^MLBX, 0}}),
> >                         }
> >                 })
> >         }
> 
> Thanks, will try this. A side question on your previous reply. Would you
> prefer a new driver using the PRP0001 or an actual proper HID.

If you have existing DT bindings for this, then PRP0001 is fine.
Otherwise you should use the proper _HID for this particular device.
