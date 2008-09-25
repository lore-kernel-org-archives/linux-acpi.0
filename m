From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver v0.94
Date: Thu, 25 Sep 2008 12:44:23 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809251237180.3018@localhost.localdomain>
References: <20080702090044.GB12272@prithivi.gnumonks.org>
 <20080704034419.GG4381@prithivi.gnumonks.org>
 <alpine.LFD.1.10.0809221830331.1509@localhost.localdomain>
 <20080923154657.GA4063@prithivi.gnumonks.org>
 <1222317956.5020.10.camel@miurahr1.sps.nttdata.co.jp>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1402248061-1222361066=:3018"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:64124 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756131AbYIYQpx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 12:45:53 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K7R00K79FU5FU31@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 25 Sep 2008 11:44:30 -0500 (CDT)
In-reply-to: <1222317956.5020.10.camel@miurahr1.sps.nttdata.co.jp>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-2022-JP?Q?SPS_=1B$B=3B01=3A=1B=28J_=1B$B9-=3BV=1B=28J=28=1B$B#I#T=3FM=3A`=40oN=2C=1B=28J=29?= <miurahr@nttdata.co.jp>
Cc: Harald Welte <laforge@gnumonks.org>, linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1402248061-1222361066=:3018
Content-Type: TEXT/PLAIN; charset=ISO-2022-JP



On Thu, 25 Sep 2008, SPS 三浦 広志(ＩＴ人材戦略) wrote:

> Hi Harald,
> 
> Thank you for your help and I'm sorry for my inactiveness...
> 
> 2008-09-23 17:46 +0200  Harald Welte wrote:
> > Hi Len,
> > 
> > On Mon, Sep 22, 2008 at 06:38:24PM -0400, Len Brown wrote:
> > > Thanks for picking up this driver -- I'm sure its users will be pleased
> > > to get it included in the kernel.
> > 
> > Hi Len, thanks for your encouraging feedback.
> 
> > > If this works on a broad range of panasonic, the panasonic-laptop
> > > panasonic make sense, else if it is more limited, then a more
> > > specific name would be better.  Unclear what pcc stands for...
> > 
> > I don't really know the various panasonic products, but the 
> 
> pcc stands for Panasonic Computer Company, which is exist several years
> ago. This driver works on a broad range of panasonic laptops,
> such as Let's note series and Tough book series.
> 
> I had discussed bios writers in the Panasonic 2 yrs ago,
> they said they keeps backword compatibility for their products, at least
> after CF-R1/T1/W1/Y1 toughbook/let's note series.
> 
> They will adopt new acpi specification when microsoft os adopt it.
> That's why recent model, such as CF-W6/W7, can not control lcd
> brightness through this driver but can through generic video 
> driver.
> 
> I originaly write driver in reverse engineering basis,  but at that
> time, bios writer provided me some specification.
> 
> Hiroshi Miura
> miura@da-cha.org
> miurahr@nttdata.co.jp

Thanks Hiroshi, for the background.

I'm glad that Panasonic is willing to share enough info with
the Linux community so that we are not lost in trying to support
users of their products.  As Harald has signed up to maintain
this driver in-tree, perharps you can share your contacts
at Panasonic with Harald?

cheers,
-Len

--8323328-1402248061-1222361066=:3018--
