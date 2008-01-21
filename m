From: Len Brown <lenb@kernel.org>
Subject: Re: Please send dmidecode to linux-acpi@vger.kernel.org - Compal HEL8X
Date: Mon, 21 Jan 2008 00:25:04 -0500
Message-ID: <200801210025.04430.lenb@kernel.org>
References: <620719eb0711040521v5503be45y1c06d725fa348b87@mail.gmail.com> <200801190005.38246.lenb@kernel.org> <620719eb0801191342w2acdfbafs6422853c5e6767f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33893 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbYAUFZW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 00:25:22 -0500
In-Reply-To: <620719eb0801191342w2acdfbafs6422853c5e6767f0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josue Resende <josue.resende@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 16:42, Josue Resende wrote:

> 2008/1/19, Len Brown <lenb@kernel.org>:
> > On Sunday 04 November 2007 08:21, Josue Resende wrote:
> > > System Information
> > > Manufacturer: COMPAL
> > > Product Name: HEL81I
> > > Version: *
> > > Serial Number: 2057336701224
> > > UUID: 5D703279-5869-11DB-9D7E-0016D457FA87
> > > Wake-up Type: Power Switch
> > > SKU Number: Not Specified
> > > Family: Not Specified
> > >
> > > Handle 0x0002, DMI type 2, 8 bytes
> > > Base Board Information
> > > Manufacturer: COMPAL
> > > Product Name: HEL8X

thanks for the acpidump

Please verify that your battery information and AC/DC
transitions are properly reported in /proc/acpi/
both with and without acpi_osi=Linux

-Len
-------------

    Name (ECDY, 0x05)
...
           If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (0x03E8, OSYS)
## setting OSYS is a NOP, since it gets overwritten
                    Store (Zero, ECDY)
## clearing ECDY may have implications in wakeup,
## battery, and some ACPI general purpose events
                }

                If (_OSI ("Windows 2001"))
                {
                    Store (0x07D1, OSYS)
