From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 02/14] ACPI: Atlas ACPI driver
Date: Wed, 23 Aug 2006 13:49:44 -0400
Message-ID: <d120d5000608231049p7050310dobee359a1d871d453@mail.gmail.com>
References: <200608150537.k7F5bMHZ011530@shell0.pdx.osdl.net>
	 <200608152313.56558.len.brown@intel.com>
	 <756b48450608170048n4d4941c2s349f44883628df9a@mail.gmail.com>
	 <200608181044.55097.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:56955 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932324AbWHWRtp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Aug 2006 13:49:45 -0400
Received: by nf-out-0910.google.com with SMTP id o25so386919nfa
        for <linux-acpi@vger.kernel.org>; Wed, 23 Aug 2006 10:49:44 -0700 (PDT)
In-Reply-To: <200608181044.55097.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jaya Kumar <jayakumar.acpi@gmail.com>
Cc: Len Brown <lenb@kernel.org>, akpm@osdl.org, linux-acpi@vger.kernel.org, luming.yu@intel.com

On 8/18/06, Len Brown <len.brown@intel.com> wrote:
> On Thursday 17 August 2006 03:48, Jaya Kumar wrote:
> > On 8/16/06, Len Brown <len.brown@intel.com> wrote:
> > > Andrew,
> > > Please delete this patch from MM -- it is stale.
> > > Jaya, please send Andrew the newer patch that replaces it -- the one
> > > that doesn't touch drivers/acpi.
> > >
> > > thanks,
> > > -Len
> >
> > Hi Len,
> >
> > I had sent that on June 26 to everyone on the CC list. Archive link is here:
> > http://marc.theaimsgroup.com/?l=linux-acpi&m=115391161115058&w=2
>
> that patch was an incremental depending on the previous patch.
> Please send just the final patch vs 2.6.18-rc4  to the above, also cc: linux-kernel@vger.kernel.org
>
> > Also, Dmitry had asked what we should do about handing ACPI errors to
> > upper layers here:
> > http://marc.theaimsgroup.com/?l=linux-acpi&m=115392091425952&w=2
>
> Dmitry has a good question and we need to iron it out for the general case.
> I recommend that for your driver you simply do something like this for now:
>
> if (ACPI_ERROR(status))
>        status = -EINVAL
>
> and get your driver into the mm tree to find the next problem.
>

Jaya,

If you could make the change Len was talking about and create a patch
against mainline I would apply it to my tree.

Thank you.

-- 
Dmitry
