From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Toshiba Tecra vs ACPI
Date: Thu, 21 Aug 2003 20:30:23 -0400
Sender: linux-laptop-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCAD@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-laptop-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: linux-laptop-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Does anybody have a Toshiba Tecra that boots an ACPI-enabled kernel?
If yes, can you send me the output from dmidecode so that I can identify
the BIOS date?
http://www.nongnu.org/dmidecode/  (I'd also be intersted in the output
of acpidmp)

I've found that the Tecra 8100 has AML bugs that we can't handle
(missing return statements when they are required).  And we will not be
able to handle them any time soon (w/o a DSDT over-ride).

So I'm thinking about black-listing the 8100 by default; and the 8000
and 8200 may be right behind it.  Unfortunately, the DMI info for the
8100 has an empty product name under system information, where one would
expect to see "Tecra 8100".  So I'm thinking about disabling ACPI by
default on all systems with DMI BIOS vendor "TOSHIBA", BIOS Release Date
<= 10/07/2002 -- the date of the latest BIOS for the 8100; and Base
Board product name "Portable PC".

Thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-laptop" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
