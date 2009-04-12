From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [RFC] [PATCH] ACPI: EC: Merge poll and interrupt modes
Date: Sun, 12 Apr 2009 11:16:23 +0100
Message-ID: <9b2b86520904120316l1aeebf32y1631e68d6732865@mail.gmail.com>
References: <49D7EEBA.40203@gmail.com>
	 <alpine.LFD.2.00.0904102328210.8559@localhost.localdomain>
Reply-To: alan-jenkins@tuffmail.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:61729 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429AbZDLKQZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Apr 2009 06:16:25 -0400
Received: by bwz17 with SMTP id 17so1676230bwz.37
        for <linux-acpi@vger.kernel.org>; Sun, 12 Apr 2009 03:16:23 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904102328210.8559@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 4/11/09, Len Brown <lenb@kernel.org> wrote:
> weird, when i save or export this patch from alpine,
> it wraps the long lines, causing the patch to get corrupted.
>
> eg.
>      pr_info(PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data =
> 0x%lx\n",
> becomes:
>      pr_info(PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data =
> 0x%lx\n",
>
> i've never run into this before...

I had a similar problem in both GMail and Thunderbird.  I've seen it
once before.  Maybe it's due to the "format-flowed".  Patches should
definitely not be sent format-flowed.

Alan
