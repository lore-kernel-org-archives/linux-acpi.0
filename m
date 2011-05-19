From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: any way to evaluate a device's _PS0 method when its power
 state is at D0?
Date: Thu, 19 May 2011 16:45:25 +0100
Message-ID: <20110519154525.GA17017@srcf.ucam.org>
References: <BANLkTim-sswOsPZZzH7QOWQgqpwJ_EzeNQ@mail.gmail.com>
 <20110519124221.GA11831@srcf.ucam.org>
 <BANLkTimmDa55sgFgQbnD6sdNnvt8U+OXUQ@mail.gmail.com>
 <20110519151400.GA16348@srcf.ucam.org>
 <BANLkTinHONwV7aGPbxkCmVKrH0V0HLfz_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60764 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab1ESPpa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2011 11:45:30 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinHONwV7aGPbxkCmVKrH0V0HLfz_Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: aaron lwe <aaron.lwe@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thu, May 19, 2011 at 11:28:45PM +0800, aaron lwe wrote:
> On Thu, May 19, 2011 at 11:14 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > Ok, so that sounds like we need to call _PS0 on initial device setup.
> > It'd be better to do that than to try to figure out a way for oyu to
> > call it later.
> 
> Totally agree ;-)
> So are you going to write a patch for this?

I've a pile of other things that I need to fix at the moment, but with 
luck someone will...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
