From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI support for optee driver
Date: Thu, 21 Sep 2017 09:44:16 +0300
Message-ID: <20170921064416.GJ4630@lahna.fi.intel.com>
References: <CAL-zptO3xg4k_B_S1SfKOghHGAUjqp56W9vqDdV3xgpUJ6b8dQ@mail.gmail.com>
 <20170920103918.GA4630@lahna.fi.intel.com>
 <CAL-zptMbqW7opSFgsF-gd9icu1p9qYcFVt1GM6vrKB3JAPQ_+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49414 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbdIUGu7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Sep 2017 02:50:59 -0400
Content-Disposition: inline
In-Reply-To: <CAL-zptMbqW7opSFgsF-gd9icu1p9qYcFVt1GM6vrKB3JAPQ_+A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mayuresh Chitale <mchitale@apm.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, linux-acpi@vger.kernel.org

On Wed, Sep 20, 2017 at 10:07:05PM +0530, Mayuresh Chitale wrote:
> On 9/20/17, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > On Wed, Sep 20, 2017 at 02:17:38PM +0530, Mayuresh Chitale wrote:
> >> Hi,
> >>
> >> I am working on adding APCI support to optee kernel driver and was
> >> considering implementing it in the following way:
> >>
> >> - An optee device node would be added to the bios as follows:
> >> Device(OPTE) {
> >>       Name(_HID, ...)
> >>       Name(_CID, ...)
> >>       Name(_DDN, ...)
> >>       Name (_DSD, Package () {
> >>           Package () {
> >>             Package (2) {"method", "smc"}
> >>           }
> >
> > This _DSD is malformed as it is missing UUID.
> Actually it is present in the code. I just wanted to present the
> required details. Sorry for the ambiguity.
> >
> >>       })
> >>     }
> >>
> >> - The optee kernel driver would then search for \\SB.OPTE device using
> >> acpi_get_handle and parse the node to get the conduit method.
> >
> > You can use the standard device_property_* (see
> > include/linux/property.h) accessors which fully support _DSD device
> > properties.
> >
> >> I was wondering if this is the correct way to implement it and if so
> >> do I need to get the OPTE device registered?  Your feedback is really
> >> appreciated.
> >
> > There is something documented here:
> >
> > Documentation/acpi/DSD-properties-rules.txt
> >
> In DT, the optee node is placed under the firmware directory but I
> dont think there is any equivalent to that in ACPI so I added the
> 'OPTE' node. I was wondering if this needs to be registered with
> UEFI/ACPI forum.

No, I don't think ACPI node names need to be registered anywhere. Just
as long as you don't use the reserved ones, like _SB and PCI0 and on.
