From: "Natalie Protasevich" <protasnb@gmail.com>
Subject: Re: FW: [PATCH] i386: irq: Kill IRQ compression
Date: Fri, 16 Feb 2007 02:41:51 -0700
Message-ID: <32209efe0702160141k32f16923qdf93abdf5d473886@mail.gmail.com>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0E21@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:62697 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966267AbXBPJlx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Feb 2007 04:41:53 -0500
Received: by wr-out-0506.google.com with SMTP id i21so979413wra
        for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2007 01:41:52 -0800 (PST)
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0E21@USRV-EXCH4.na.uis.unisys.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: lenb@kernel.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

l> From: Eric W. Biederman [mailto:ebiederm@xmission.com]
> Sent: Friday, February 16, 2007 2:22 AM
> To: Protasevich, Natalie
> Cc: Len Brown; Andi Kleen; lkml - Kernel Mailing List;
> linux-acpi@vger.kernel.org
> Subject: Re: [PATCH] i386: irq: Kill IRQ compression
>
> ebiederm@xmission.com (Eric W. Biederman) writes:
>
> > By itself I don't think we are going to observe any real problems
> > with this patch.
> >
> > However if we are going to be serious about this we need to do a
> > few more things.
> >
> > - kill ioapic_renumber_irq.
>
> Looking closer ioapic_renumber_irq does not appear to be an irq
> compress thing.  Rather it appears to be a work around for a weird
> acpi implementation where gsi 0 - 15 are not the ISA irqs.
>
> Natalie is my reading of the code there correct?

Yes, indeed.

>
> If so keeping ioapic_renumber_irq makes sense.  Although giving
> it a name that suggests it is working around weird implementation
> details would be good.

Sure. I think it was originally renumber_gsi something, but Len had to
change it so it sounds more explicit as familiar "IRQ".
--Natalie
>
> Eric
>
