From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and getkeycode key table.
Date: Wed, 18 Jul 2007 11:05:54 -0400
Message-ID: <d120d5000707180805u31099be0i2d827b10228d2608@mail.gmail.com>
References: <1184520879991-git-send-email-malattia@linux.it>
	 <11845208793678-git-send-email-malattia@linux.it>
	 <11845208794064-git-send-email-malattia@linux.it>
	 <11845208791511-git-send-email-malattia@linux.it>
	 <20070715211128.GA6291@srcf.ucam.org> <1184605565.2228.57.camel@work>
	 <20070716180928.GA21211@srcf.ucam.org> <1184668653.2443.2.camel@work>
	 <20070718114518.GB21658@inferi.kami.home>
	 <20070718142800.GA20607@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:29062 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbXGRPFz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 11:05:55 -0400
Received: by wa-out-1112.google.com with SMTP id v27so247759wah
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jul 2007 08:05:54 -0700 (PDT)
In-Reply-To: <20070718142800.GA20607@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mattia Dongili <malattia@linux.it>, Richard Hughes <hughsient@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>

On 7/18/07, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Wed, Jul 18, 2007 at 08:45:19PM +0900, Mattia Dongili wrote:
> > On Tue, Jul 17, 2007 at 11:37:33AM +0100, Richard Hughes wrote:
> > > On Mon, 2007-07-16 at 19:09 +0100, Matthew Garrett wrote:
> > > >
> > > > That's fine, we have information that lets us distinguish between
> > > > models.
> >
> > Well, I don't think we have all, at least I don't and anyway it's nice
> > to have some way to add new models that doesn't require waiting for a new
> > kernel to be available.
>
> They can still be overridden in exactly the same way - it's just a
> question of sending useful defaults on most machines. If a user finds
> that the defaults don't work they can still be remapped via hal, but the
> aim should be for that to be unnecessary where possible.
>

I guess it all depends on how well HAL updates will be integrated with
distributions and whether users update kernels more often than the
rest of the system. For example I am still using FC 3 (I was going to
upgrade to 7 but I guess it won't happen until 8 is released ;) ) so
for me kernel is better ;)

I think we should continue adding keymaps to kernel until everyone is
using HAL's facilities to load keymaps and then stop. Does this make
sense?

-- 
Dmitry
