From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: any way to evaluate a device's _PS0 method when its power
 state is at D0?
Date: Thu, 19 May 2011 16:14:00 +0100
Message-ID: <20110519151400.GA16348@srcf.ucam.org>
References: <BANLkTim-sswOsPZZzH7QOWQgqpwJ_EzeNQ@mail.gmail.com>
 <20110519124221.GA11831@srcf.ucam.org>
 <BANLkTimmDa55sgFgQbnD6sdNnvt8U+OXUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43566 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238Ab1ESPOF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2011 11:14:05 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimmDa55sgFgQbnD6sdNnvt8U+OXUQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: aaron lwe <aaron.lwe@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thu, May 19, 2011 at 11:05:24PM +0800, aaron lwe wrote:

> Since this device's state is set to D0 in acpi_bus_init_power without
> evaluating _PS0 control method, and I need HASD to be set to 1 for
> _PS0 to be evaluated effectively when I put the device back to D0 from
> D3, I'll need to evaluate _PS0 when this device's power state is at
> D0.

Ok, so that sounds like we need to call _PS0 on initial device setup. 
It'd be better to do that than to try to figure out a way for oyu to 
call it later.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
