From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: 2.6.21: ACPI related kernel panic
Date: Mon, 30 Apr 2007 16:51:02 +0400
Message-ID: <8f8ff01d0704300551yb0413c7m3834cc75c2d0fcdd@mail.gmail.com>
References: <20070430122940.GA25848@anna.darkstar.lan>
	 <6bffcb0e0704300546w1eff1a92gff047117e9e756e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:8779 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423216AbXD3MvD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Apr 2007 08:51:03 -0400
Received: by an-out-0708.google.com with SMTP id b33so1264039ana
        for <linux-acpi@vger.kernel.org>; Mon, 30 Apr 2007 05:51:03 -0700 (PDT)
In-Reply-To: <6bffcb0e0704300546w1eff1a92gff047117e9e756e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Sebastian Kemper <sebastian_ml@gmx.net>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Please take a look at 8385 bug report here, as it might be relevant:
http://bugzilla.kernel.org/show_bug.cgi?id=8385

On 4/30/07, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi,
>
> On 30/04/07, Sebastian Kemper <sebastian_ml@gmx.net> wrote:
> > Hello all,
> >
> > I have updated some different boxes to 2.6.21 with success. One laptop,
> > though, has some issue with it.
> >
> > It's an Acer TravelMate 4002WLMi. Sometimes it boots fine and sometimes
> > not. Thanks to netconsole you can see what happens when it boots fine in
> > the attached bootsie.out.good. bootsie.out shows what happens on the
> > screen when things get out of hand (kernel panic).
> >
> > Also attached you'll find the output of lspci, lsusb, ver_linux and the
> > kernel configuration.
> >
> > If there's more you need (git bisection or more info in general,
> > testing ...) just say so.
> >
> > Thanks in advance!
> >
> > Regards
> > Sebastian
> >
> > P.S.: Please CC.
> >
> >
>
> I added this to the list of known regressions.
>
> Len and ACPI folks CC'ed.
>
> Regards,
> Michal
>
> --
> Michal K. K. Piotrowski
> Kernel Monkeys
> (http://kernel.wikidot.com/start)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
