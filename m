From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.21: ACPI related kernel panic
Date: Mon, 30 Apr 2007 15:34:29 +0200
Message-ID: <6bffcb0e0704300634y610aee9en1e5bd8366d30a0e0@mail.gmail.com>
References: <20070430122940.GA25848@anna.darkstar.lan>
	 <6bffcb0e0704300546w1eff1a92gff047117e9e756e@mail.gmail.com>
	 <8f8ff01d0704300551yb0413c7m3834cc75c2d0fcdd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:25475 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423282AbXD3Neb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Apr 2007 09:34:31 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1914865nzf
        for <linux-acpi@vger.kernel.org>; Mon, 30 Apr 2007 06:34:31 -0700 (PDT)
In-Reply-To: <8f8ff01d0704300551yb0413c7m3834cc75c2d0fcdd@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Sebastian Kemper <sebastian_ml@gmx.net>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Alexey,

On 30/04/07, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> Please take a look at 8385 bug report here, as it might be relevant:
> http://bugzilla.kernel.org/show_bug.cgi?id=8385

I updated info about this bug
http://kernelnewbies.org/known_regressions

Thanks!

Sebastian, please test both patches.
http://bugzilla.kernel.org/attachment.cgi?id=11331&action=view
http://bugzilla.kernel.org/attachment.cgi?id=11332&action=view

>
> On 4/30/07, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > Hi,
> >
> > On 30/04/07, Sebastian Kemper <sebastian_ml@gmx.net> wrote:
> > > Hello all,
> > >
> > > I have updated some different boxes to 2.6.21 with success. One laptop,
> > > though, has some issue with it.
> > >
> > > It's an Acer TravelMate 4002WLMi. Sometimes it boots fine and sometimes
> > > not. Thanks to netconsole you can see what happens when it boots fine in
> > > the attached bootsie.out.good. bootsie.out shows what happens on the
> > > screen when things get out of hand (kernel panic).
> > >
> > > Also attached you'll find the output of lspci, lsusb, ver_linux and the
> > > kernel configuration.
> > >
> > > If there's more you need (git bisection or more info in general,
> > > testing ...) just say so.
> > >
> > > Thanks in advance!
> > >
> > > Regards
> > > Sebastian
> > >
> > > P.S.: Please CC.
> > >
> > >
> >
> > I added this to the list of known regressions.
> >
> > Len and ACPI folks CC'ed.
> >
> > Regards,
> > Michal
> >
> > --
> > Michal K. K. Piotrowski
> > Kernel Monkeys
> > (http://kernel.wikidot.com/start)
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
