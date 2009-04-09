From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [RFC] [PATCH] ACPI: EC: Merge poll and interrupt modes
Date: Thu, 9 Apr 2009 15:59:14 +0100
Message-ID: <9b2b86520904090759n72295e21w139d2cb449f42a4f@mail.gmail.com>
References: <49D7EEBA.40203@gmail.com>
	 <alpine.LFD.2.00.0904050020350.4821@localhost.localdomain>
Reply-To: alan-jenkins@tuffmail.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:49726 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139AbZDIO7R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Apr 2009 10:59:17 -0400
Received: by bwz17 with SMTP id 17so628685bwz.37
        for <linux-acpi@vger.kernel.org>; Thu, 09 Apr 2009 07:59:16 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904050020350.4821@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 4/5/09, Len Brown <lenb@kernel.org> wrote:
> if you send me a checkpatch.pl clean version,
> I'll put it in the acpi-test tree.
>
> It is too late to test this broadly before the 2.6.30 merge window closes,
> but who knows, maybe 2.6.31 and a .stable backport if it turns out to be
> wonderful...

Hmm, I was going to test this patch on my problematic EEE.  But it
conflicted with the MSI delay fix, and I don't see how to reconcile
the two.  If you can CC me when this gets into acpi-test, I'll have a
look at it then.

Thanks
Alan
