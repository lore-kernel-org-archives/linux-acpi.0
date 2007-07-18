From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and getkeycode key table.
Date: Wed, 18 Jul 2007 12:02:07 -0400
Message-ID: <d120d5000707180902y6469849mbaba0eaeb81e0578@mail.gmail.com>
References: <1184520879991-git-send-email-malattia@linux.it>
	 <11845208791511-git-send-email-malattia@linux.it>
	 <20070715211128.GA6291@srcf.ucam.org> <1184605565.2228.57.camel@work>
	 <20070716180928.GA21211@srcf.ucam.org> <1184668653.2443.2.camel@work>
	 <20070718114518.GB21658@inferi.kami.home>
	 <20070718142800.GA20607@srcf.ucam.org>
	 <d120d5000707180805u31099be0i2d827b10228d2608@mail.gmail.com>
	 <1184771822.14062.2.camel@work>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:39872 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbXGRQCI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 12:02:08 -0400
Received: by wa-out-1112.google.com with SMTP id v27so269231wah
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jul 2007 09:02:08 -0700 (PDT)
In-Reply-To: <1184771822.14062.2.camel@work>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>

On 7/18/07, Richard Hughes <hughsient@gmail.com> wrote:
> On Wed, 2007-07-18 at 11:05 -0400, Dmitry Torokhov wrote:
> >
> > I think we should continue adding keymaps to kernel until everyone is
> > using HAL's facilities to load keymaps and then stop. Does this make
> > sense?
>
> I don't think so. The whole idea of hal-info is that we can update a 14k
> noarch package every week if needed, that will work on pretty much any
> hal version.
>
> I'm not sure people running FC3 systems are going to be running git
> kernels for new keymaps.
>

What distributions cirrently use the new HAL facilities? I am not
saying that we want support FC3 but what about FC6, FC7? Ubuntu,
Debian?

-- 
Dmitry
