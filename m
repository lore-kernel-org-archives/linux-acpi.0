From: Thomas Renninger <trenn@suse.de>
Subject: False positive iasl compiler error on resource object?
Date: Fri, 10 Sep 2010 11:33:31 +0200
Message-ID: <201009101133.31663.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59757 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262Ab0IJJde (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Sep 2010 05:33:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devel@acpica.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com

I have a machine with a _CRS function which shows:

Method (_CRS, 0, NotSerialized)
{
    Name (XY0, ResourceTemplate ()
    {
             WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                        0x0000,             // Granularity
                        0x0000,             // Range Minimum
                        0x0000,             // Range Maximum
                        0x0000,             // Translation Offset
                        0x0000,             // Length
                        ,, _Y10, TypeStatic)
     }
This produces the compiler error:
DSDT.dsl.orig  2364:                         0x0000,             // Length
Error    4122 -                                   ^ Invalid combination of Length and Min/Max fixed flags

Because iasl thinks this hits this condition:
Advanced Configuration and Power Interface Specification
Revision 3.0b October 10, 2006
6.4.3.5 Address Space Resource Descriptors
Table 6-38 Valid combination of Address Space Descriptors fields
..
_LEN   _MIF      _MAF           Definition
0           1            1             (Illegal combination)

But the _CRS function can still fill up the length of this resource object
parts while _CRS gets executed (and the compiler probably does not
take this into account), by e.g.:
                CreateWordField (XY0, \_SB.PCI0._CRS._Y10._LEN, LEN9)
                Store (Local0, LEN9)
and the resource, returned to OS, might fulfill the ACPI specification and
return a valid length, _MIF, _MAF combination:
_LEN   _MIF      _MAF           Definition
  >0       1           1              Fixed size, fixed location resource descriptor.
                                          _GRA must be 0 and _LEN must be (_MAX - _MIN +1).

I wonder whether my above assumptions are correct and the
Error 4122 should get removed from the iasl compiler, at least in this case?

Thanks,

       Thomas
