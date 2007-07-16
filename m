From: "Aaron Durbin" <adurbin@google.com>
Subject: Re: [PATCH] ACPI: Add reboot mechanism
Date: Mon, 16 Jul 2007 11:22:13 -0700
Message-ID: <8f95bb250707161122q33e2c1afo9dd5fa2b3b97988e@mail.gmail.com>
References: <20070716180019.GA5112@google.com>
	 <1184609844.2698.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:46654 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbXGPSWX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jul 2007 14:22:23 -0400
Received: from zps18.corp.google.com (zps18.corp.google.com [172.25.146.18])
	by smtp-out.google.com with ESMTP id l6GIMH1H007200
	for <linux-acpi@vger.kernel.org>; Mon, 16 Jul 2007 19:22:17 +0100
Received: from nz-out-0506.google.com (nzar28.prod.google.com [10.36.69.28])
	by zps18.corp.google.com with ESMTP id l6GILRuP021794
	for <linux-acpi@vger.kernel.org>; Mon, 16 Jul 2007 11:22:13 -0700
Received: by nz-out-0506.google.com with SMTP id r28so863389nza
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jul 2007 11:22:13 -0700 (PDT)
In-Reply-To: <1184609844.2698.1.camel@laptopd505.fenrus.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, ak@suse.de, akpm@osdl.org

On 7/16/07, Arjan van de Ven <arjan@infradead.org> wrote:
> On Mon, 2007-07-16 at 11:00 -0700, Aaron Durbin wrote:
> > Add the ability to reset the machine using the RESET_REG in ACPI's FADT table.
> >
> > Signed-off-by: Aaron Durbin <adurbin@google.com>
> > ---
> >
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index d4336f1..c9906a5 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -21,7 +21,7 @@ obj-$(CONFIG_X86)           += blacklist.o
> >  #
> >  # ACPI Core Subsystem (Interpreter)
> >  #
> > -obj-y                                += osl.o utils.o \
> > +obj-y                                += osl.o utils.o reboot.o \
>
> a one function C file? Can you just stick it in one of the other files
> instead?
>

I originally did not do this because I didn't know the proper place.  Any
suggestions where you would want this?

-Aaron
