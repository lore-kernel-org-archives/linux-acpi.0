From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] ACPICA: support Generic Address Structure bit_offset
 in acpi_read/write
Date: Wed, 16 Nov 2011 16:59:41 -0700
Message-ID: <CAErSpo4TC-M31rp1fHw6ZsTHehAsXi-6eGmLEpNytiL-ez+iLQ@mail.gmail.com>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
 <201111151749.53917.trenn@suse.de> <CAErSpo6E6ZLRMhLjE1zHjth=gO-LrhnTz=msRjY7mfG4ckCLfw@mail.gmail.com>
 <201111170027.14509.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57558 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505Ab1KQAAD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2011 19:00:03 -0500
Received: by ggnb2 with SMTP id b2so353147ggn.19
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2011 16:00:02 -0800 (PST)
In-Reply-To: <201111170027.14509.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, bondd@us.ibm.com, Myron Stowe <myron.stowe@redhat.com>

On Wed, Nov 16, 2011 at 4:27 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, November 16, 2011, Bjorn Helgaas wrote:

>> We should try very hard to treat APEI generic address structures the
>> same way as all others. =A0If that means some machines need firmware
>> upgrades or some sort of quirks to work around BIOS bugs, we might
>> have to accept that. =A0I think a single set of GAS accessors plus a=
 few
>> quirks that fix the GAS structures is far better than having
>> APEI-specific GAS accessors that are basically tailored to a few
>> broken machines.
>
> We can use APEI-specific wrappers around generic GAS accessors, thoug=
h.

Yes, but IMHO, we should only need wrappers to support APEI-specific
functionality, e.g., the mask.

Here's an attempt to lay out how I think acpi_read() and acpi_write()
*should* work:

https://docs.google.com/spreadsheet/ccc?key=3D0AjvKas55tQpqdElKVXM2TEFV=
cnI3SjVuZ1pqUENMN1E

I think the proposed behavior is compatible with the APEI assumptions
in the current code.  Please comment :)

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
