From: Frank <frank@61924.nl>
Subject: Re: Toshiba Satellite L650D-10J only boots with acpi=off
Date: Sun, 29 Aug 2010 00:15:14 +0200
Message-ID: <20100829001514.22936b5b.frank@61924.nl>
References: <20100828192538.666c34c4.frank@61924.nl>
	<AANLkTimaCQP61iDSHCAqBRZcEr3QQnfg1UdrHXzZ9xF4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail6.webfaction.com ([74.55.86.74]:33648 "EHLO
	smtp.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab0H1WVh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Aug 2010 18:21:37 -0400
Received: from localhost.localdomain (ip4da71572.direct-adsl.nl [77.167.21.114])
	by smtp.webfaction.com (Postfix) with ESMTP id 31656324C19
	for <linux-acpi@vger.kernel.org>; Sat, 28 Aug 2010 17:21:35 -0500 (CDT)
In-Reply-To: <AANLkTimaCQP61iDSHCAqBRZcEr3QQnfg1UdrHXzZ9xF4@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Sat, 28 Aug 2010 11:24:28 -0700
Yinghai Lu <yinghai@kernel.org> wrote:

> On Sat, Aug 28, 2010 at 10:25 AM, Frank <frank@61924.nl> wrote:
> > Hello,
> >
> > I purchased a Toshiba Satellite L650D-10J a few days ago and when I
> > wanted to install Archlinux I was only able to boot the installer with
> > acpi=off. The same goes for the installed OS.
> >
> > I asked on ##kernel on freenode and one guy said I should mail this
> > issue to this mailing list. And include all the information I have.
> >
> > This is what I get when I boot without acpi=off:
> > http://i.imagehost.org/view/0872/DSC00071
> > http://a.imagehost.org/view/0172/DSC00069
> >
> > The system boots normally when I use acpi=off, but the dual-core CPU is
> > seen as a CPU with one core. And X is slow with starting up and doesn't
> > shutdown when I close Openbox, but I'm not sure if that's even related.
> >
> > Here's the dmesg:
> > http://codepad.org/W7EzULKf
> >
> > And the lspci:
> > http://codepad.org/ce1boP3r
> >
> > I'm using the stock Archlinux x86_64 kernel (the latest is 2.6.35.3-1
> > at this moment) and the config files can be found here:
> > http://repos.archlinux.org/wsvn/packages/kernel26/repos/core-x86_64/
> >
> > If more information is needed, I'll glady provide it.
> >
> 
> Can you try to boot with "pci=nocrs" instead of "acpi=off"?
> 
> Yinghai
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Doesn't seem to work. Results in this:
http://a.imagehost.org/view/0287/DSC00072
