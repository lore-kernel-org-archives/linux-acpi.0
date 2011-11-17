From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] ACPICA: support Generic Address Structure bit_offset in acpi_read/write
Date: Fri, 18 Nov 2011 00:10:10 +0100
Message-ID: <201111180010.11173.rjw@sisk.pl>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com> <201111170027.14509.rjw@sisk.pl> <CAErSpo4TC-M31rp1fHw6ZsTHehAsXi-6eGmLEpNytiL-ez+iLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44770 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202Ab1KQXH3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Nov 2011 18:07:29 -0500
In-Reply-To: <CAErSpo4TC-M31rp1fHw6ZsTHehAsXi-6eGmLEpNytiL-ez+iLQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, bondd@us.ibm.com, Myron Stowe <myron.stowe@redhat.com>

On Thursday, November 17, 2011, Bjorn Helgaas wrote:
> On Wed, Nov 16, 2011 at 4:27 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, November 16, 2011, Bjorn Helgaas wrote:
> 
> >> We should try very hard to treat APEI generic address structures the
> >> same way as all others.  If that means some machines need firmware
> >> upgrades or some sort of quirks to work around BIOS bugs, we might
> >> have to accept that.  I think a single set of GAS accessors plus a few
> >> quirks that fix the GAS structures is far better than having
> >> APEI-specific GAS accessors that are basically tailored to a few
> >> broken machines.
> >
> > We can use APEI-specific wrappers around generic GAS accessors, though.
> 
> Yes, but IMHO, we should only need wrappers to support APEI-specific
> functionality, e.g., the mask.
> 
> Here's an attempt to lay out how I think acpi_read() and acpi_write()
> *should* work:
> 
> https://docs.google.com/spreadsheet/ccc?key=0AjvKas55tQpqdElKVXM2TEFVcnI3SjVuZ1pqUENMN1E
> 
> I think the proposed behavior is compatible with the APEI assumptions
> in the current code.  Please comment :)

Well, I'd express access_width in multiples of 8.  Or perhaps use a mask?

I'm afraid it may be difficult to get right by the callers, however.

Thanks,
Rafael
