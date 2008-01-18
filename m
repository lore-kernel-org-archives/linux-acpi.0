From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode
Date: Fri, 18 Jan 2008 14:52:21 -0500
Message-ID: <200801181452.21179.lenb@kernel.org>
References: <184fd4090801170441r6d93157gfa1548b737a796c4@mail.gmail.com> <184fd4090801170443r512ec5a9w6a8984c4fe25fbbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44878 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761706AbYARTwh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 14:52:37 -0500
In-Reply-To: <184fd4090801170443r512ec5a9w6a8984c4fe25fbbd@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yurij Perepelytsia <yurij.perepelytsia@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 17 January 2008 07:43, Yurij Perepelytsia wrote:
> Hello,
> 
> in my log file I've found "Please send dmidecode to
> linux-acpi@vger.kernel.org" my laptop is Samsung R40Plus R40XY0E.
> Here is copy past of that.

Thank you Yurij.
Does  your system behave any differently when booted with this?:

acpi_osi=Linux

please e-mail me the output from acpidump.

thanks,
-Len

> yura:/home/yura# dmidecode
> # dmidecode 2.9

> 
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>     Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
>     Product Name: R40P/R41P
>     Version: 06YE
>     Serial Number: 967Y93FP800126
>     UUID: 20B7E72E-D21D-B211-8000-9F20205EAF5B
>     Wake-up Type: Power Switch
>     SKU Number: Not Specified
>     Family: Not Specified
> 
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
>     Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
>     Product Name: R40P/R41P
>     Version:
>     Serial Number: 123490EN400015
> 
