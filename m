From: Rodrigo Luiz <rodrigo@gus-mg.org>
Subject: Re: sony-laptop: ACPI Exception when a Fn-Key is pressed
Date: Tue, 7 Apr 2009 16:46:20 -0300
Message-ID: <7a3045780904071246s6371663ds60f187c4dacdb005@mail.gmail.com>
References: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com>
	 <20090406110154.GA25085@kamineko.org>
	 <alpine.LFD.2.00.0904070102450.5698@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f160.google.com ([209.85.217.160]:48966 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759571AbZDGTqW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 15:46:22 -0400
Received: by gxk4 with SMTP id 4so6180086gxk.13
        for <linux-acpi@vger.kernel.org>; Tue, 07 Apr 2009 12:46:20 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904070102450.5698@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org, robert.moore@intel.com

On Sun, Apr 5, 2009 at 21:27, Rodrigo Luiz <rodrigo@gus-mg.org> wrote:
>
> ACPI Error (hwvalid-0186): Denied AML access to port 0x00000080/4
> (DMA1 0x0081-0x0083) [20090320]
> ACPI Exception (evregion-0422): AE_AML_ILLEGAL_ADDRESS, Returned by
> Handler for [SystemIO] [20090320]
> ACPI Error (psparse-0537): Method parse/execution failed [\P8XH] (Node
> f7418c30), AE_AML_ILLEGAL_ADDRESS
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.LPCB.EC__._Q58] (Node f741bc00), AE_AML_ILLEGAL_ADDRESS
> ACPI Error (hwvalid-0186): Denied AML access to port 0x00000080/4
> (DMA1 0x0081-0x0083) [20090320]
> ACPI Exception (evregion-0422): AE_AML_ILLEGAL_ADDRESS, Returned by
> Handler for [SystemIO] [20090320]
> ACPI Error (psparse-0537): Method parse/execution failed [\P8XH] (Node
> f7418c30), AE_AML_ILLEGAL_ADDRESS
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.LPCB.EC__._Q59] (Node f741bc18), AE_AML_ILLEGAL_ADDRESS
>
>

Using git bisect, I found the first bad commit:

7f0719039085cc40114abce84cf29fe57da226f4 is first bad commit
commit 7f0719039085cc40114abce84cf29fe57da226f4
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Mar 19 09:37:47 2009 +0800

    ACPICA: New: I/O port protection

    Protect certain I/O ports from reads/writes. Provides MS
    compatibility. New module, hwvalid.c

    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>


My mistake. The issue is with acpi, not with sony-laptop.

I did more tests, now with not loading sony-laptop. When I close/open
lid or when I press the power button, I see these same exceptions.

I tried to revert the patch, without success.


-- 
[]'s
Rodrigo Luiz
