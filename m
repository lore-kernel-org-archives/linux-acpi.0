From: David Mohr <damailings@mcbf.net>
Subject: Re: Shutdown issues with Gigabyte A75M board: always reboots
Date: Mon, 28 Nov 2011 21:10:14 -0700
Message-ID: <1322539814.2648.9.camel@alucardo.nm.mcbf.net>
References: <1322497836.4462.5.camel@alucardo.nm.mcbf.net>
	 <1322498547.4462.7.camel@alucardo.nm.mcbf.net>
	 <1322529738.2648.6.camel@alucardo.nm.mcbf.net>
	 <CAErSpo4ut00Ew7ZhOazmhBGXYMnNrs0JU4HwT5mjOSrq8-JPDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from seeker.mcbf.net ([109.239.49.157]:44210 "EHLO seeker.mcbf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847Ab1K2EKY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Nov 2011 23:10:24 -0500
In-Reply-To: <CAErSpo4ut00Ew7ZhOazmhBGXYMnNrs0JU4HwT5mjOSrq8-JPDg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org

On Mon, 2011-11-28 at 17:43 -0800, Bjorn Helgaas wrote:
> On Mon, Nov 28, 2011 at 5:22 PM, David Mohr <damailings@mcbf.net> wrote:
> > On Mon, 2011-11-28 at 09:42 -0700, David Mohr wrote:
> >> Hi folks,
> >>
> >> I have an AMD CPU on a Gigabyte A75M board[0]. When I shut the computer
> >> off, either through gdm, or with 'shutdown -h now' on the cli, the
> >> computer turns off and then immediately on again. I would say there is a
> >> tiny delay in between which distinguishes it from a reboot.
> >>
> >> The same thing happens when I go to standby - the computer immediately
> >> wakes up.
> >>
> >> This is on 3.2-rc2. I have some infos attached to this email. Any help
> >> would be appreciated since this annoying problem has been with me for a
> >> while :-).
> >>
> >> Thanks,
> >> ~David
> >>
> >> P.S. If there is a better place to post this issue, please let me know.
> >>
> >> [0]: http://www.gigabyte.us/products/product-page.aspx?pid=3928&#sp
> >
> > And I just realized my original email did not go through because the
> > attachment was too large.
> >
> > Another attempt is attached. It contains acpidump  dmidecode  kern.log  lspci
> > uname . I hope that's useful enough to get a response ;-). I have the sys
> > directory tarred up as well, please download it at [1].
> >
> > Thanks,
> > ~David
> >
> > [1]: http://dsp.mcbf.net/acpi-sys.tar.bz2
> >
> 
> Is this a regression?  If so, what's the most recent kernel that did
> not have this bug?  If you're ambitious, you could bisect it and
> identify the change that caused the problem.

Hi Bjorn,
I actually don't know if this is a regression. It's a new computer and
any kernel I have tried showed this issue. But I will step back and try
some older ones to see if a bisect would be worth while.

~David

