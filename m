From: Len Brown <len.brown@intel.com>
Subject: Re: Blacklisted system / blacklisting bad
Date: Wed, 20 Sep 2006 00:55:42 -0400
Message-ID: <200609200055.42958.len.brown@intel.com>
References: <200609031134.33024.dieter.jurzitza@t-online.de>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:23244 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751165AbWITExy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Sep 2006 00:53:54 -0400
In-Reply-To: <200609031134.33024.dieter.jurzitza@t-online.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dieter Jurzitza <dieter.jurzitza@t-online.de>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>

On Sunday 03 September 2006 05:34, Dieter Jurzitza wrote:

> I recently got a HP VISUALIZE NT workstation, using 2x 1GHz PIII processors 
>. After installation ACPI was always  disabled, the on board USB interface did not work
>(kernel 2.6.11.4 (SuSE  linux 9.3)
> 
> I tested using acpi=force on the commandline and that solved two problems:
> 
> 1.) shutdown -h now switches the machine off (should be expected :-):-) )
> 2.) much more important: the onboard USB interface works now.
> 
> After patching dmi_scan.c and removing the blacklist-entry I get the following 
> message at boot time:
....

ACPI is necessary to get the interrupts right for USB to work on this box.
pci=noacpi and acpi=ht will cause ACPI to be disabled for interrupt routing
and thus USB will fail with those.

As Luming pointed out, Shaohua's _CRS workaround for the _BBN BIOS bug
is what your system needed, and that is why "acpi=force" is working.
It seems that perhaps the DMI blacklist entry pre-dated that workaround.

Please verify that 2.6.18-rc7 works with "acpi=force" on this box,
and if it does, please send me a patch to remove the entry in that kernel.

thanks,
-Len
