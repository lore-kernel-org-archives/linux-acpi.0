From: "Bernd Bartmann" <bernd.bartmann@gmail.com>
Subject: Re: Getting ACPI data like CPU and FBDIMM temperature / fan speeds on ASUS DSBV-DX/SAS
Date: Thu, 23 Aug 2007 11:16:10 +0200
Message-ID: <6c18a4f0708230216t1f22d0bbyea2d64f8aaded5c1@mail.gmail.com>
References: <6c18a4f0708191037g500342c7vec14ab2293ed9a2@mail.gmail.com>
	 <823A93EED437D048963A3697DB0E35DE9CAEB5@pdsmsx414.ccr.corp.intel.com>
	 <6c18a4f0708200747j3d38a808vbb87d469fd3a53ba@mail.gmail.com>
	 <823A93EED437D048963A3697DB0E35DEA1C5D2@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:53464 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758750AbXHWJQL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Aug 2007 05:16:11 -0400
Received: by wa-out-1112.google.com with SMTP id j4so498748wah
        for <linux-acpi@vger.kernel.org>; Thu, 23 Aug 2007 02:16:10 -0700 (PDT)
In-Reply-To: <823A93EED437D048963A3697DB0E35DEA1C5D2@pdsmsx414.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

On 8/23/07, Zhang, Rui wrote:
> Hmm,
> I found nothing interesting in your acpidump.
> It seems that there are no ACPI fan/thermal devices in your bios.
> In fact, many thermal/fan are ACPI transparent and they are controlled
> by the bios or something else like hardware monitor.
> Is there an obvious overheating problem on your system?

No there is no overheating. I just wanted to make sure that acpid gets
all the correct information. But in case there will be a temperature
problem in the future how can the system shutdown automatically if
acpid gets no data? Maybe I should ask ASUS directly?

Best regards,
Bernd
