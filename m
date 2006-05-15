From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Output ACPI info via sysfs
Date: Mon, 15 May 2006 18:21:31 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB675A9C4@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37250 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S965020AbWEOWWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2006 18:22:18 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Jones <pjones@redhat.com>
Cc: linux-acpi@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>, "Moore, Robert" <robert.moore@intel.com>

I see.
the /dev/mem reader tickles some hardware wrong in some cases.

>The other vendor's hardware _sometimes_ has bad data in the XSDT if
>you've got more than 1G of ram, and I've now got workarounds in my
>parser for it -- but the kernel doesn't have those, and it works just
>fine.  Dunno why this is happening, but the BIOS guys at that 
>vendor are looking into it.  Just FWIW, acpidump has the same
>failure as the code I've got (both were hacked up from the kernel code)
> -- on my 4G box it tries to read 4026571728 bytes at 0x2b858abbd0 ,
which is 
>clearly bogus.

sure looks like a wrap-around or a sign bug, being so close to 4GB.

Is this still true for acpidump in the latest pmtools here?:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Bob,
the latest, 20051111, is indeed based on the ACPICA headers.

>But when the kernel is parsing the tables, it's getting the right data.
>I really have no idea what's happening on that hardware.  I suspect a
>bus analyzer is needed to tell for sure what's going on.

I can't explain why the kernel works and the latest acpidump doesn't,
but I'm willing to help fix the latest acpidump so it does.

>...
>I still don't think it's the best idea -- poking around
>in /dev/mem is ugly and bug-prone.  Doing this probe in userland means
>we've got two sets of code to parse the same thing, which pretty much
>always leads to bug fixes that fail to be applied to both sets of code.
>So that means I've essentially got to track changes to what the kernel
>parsing code (or some library-ized version of pmtools) in order to get
>bug fixes.  This is a maintenance nightmare!

On the grand scale of nigthmares, this is not a big one.
This code nearly never changes.  Also, the user-land utility
can work even when the kernel is broken.

I don't really see a case to bloat the kernel here.
Perhaps all the user-space parser needs it a reliable
physical address for the MADT?

-Len
