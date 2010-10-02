From: Allan Kelly <allankelly@gmail.com>
Subject: Re: Toshiba C650-194 ACPI bug - regression
Date: Sat, 2 Oct 2010 21:46:46 +0100
Message-ID: <AANLkTi=Jn7kRpDvE4YUgLZe1yxBCZdcFYo0oUpov+PXx@mail.gmail.com>
References: <AANLkTin3mtDm9x=8E_b_0FDWdwzbU570x1Ok-btMBPiF@mail.gmail.com>
	<AANLkTi=j75zW-8NFtt8w-z8zQrL7Y_esQD6iLEcCyP00@mail.gmail.com>
	<alpine.LFD.2.00.1010012243430.2293@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49892 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab0JBUqr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Oct 2010 16:46:47 -0400
Received: by qwh6 with SMTP id 6so2214494qwh.19
        for <linux-acpi@vger.kernel.org>; Sat, 02 Oct 2010 13:46:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010012243430.2293@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Glad to help Len.

BTW, what is going on here? Is there a thread where this is explained?
Seems the BIOS deliberately alters the DSDT after initialisation. Do
we know why? Does it do it for Win OSs?

Also, I see that for kernels >= 2.6.35 the boot argument
acpi=copy_dsdt is available which it sounds like it should cause the
same behaviour as this patch. Is that right? In which case I can start
to use that with standard distros once the appropriate kernel level is
distributed for Ubuntu.

Many thanks, al.

On 2 October 2010 03:45, Len Brown <lenb@kernel.org> wrote:
> Thanks for confirming the patch works, Allan,
>
> It shipped upstream in 2.6.36-rc6-git2
> and I just sent a note for Greg to consider it for .stable
>
> cheers,
> Len Brown, Intel Open Source Technology Center
>
>
