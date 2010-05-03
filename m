From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: linux pnp bug - report
Date: Mon, 3 May 2010 10:08:01 -0600
Message-ID: <201005031008.01773.bjorn.helgaas@hp.com>
References: <1269373637.3113.12.camel@goldenfish.development.local> <1272686583.28149.53.camel@dc7800.home> <1272822665.2801.9.camel@goldenfish.development.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:38375 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758848Ab0ECQIG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 May 2010 12:08:06 -0400
In-Reply-To: <1272822665.2801.9.camel@goldenfish.development.local>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: goldenfish@linuxsoft.cz
Cc: linux-acpi@vger.kernel.org

On Sunday 02 May 2010 11:51:05 am Pavel Kysilka wrote:
> On Fri, 2010-04-30 at 22:03 -0600, Bjorn Helgaas wrote:
> > Pavel wrote:
> > > i am playing with old PIII computer (HP Vectra VE) and ISA soundcards.
> > > Soundcars are PNP(yamaha,opti,ess,...) and no PNP (multisound).
> > > Machine
> > > is old, but ACPI compilant - old BIOS.
> > > 
> > > Computer booting OK. PNP0 devices allocate resources OK, but PNP1
> > > devices (one ISA slot) not. PNP soundcard driver is not correctly
> > > loaded
> > > - soundcard device not created.
> > 
> > I think this is a regression, i.e., 2.6.33 worked, but 2.6.34-rc6 does
> > not.  Right?  Even worse, I think it's my fault :-(  If this is a
> > regression, we should open a bugzilla at http://bugzilla.kernel.org and
> > assign it to me.
> 2.6.33 kernel working without problem.

Thanks a lot for testing that patch!  I will try to push that upstream
before 2.6.34.

Can you please collect the output of "lspci -vv"?  I'd like to get a
better idea of how we should handle PCI and PNP resources.

Bjorn
