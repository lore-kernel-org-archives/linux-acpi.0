From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Where do I send APIC victims?
Date: Wed, 3 Sep 2003 06:16:29 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCEC@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

If interrupts work with acpi=off, but otherwise don't, then:

--begin quote--

Please file a bug at http://bugzilla.kernel.org/
Category: Power Management
Componenet: ACPI

Please attach the output from dmidecide, available in /usr/sbin/, or
here: 
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar
.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.

--end quote--

This answer is the same no matter who built the system.

Thanks,
-Len

Ps. Needless to say, this is a hot issue and has become hotter as more
people are enabling ACPI.   There are a number of bugs open on this
topic already with fixes in the works -- so check for dupes.


> -----Original Message-----
> From: Roger Luethi [mailto:rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org] 
> Sent: Wednesday, September 03, 2003 4:09 AM
> To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Where do I send APIC victims?
> 
> 
> As the maintainer of via-rhine, I get bug reports that almost in their
> entirety are "fixed" by turning off APIC and/or ACPI. This 
> has been going
> on for several months now. Every now and then, something 
> promising gets
> posted on LKML, but so far if anything I've seen an 
> _increase_ in those bug
> reports. Maybe a fix is floating around and this will be a 
> non-issue RSN. I
> simply can't tell, since I don't have any IO-APIC hardware to 
> play with.
> 
> Instead of just telling everybody to turn off APIC, I'd like 
> to point bug
> reporters to the proper place and tell them what information 
> they should
> provide so it can get fixed for real. According to 
> MAINTAINERS, Ingo Molnar
> does Intel APIC, but the problems are with VIA chip sets. So 
> where do I
> send my users? Any takers?
> 
> Roger
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
