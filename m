From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_osi Linux report and questions
Date: Thu, 13 Dec 2007 16:06:58 -0500
Message-ID: <200712131606.58331.lenb@kernel.org>
References: <4760BDDC.60602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60011 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932726AbXLMVHM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Dec 2007 16:07:12 -0500
In-Reply-To: <4760BDDC.60602@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jason hu <huzhijiang@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 13 December 2007 00:06, jason hu wrote:
> Hi All,
> 
> With acpi_osi=Linux, which dmesg suggested, I got something changed in 
> the dmesg output(I just listed out the most important things):
> 
> 
> diff !Linux Linux
> 79c80
> < Detected 1733.505 MHz processor.
> ---
>  > Detected 1733.456 MHz processor.
> 95c96
> < Calibrating delay using timer specific routine.. 3470.37 BogoMIPS 
> (lpj=1735185)
> ---
>  > Calibrating delay using timer specific routine.. 3470.36 BogoMIPS 
> (lpj=1735181)
> 121c122
> < Calibrating delay using timer specific routine.. 3466.35 BogoMIPS 
> (lpj=1733178)
> ---
>  > Calibrating delay using timer specific routine.. 3466.36 BogoMIPS 
> (lpj=1733183)

These are not important.

> < PCI: Cannot allocate resource region 7 of bridge 0000:00:06.0
> < PCI: Cannot allocate resource region 8 of bridge 0000:00:06.0
> 207c206
> <   MEM window: disabled.
> ---
>  >   MEM window: c0100000-c01fffff

These may be important.

> It seems with acpi_osi=Linux, it mainly made the two processors equals 
> in BogoMIPS and made a PCI device window available.
> 
> I am not so familiar with ACPI, so can you tell me what is 
> acpi_osi=Linux used for, and why it made such changes above? Thank you!

The BIOS uses it to figure out if the OS is compatible with the
capabilities of Linux.  Unfortunately, the capabilities of Linux
are changing over time, and mose BIOS detection of Linux leads
to worse behaviour rather than better...

Please file a bug report.
attach the output from acpidump, both dmesg, and the dmidecode output.

thanks,
-Len
