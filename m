From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [patch 02/14] ACPI: Atlas ACPI driver
Date: Thu, 11 Jan 2007 06:16:45 +0100
Message-ID: <756b48450701102116k2a667b1dh3a09d0de6bf7ce65@mail.gmail.com>
References: <200608150537.k7F5bMHZ011530@shell0.pdx.osdl.net>
	 <200608152313.56558.len.brown@intel.com>
	 <756b48450608170048n4d4941c2s349f44883628df9a@mail.gmail.com>
	 <200608181044.55097.len.brown@intel.com>
	 <d120d5000608231049p7050310dobee359a1d871d453@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:9034 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965249AbXAKFQr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jan 2007 00:16:47 -0500
Received: by ug-out-1314.google.com with SMTP id 44so345498uga
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jan 2007 21:16:45 -0800 (PST)
In-Reply-To: <d120d5000608231049p7050310dobee359a1d871d453@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, akpm@osdl.org, linux-acpi@vger.kernel.org, luming.yu@intel.com

On 8/23/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 8/18/06, Len Brown <len.brown@intel.com> wrote:
> >
> > that patch was an incremental depending on the previous patch.
> > Please send just the final patch vs 2.6.18-rc4  to the above, also cc: linux-kernel@vger.kernel.org
> >
> > > Also, Dmitry had asked what we should do about handing ACPI errors to
> > > upper layers here:
> > > http://marc.theaimsgroup.com/?l=linux-acpi&m=115392091425952&w=2
> >
> > Dmitry has a good question and we need to iron it out for the general case.
> > I recommend that for your driver you simply do something like this for now:
> >
> > if (ACPI_ERROR(status))
> >        status = -EINVAL
> >
> > and get your driver into the mm tree to find the next problem.
> >
>
> Jaya,
>
> If you could make the change Len was talking about and create a patch
> against mainline I would apply it to my tree.
>
> Thank you.
>
> --
> Dmitry
>

Ok. Will do and post shortly.

Thanks,
jaya
