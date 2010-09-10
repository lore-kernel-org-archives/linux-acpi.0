From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [Devel] False positive iasl compiler error on resource object?
Date: Fri, 10 Sep 2010 08:04:34 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858AF0CA981@orsmsx503.amr.corp.intel.com>
References: <201009101133.31663.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20821 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab0IJPEj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Sep 2010 11:04:39 -0400
In-Reply-To: <201009101133.31663.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "devel@acpica.org" <devel@acpica.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>

We've provided the -cr option to disable the resource descriptor error checking.

This is an interesting problem. On one hand, we would like to provide static (compile time) error checking as much as possible. On the other hand, the resource descriptors (as well as most any other ASL/AML object) can be dynamically changed.

We've seen many ACPI tables with invalid resource descriptors (at both compile time and runtime), and that is the reason the resource descriptor validation was added to the compiler in the first place.

I don't want to just remove this validation, but yes, perhaps iASL should be able to recognize that this descriptor may be modified at runtime and therefore a static validation cannot be performed.

There are at least a few indicators:

1) The descriptor is basically all zeroes
2) There is a CreateXxxField reference to the descriptor
3) There is a Store to the created field

So, perhaps we could detect the above conditions and then disable validation for this particular descriptor. Note, conditions (2) and (3) may be difficult to detect.

I'm open to suggestions.

Bob


>-----Original Message-----
>From: devel-bounces@acpica.org [mailto:devel-bounces@acpica.org] On Behalf
>Of Thomas Renninger
>Sent: Friday, September 10, 2010 2:34 AM
>To: devel@acpica.org
>Cc: linux-acpi@vger.kernel.org; bjorn.helgaas@hp.com
>Subject: [Devel] False positive iasl compiler error on resource object?
>
>I have a machine with a _CRS function which shows:
>
>Method (_CRS, 0, NotSerialized)
>{
>    Name (XY0, ResourceTemplate ()
>    {
>             WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode,
>EntireRange,
>                        0x0000,             // Granularity
>                        0x0000,             // Range Minimum
>                        0x0000,             // Range Maximum
>                        0x0000,             // Translation Offset
>                        0x0000,             // Length
>                        ,, _Y10, TypeStatic)
>     }
>This produces the compiler error:
>DSDT.dsl.orig  2364:                         0x0000,             // Length
>Error    4122 -                                   ^ Invalid combination of
>Length and Min/Max fixed flags
>
>Because iasl thinks this hits this condition:
>Advanced Configuration and Power Interface Specification
>Revision 3.0b October 10, 2006
>6.4.3.5 Address Space Resource Descriptors
>Table 6-38 Valid combination of Address Space Descriptors fields
>..
>_LEN   _MIF      _MAF           Definition
>0           1            1             (Illegal combination)
>
>But the _CRS function can still fill up the length of this resource object
>parts while _CRS gets executed (and the compiler probably does not
>take this into account), by e.g.:
>                CreateWordField (XY0, \_SB.PCI0._CRS._Y10._LEN, LEN9)
>                Store (Local0, LEN9)
>and the resource, returned to OS, might fulfill the ACPI specification and
>return a valid length, _MIF, _MAF combination:
>_LEN   _MIF      _MAF           Definition
>  >0       1           1              Fixed size, fixed location resource
>descriptor.
>                                          _GRA must be 0 and _LEN must be
>(_MAX - _MIN +1).
>
>I wonder whether my above assumptions are correct and the
>Error 4122 should get removed from the iasl compiler, at least in this
>case?
>
>Thanks,
>
>       Thomas
>_______________________________________________
>Devel mailing list
>Devel@acpica.org
>http://lists.acpica.org/listinfo/devel
