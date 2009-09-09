From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [RESEND] [PATCH 1/3] ACPI: battery: Fix
 CONFIG_ACPI_SYSFS_POWER=n
Date: Thu, 10 Sep 2009 00:21:11 +0300
Message-ID: <1252531271.4174.5.camel@maxim-laptop>
References: <4A4A219C.2020802@tuffmail.co.uk>
	 <1252339562.28499.13.camel@maxim-laptop>  <4AA7E438.4070905@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:57140 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369AbZIIVVP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2009 17:21:15 -0400
Received: by fxm17 with SMTP id 17so3694018fxm.37
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2009 14:21:18 -0700 (PDT)
In-Reply-To: <4AA7E438.4070905@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

On Wed, 2009-09-09 at 18:22 +0100, Alan Jenkins wrote: 
> Maxim Levitsky wrote:
> > Hi,
> >
> > So this is newer version of this patchset.
> > When this will be merged?
> >
> >
> > Last patch doesn't apply, seems that parts of yours patch were applied.
> > I applied it manually.
> >   
> > Will soon test.
> >
> >
> > Best regards,
> > 	Maxim Levitsky
> >   
> 
> I will submit "To: len" next time round.
> 
> You're right, it no longer applies cleanly to acpi-test.  ["patch" is
> happy to apply it and warn about "fuzz", but git-am is more strict.  It
> doesn't look like there's a real conflict.]
I applied it on top of both vanilla and linux-next. Here it really
doesn't apply (with or without 'fuzz')

> 
> I look forward to your results.  Please tell me the diff you end up with
> for the last patch and what tree you applied it on top of.  That way, if
> I add "Tested-by: Maxim..." I can be certain we're talking about the
> same patch :-).
> 
> Thanks!
> Alan

I did that few days ago (applied patch manually, without much thinking)

Unfortunately, resulting kernel oopses if battery is present, and
otherwise, if I plug batter later on, many battery statistics are
missing (probably some locks are held)

I will soon investigate this issue, more deeply.

Best regards,
Maxim Levitsky



