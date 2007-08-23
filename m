From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: Getting ACPI data like CPU and FBDIMM temperature / fan speeds on ASUS DSBV-DX/SAS
Date: Thu, 23 Aug 2007 17:08:59 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DEA1C5D2@pdsmsx414.ccr.corp.intel.com>
References: <6c18a4f0708191037g500342c7vec14ab2293ed9a2@mail.gmail.com> <823A93EED437D048963A3697DB0E35DE9CAEB5@pdsmsx414.ccr.corp.intel.com> <6c18a4f0708200747j3d38a808vbb87d469fd3a53ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56528 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757767AbXHWJJF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Aug 2007 05:09:05 -0400
Content-class: urn:content-classes:message
In-Reply-To: <6c18a4f0708200747j3d38a808vbb87d469fd3a53ba@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bernd Bartmann <bernd.bartmann@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hmm,
I found nothing interesting in your acpidump.
It seems that there are no ACPI fan/thermal devices in your bios.
In fact, many thermal/fan are ACPI transparent and they are controlled
by the bios or something else like hardware monitor.
Is there an obvious overheating problem on your system?

Thanks,
Rui

-----Original Message-----
From: Bernd Bartmann [mailto:bernd.bartmann@gmail.com] 
Sent: Monday, August 20, 2007 10:48 PM
To: Zhang, Rui
Cc: linux-acpi@vger.kernel.org
Subject: Re: Getting ACPI data like CPU and FBDIMM temperature / fan
speeds on ASUS DSBV-DX/SAS

On 8/20/07, Zhang, Rui wrote:
> First please set the ACPI version to 2.0 and see if there is any
> difference.
> And please attach the acpidump output when you are running ACPI 2.0.

Still no data in /proc/acpi/thermal_zone after switching to ACPI 2.0
in the BIOS.
The requested output of acpidump is attached.

Best regards,
Bernd.
