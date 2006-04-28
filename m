From: "Brown, Len" <len.brown@intel.com>
Subject: RE: hello
Date: Fri, 28 Apr 2006 04:36:43 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB64A432B@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11624 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030371AbWD1Igr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Apr 2006 04:36:47 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Teo <teo.ubuntu@yahoo.com>
Cc: linux-acpi@vger.kernel.org

 
>on my machine kernel was in panic. The main reason is
>somewhere in ACPI package. If I disable ACPI then it
>works.

Teo,
is is possible to capture the panic messages,
either through a serial console capture or
a digital picture of the screen?

If yes, go ahead and open a bug and attach them to it here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

the output from dmesg -s64000 with the working "acpi=off"
might also be useful.
 
The first question we'll need to answer is if this is
something that worked in an earlier version of Linux
and has just broken, or if this has always not worked
on this box.

Depending on how it fails, there may be some workarounds
that will
A) help make your system more useful
B) help debug the failure.

eg. try booting with "acpi=noirq" and seeing if that makes a difference.

thanks,
-Len
