From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 1/2] ACPI processor: force throttling state when BIOS returns incorrect value
Date: Wed, 26 Aug 2009 21:41:02 +0200
Message-ID: <200908262141.04546.elendil@planet.nl>
References: <200908171443.35622.elendil@planet.nl> <20090826121619.2bc7e72b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Cpsmtpm-eml109.kpnxchange.com ([195.121.3.13]:55481 "EHLO
	CPSMTPM-EML109.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751308AbZHZTlD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Aug 2009 15:41:03 -0400
In-Reply-To: <20090826121619.2bc7e72b.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@intel.com, rui.zhang@intel.com

Thanks for picking up the patch Andrew.

On Wednesday 26 August 2009, Andrew Morton wrote:
> On Mon, 17 Aug 2009 14:43:34 +0200 Frans Pop <elendil@planet.nl> wrote:
> > --- a/drivers/acpi/processor_throttling.c
> > +++ b/drivers/acpi/processor_throttling.c
> > @@ -62,7 +62,8 @@ struct throttling_tstate {
> >  #define THROTTLING_POSTCHANGE      (2)
> >
> >  static int acpi_processor_get_throttling(struct acpi_processor *pr);
> > -int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
> > +int acpi_processor_set_throttling(struct acpi_processor *pr, 
> > +						int state, bool force);
>
> WARNING: externs should be avoided in .c files
> #74: FILE: drivers/acpi/processor_throttling.c:65:
> +int acpi_processor_set_throttling(struct acpi_processor *pr,
>
> checkpatch speaketh truth - there's already a declaration in
> acpi/processor.h anyway.
>
> I'll leave it alone though.  Cleaning up acpi code isn't on the agenda
> for today.

Yeah, but it wasn't an error introduced by my patch, so I chose to
ignore it in order to keep my change straightforward.
The whole file gives:
   total: 6 errors, 15 warnings, 1326 lines checked

I really did not want to get into that, although this is the only
error of that type. You also have to allow for my limited C skills :-/

> Please integrate checkpatch into your patch preparation tools.  It
> finds stuff.

I do run checkpatch frequently, but I don't yet have enough volume
that I have my own a toolset for preparing patches. I do have a
nice one for building kernels though, so who knows :-)

Cheers,
FJP
