From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Missing PSB or _PSS in BIOS
Date: Sun, 19 Feb 2006 02:50:05 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30061F41E8@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:54764 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932232AbWBSHuU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Feb 2006 02:50:20 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: legoll@online.fr, linux-acpi@vger.kernel.org
Cc: cpufreq@lists.linux.org.uk


>I'm using an opteron 165 (dual-core) which frequency/voltage should
>be able to be scaled, but unfortunately the latest BIOS for my 
>motherboard
>lacks the frequency transition tables needed by powernow-k8.c
>
>as shown by the boot message:
>powernow-k8: MP systems not supported by PSB BIOS structure
>powernow-k8:  BIOS error - no PSB or ACPI _PSS objects
>
>Would it be possible to write suitable ACPI _PSS from AMD processor 
>documentation ?
>Or take the infos from some other ACPI BIOS which has support, and put 
>it in mine ?
>
>And use the "ACPI load custom DSDT" kernel option to get the 
>patched one 
>used by the
>powernow-k8 driver ?
>
>I found a lot of infos about fixing glitches in DSDT but could 
>not find 
>anything
>about adding missing  _PSS entries...
>
>Would that be dangerous ?
>
>Is there something else I could do ?
>I don't think I'll get an answer from the vendor, even if I tried...

Sure it is possible.

It is only dangerous if you care about the data on the machine.
Presumably the vendor had a reason not to enable this feature...

-Len
