From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] sonypi: Fix initialization warning
Date: Tue, 7 Aug 2007 15:07:32 -0400
Message-ID: <200708071507.33141.lenb@kernel.org>
References: <46B61F70.90005@student.ltu.se> <1186343443.3858.46.camel@fanta4.site> <46B62CFE.2010404@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37127 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833AbXHGTHt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Aug 2007 15:07:49 -0400
In-Reply-To: <46B62CFE.2010404@student.ltu.se>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: trenn@suse.de, Ben Collins <bcollins@ubuntu.com>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org

On Sunday 05 August 2007 16:03, Richard Knutsson wrote:
> Thomas Renninger wrote:
> > On Sun, 2007-08-05 at 21:05 +0200, Richard Knutsson wrote:
> >   
> >> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
> >> ---
> >> Got this from the compiler (gcc (GCC) 4.1.2 20070626 (Red Hat 4.1.2-13)):
> >> drivers/char/sonypi.c:1153: warning: initialization from incompatible pointer type
> >>
> >>
> >> diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
> >> index 73037a4..2dcd519 100644
> >> --- a/drivers/char/sonypi.c
> >> +++ b/drivers/char/sonypi.c
> >> @@ -1147,10 +1147,15 @@ static int sonypi_acpi_remove(struct acpi_device *device, int type)
> >>  	return 0;
> >>  }
> >>  
> >> +static const struct acpi_device_id sonypi_acpi_driver_ids[] = {
> >> +        {ACPI_PROCESSOR_HID, 0},
> >>     
> > This is wrong. You need to take the HID the driver should match for, in
> > this case: {"SNY6001", 0 },
> >   

like this?

http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commitdiff;h=f7b88ccb63188e775fe02e746c39ed177741cfc7;hp=11604ecf6fb9c2ab0152fbddb7ea2724438ef76e

http://marc.info/?l=linux-acpi&m=118618043526395&w=2
