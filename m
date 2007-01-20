From: emisca <emisca.ml@gmail.com>
Subject: Re: [0/5] remove ACPI motherboard driver, use PNP system driver instead (take 2)
Date: Sat, 20 Jan 2007 19:00:23 +0100
Message-ID: <414cba4e0701201000n698f0bbbh10016c984c84b364@mail.gmail.com>
References: <200701181636.45590.bjorn.helgaas@hp.com>
	 <414cba4e0701190737j110b33aau25789808767953fa@mail.gmail.com>
	 <200701191433.09311.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:28559 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965340AbXATSAZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Jan 2007 13:00:25 -0500
Received: by ug-out-1314.google.com with SMTP id 44so716525uga
        for <linux-acpi@vger.kernel.org>; Sat, 20 Jan 2007 10:00:24 -0800 (PST)
In-Reply-To: <200701191433.09311.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

Could you tell me which informations I must collect and in which
conditions I must collect them so I could post them?
They replied me on the other post that I must manually debug the
pnpacpi code.......

2007/1/19, Bjorn Helgaas <bjorn.helgaas@hp.com>:
> On Friday 19 January 2007 08:37, emisca wrote:
> > I have posted some days ago, some problems on resume from suspend to
> > disk on my motherboard (asus p5ld2 se) related to acpi pnp. The serial
> > didn't worked after resume. Using pnpacpi=off it worked.
> > Now using this patch what will be the behaviour?
>
> My patches shouldn't change the behavior you're seeing.
>
> Since it seems to be related to PNPACPI, can you post the dmesgs with
> and without pnpacpi=off to linux-acpi?  I see the ones on LKML, but
> it sounds like there was some user error in collecting them.
>
> Bjorn
>
>
