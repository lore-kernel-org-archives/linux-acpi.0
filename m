From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and getkeycode key table.
Date: Wed, 18 Jul 2007 12:39:57 -0400
Message-ID: <d120d5000707180939u2ad22264nf7136853ee44d87e@mail.gmail.com>
References: <11845208794064-git-send-email-malattia@linux.it>
	 <20070715211128.GA6291@srcf.ucam.org> <1184605565.2228.57.camel@work>
	 <20070716180928.GA21211@srcf.ucam.org> <1184668653.2443.2.camel@work>
	 <20070718114518.GB21658@inferi.kami.home>
	 <20070718142800.GA20607@srcf.ucam.org>
	 <d120d5000707180805u31099be0i2d827b10228d2608@mail.gmail.com>
	 <1184771822.14062.2.camel@work> <20070718162510.GA22975@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:27507 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759401AbXGRQj6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 12:39:58 -0400
Received: by nz-out-0506.google.com with SMTP id s18so221765nze
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jul 2007 09:39:58 -0700 (PDT)
In-Reply-To: <20070718162510.GA22975@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Richard Hughes <hughsient@gmail.com>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>

On 7/18/07, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Wed, Jul 18, 2007 at 04:17:02PM +0100, Richard Hughes wrote:
> > On Wed, 2007-07-18 at 11:05 -0400, Dmitry Torokhov wrote:
> > >
> > > I think we should continue adding keymaps to kernel until everyone is
> > > using HAL's facilities to load keymaps and then stop. Does this make
> > > sense?
> >
> > I don't think so. The whole idea of hal-info is that we can update a 14k
> > noarch package every week if needed, that will work on pretty much any
> > hal version.
> >
> > I'm not sure people running FC3 systems are going to be running git
> > kernels for new keymaps.
>
> This isn't an either/or situation. If you have a hal keymap then the
> system will still work. The question is what to do in the absence of
> hal. The kernel can either provide sane defaults (that might be wrong in
> a couple of cases) or it can provide keys that are pretty much
> guaranteed to do nothing. I think doing our best to make things work
> even if hal isn't there is sensible - if hal /is/ there, we've lost
> nothing.
>

There is burden in maintaining the same data in 2 different places
(kernel/HAL). I think pretty soon everyone will be using never HAL
(like everyone uses udev) and we can stop adding keymaps into kernel.
But for now if we want to support not so outdated distributions we can
add keymaps to the kernel drivers.

-- 
Dmitry
