From: emisca <emisca.ml@gmail.com>
Subject: Re: [0/5] remove ACPI motherboard driver, use PNP system driver instead (take 2)
Date: Tue, 23 Jan 2007 19:24:43 +0000
Message-ID: <414cba4e0701231124w914285bh4ed21be9432731d6@mail.gmail.com>
References: <200701181636.45590.bjorn.helgaas@hp.com>
	 <200701220925.49821.bjorn.helgaas@hp.com>
	 <414cba4e0701230107ocac73kc3f20a6a3da959bb@mail.gmail.com>
	 <200701230844.52674.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:23072 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933092AbXAWTYp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jan 2007 14:24:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1308916uga
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jan 2007 11:24:44 -0800 (PST)
In-Reply-To: <200701230844.52674.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

I'm going to compile a kernel only for these tests.. now I'm using
debian kernel 2.6.18.
So I'll compile a kernel 2.6.20-rc3-mm1 with your patch.
I'll post you the results....
Bye!

2007/1/23, Bjorn Helgaas <bjorn.helgaas@hp.com>:
> On Tuesday 23 January 2007 02:07, emisca wrote:
> > What kernel version I should use? If I should use git, could you give
> > me the path of the branch you use?
> > I tried with vanilla 2.6.19.2 kernel, but obviously 8250_pnp.c hasn't
> > the suspend and resume functions......
>
> I made the patch from 2.6.20-rc3-mm1, and it should apply on any recent
> mm kernel.  That'd be the easiest thing to debug, I think.
>
> If that's not convenient for you, we can work on 2.6.19.2, and you can
> just ignore the 8250_pnp patch (you can just remove that section from
> the patch).
>
