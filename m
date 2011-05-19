From: aaron lwe <aaron.lwe@gmail.com>
Subject: Re: any way to evaluate a device's _PS0 method when its power state
 is at D0?
Date: Thu, 19 May 2011 23:28:45 +0800
Message-ID: <BANLkTinHONwV7aGPbxkCmVKrH0V0HLfz_Q@mail.gmail.com>
References: <BANLkTim-sswOsPZZzH7QOWQgqpwJ_EzeNQ@mail.gmail.com>
	<20110519124221.GA11831@srcf.ucam.org>
	<BANLkTimmDa55sgFgQbnD6sdNnvt8U+OXUQ@mail.gmail.com>
	<20110519151400.GA16348@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37401 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab1ESP2q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2011 11:28:46 -0400
Received: by eyx24 with SMTP id 24so826726eyx.19
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2011 08:28:45 -0700 (PDT)
In-Reply-To: <20110519151400.GA16348@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Thu, May 19, 2011 at 11:14 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Thu, May 19, 2011 at 11:05:24PM +0800, aaron lwe wrote:
>
>> Since this device's state is set to D0 in acpi_bus_init_power without
>> evaluating _PS0 control method, and I need HASD to be set to 1 for
>> _PS0 to be evaluated effectively when I put the device back to D0 from
>> D3, I'll need to evaluate _PS0 when this device's power state is at
>> D0.
>
> Ok, so that sounds like we need to call _PS0 on initial device setup.
> It'd be better to do that than to try to figure out a way for oyu to
> call it later.

Totally agree ;-)
So are you going to write a patch for this?
