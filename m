From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] mailbox: add ACPI support for mailbox framework
Date: Thu, 2 Apr 2015 12:07:02 +0300
Message-ID: <20150402090702.GD17830@lahna.fi.intel.com>
References: <1427836680-13008-1-git-send-email-fkan@apm.com>
 <20150401074553.GV1524@lahna.fi.intel.com>
 <CAL85gmDE5qD2tTABuz-6ccoVtnN4zN1Vbyyz+nQbdhT74UH37A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50529 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbbDBJHZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Apr 2015 05:07:25 -0400
Content-Disposition: inline
In-Reply-To: <CAL85gmDE5qD2tTABuz-6ccoVtnN4zN1Vbyyz+nQbdhT74UH37A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Kan <fkan@apm.com>
Cc: patches <patches@apm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Apr 01, 2015 at 10:01:45AM -0700, Feng Kan wrote:
> On Wed, Apr 1, 2015 at 12:45 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Tue, Mar 31, 2015 at 02:18:00PM -0700, Feng Kan wrote:
> >> This will add support for ACPI parsing of the mboxes attribute
> >> when booting with ACPI table. The client will have a attribute
> >> mimic the dts call "mboxes". In the ACPI case, the client will
> >> mark "mboxes" with the ACPI HID of the mbox it wishes to use.
> >>
> >>       Name (_DSD, Package () {
> >>               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >>               Package () {
> >>                       Package (2) {"mboxes", "ACPIHID"},
> >>               }
> >>       })
> >
> > Instead of this, why not match against the DT compatible property?
> >
> >         Name (_HID, "PRP0001")
> >
> >         Name (_DSD, Package () {
> >                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >                 Package () {
> >                         Package (2) {"compatible", "your-dt-compatible-string"},
> >                 }
> >         })
> I think my description was not clear enough. The _DSD section is not
> meant to identify the mailbox driver, but used by the acpi node that will
> request the mailbox channel. The dts version would be as below.
> 
>    mailbox: {
>    }
> 
>    user-mbox: {
>       mboxes: <&mailbox 0>
>    }
> 
> The mboxes attribute in the user of the mbox has to specify the HID of the
> mbox in order to retrieve channel pointer.

Okay, then I think you can use reference instead of _HID, like

	// The mailbox device
	Device (MLBX) {
	}

	// User-mbox device
	Device (USBX) {
		Name (_DSD, Package () {
			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
			Package () {
				Package () {"mboxes", Package () {^^MLBX, 0}}),
			}
		})
	}
