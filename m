From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.4.22-xx powerdown oddities
Date: Wed, 3 Sep 2003 23:55:57 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCFA@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Luciano Miguel Ferreira Rocha <luciano-4DQciVFCGxiGR49JTXTXkA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Luciano,
This does sound like a regression.
Can I trouble you to dump the info into a bugzilla report so we can make
sure it stays in the queue and gets fixed?

Thanks,
-Len
---
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


> -----Original Message-----
> From: Luciano Miguel Ferreira Rocha [mailto:luciano-4DQciVFCGxiGR49JTXTXkA@public.gmane.org] 
> Sent: Friday, August 22, 2003 12:25 PM
> To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: 2.4.22-xx powerdown oddities
> 
> 
> 
> Hello,
> 
> I have a problem powering down my Asus L8400 laptop with kernels
> 2.4.22-xx. While 2.4.21 worked OK (with vanilla ACPI or sf.net acpi),
> 2.4.22-pre8, 2.4.22-pre10, 2.4.22-rc2, 2.4.22-rc2-ac1 and 2.4.22-dis7
> (my current one) show the same problem.
> 
> The problem is that instead of powering down, after "Power 
> down." shows up,
> the kernel shows:
> 
> nsc-ircc, Suspending
> Trying to free free IRQ3
> Trying to free free DMA3
