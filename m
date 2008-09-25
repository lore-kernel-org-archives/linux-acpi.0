From: SPS =?iso-2022-jp?Q?=1B=24B=3B01=3A=1B=28B_?=
	 =?iso-2022-jp?Q?=1B=24B9-=3BV=1B=28B=28=1B=24B=23I=23T=3FM=3A=60=40o=1B=28B?=
	 =?iso-2022-jp?Q?=1B=24BN=2C=1B=28B=29?= <miurahr@nttdata.co.jp>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver v0.94
Date: Thu, 25 Sep 2008 13:45:56 +0900
Message-ID: <1222317956.5020.10.camel@miurahr1.sps.nttdata.co.jp>
References: <20080702090044.GB12272@prithivi.gnumonks.org>
	 <20080704034419.GG4381@prithivi.gnumonks.org>
	 <alpine.LFD.1.10.0809221830331.1509@localhost.localdomain>
	 <20080923154657.GA4063@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ms1.nttdata.co.jp ([163.135.193.232]:38495 "EHLO
	ms1.nttdata.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbYIYFTN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 01:19:13 -0400
Received: from MFSPL03.mfs.nttdata.co.jp (mfspl03.mfs.nttdata.co.jp [163.135.13.53])
	by ms1.nttdata.co.jp (NTTDATA-TOP/DLV-20060831) with ESMTP id m8P4k0ZJ014481
	for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2008 13:46:00 +0900 (JST)
In-Reply-To: <20080923154657.GA4063@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>

Hi Harald,

Thank you for your help and I'm sorry for my inactiveness...

2008-09-23 17:46 +0200  Harald Welte wrote:
> Hi Len,
> 
> On Mon, Sep 22, 2008 at 06:38:24PM -0400, Len Brown wrote:
> > Thanks for picking up this driver -- I'm sure its users will be pleased
> > to get it included in the kernel.
> 
> Hi Len, thanks for your encouraging feedback.

> 
> > If this works on a broad range of panasonic, the panasonic-laptop
> > panasonic make sense, else if it is more limited, then a more
> > specific name would be better.  Unclear what pcc stands for...
> 
> I don't really know the various panasonic products, but the 

pcc stands for Panasonic Computer Company, which is exist several years
ago. This driver works on a broad range of panasonic laptops,
such as Let's note series and Tough book series.

I had discussed bios writers in the Panasonic 2 yrs ago,
they said they keeps backword compatibility for their products, at least
after CF-R1/T1/W1/Y1 toughbook/let's note series.

They will adopt new acpi specification when microsoft os adopt it.
That's why recent model, such as CF-W6/W7, can not control lcd
brightness through this driver but can through generic video 
driver.

I originaly write driver in reverse engineering basis,  but at that
time, bios writer provided me some specification.



Hiroshi Miura
miura@da-cha.org
miurahr@nttdata.co.jp
-- 
        Global IT Innovator

__--------~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                NTT DATA Group

Hiroshi  Miura
HRD Manager for IT architect and specialist, 
Planning Section, System Platform Sector

