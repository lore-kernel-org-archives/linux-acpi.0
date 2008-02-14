From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2]  tc1100-wmi - Fail gracefully if ACPI is disabled
Date: Thu, 14 Feb 2008 01:15:25 -0500
Message-ID: <200802140115.25787.lenb@kernel.org>
References: <200802080145.16774.lenb@kernel.org> <200802111955.46199.carlos@strangeworlds.co.uk> <200802140111.41883.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56971 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbYBNGRH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Feb 2008 01:17:07 -0500
In-Reply-To: <200802140111.41883.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org

never mind -- linus fixed this in a more elegant way.

-len

On Thursday 14 February 2008 01:11, Len Brown wrote:
> applied.
> 
> thanks,
> -len
> 
> On Monday 11 February 2008 14:55, Carlos Corbacho wrote:
> > tc1100-wmi - Fail gracefully if ACPI is disabled
> > 
> > From: Carlos Corbacho <carlos@strangeworlds.co.uk>
> > 
> > WMI drivers, like their ACPI counterparts, should also check if ACPI is
> > disabled or not, and bail out if so, otherwise we cause a crash.
> > 
> > Spotted by Ingo Molnar.
> > 
> > Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
> > CC: Ingo Molnar <mingo@elte.hu>
> > CC: Linus Torvalds <torvalds@linux-foundation.org>
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: Len Brown <lenb@kernel.org>
> > ---
> > 
> >  drivers/misc/tc1100-wmi.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > 
> > diff --git a/drivers/misc/tc1100-wmi.c b/drivers/misc/tc1100-wmi.c
> > index f25e4c9..cb8f79f 100644
> > --- a/drivers/misc/tc1100-wmi.c
> > +++ b/drivers/misc/tc1100-wmi.c
> > @@ -263,6 +263,9 @@ static int __init tc1100_init(void)
> >  {
> >  	int result = 0;
> >  
> > +	if (acpi_disabled)
> > +		return -ENODEV;
> > +
> >  	if (!wmi_has_guid(GUID))
> >  		return -ENODEV;
> >  
> > 
> 
