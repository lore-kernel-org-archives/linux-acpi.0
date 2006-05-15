From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: DSDT on Averatec 1050
Date: Mon, 15 May 2006 08:46:55 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A444E388@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32134 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751576AbWEOPzR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2006 11:55:17 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Wagner <paul_spam@gmx.at>, linux-acpi@vger.kernel.org
Cc: trenn@suse.de

>From dmesg:
> ACPI: Subsystem revision 20050408

> ACPI-0142: *** Error: Store into Alias - should never happen


I believe this problem was fixed in 20060127:

27 January 2006. Summary of changes for version 20060127:

1) ACPI CA Core Subsystem:

Fixed a problem where Alias ASL operators are sometimes not correctly
resolved, in both the interpreter and the iASL compiler.


> -----Original Message-----
> From: Paul Wagner [mailto:paul_spam@gmx.at]
> Sent: Monday, May 15, 2006 4:53 AM
> To: linux-acpi@vger.kernel.org
> Cc: Moore, Robert; trenn@suse.de
> Subject: Re: DSDT on Averatec 1050
> 
> Robert, Thomas,
> 
> attached you'll find the raw dsdt, the output of acpidump and dmesg.
> 
> Note: This was my first try on a self-compiled kernel, and apparently
I
> forgot some things (e.g. NTFS support, which is requested by an
> fstab-entry). Some modules seem to be missing, too. But I suppose that
> these errors are unrelated to the ACPI troubles.
> 
> Thanks for your support,
> 
> Paul
