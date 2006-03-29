From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: no /proc/acpi, trying to dump dsdt to a file
Date: Wed, 29 Mar 2006 11:05:04 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E04D4B332@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34604 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750705AbWC2TFd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2006 14:05:33 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: glen martin <lists@locutory.org>, linux-acpi@vger.kernel.org

I would be very interesting to see what windows does with this DSDT when
encountered. If you could get this and send it, it would help.

Windows puts the DSDT into the registry, under
HKEY_LOCAL_MACHINE/HARDWARE/ACPI/DSDT.



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of glen martin
> Sent: Wednesday, March 29, 2006 10:50 AM
> To: linux-acpi@vger.kernel.org
> Subject: Re: no /proc/acpi, trying to dump dsdt to a file
> 
> Yeah, no problem at all. What, Windows care about a broken dsdt? Bah
...
> :)
> 
> A number of folks have run into this dsdt problem with this and
related
> boards from ASUS. The instructions on how to deal suggest dumping and
> fixing the dsdt table,or grabbing a pre-fixed one from the repository
on
> SF.  I tried the repository, but the iasl compiler won't deal with it,
> so the next attempt was to dump and fix my existing broken table from
> the BIOS.
> 
> Thanks,
> 
> glen
> 
> 
> Moore, Robert wrote:
> 
> >Does this machine boot Windows ok?
> >
> >
> >>-----Original Message-----
> >>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >>owner@vger.kernel.org] On Behalf Of glen martin
> >>Sent: Wednesday, March 29, 2006 9:51 AM
> >>...
> >>kernel is 2.6.15, with gentoo patches and the patch to load a dsdt
from
> initrd.
> >>
> >>I'm trying to dump my dsdt, but there is no /proc/acpi, let alone
> >>/proc/acpi/dsdt.
> >>
> >>Is there something special needed to make /proc/acpi show up? Or
other
> >>way to get at the existing dsdt in this situation?
> >>
> >>
> <snip>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
