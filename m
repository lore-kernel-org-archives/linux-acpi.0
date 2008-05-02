From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Fwd: Overriding ACPI tables]
Date: Fri, 02 May 2008 10:43:35 -0700
Message-ID: <481B52C7.3040101@zytor.com>
References: <1209661364.1131.8.camel@linux-2bdv.site> <481AE9D0.1030407@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60205 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758145AbYEBRoA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 May 2008 13:44:00 -0400
In-Reply-To: <481AE9D0.1030407@tremplin-utc.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Piel <eric.piel@tremplin-utc.net>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org, Richard <tuxbox.guru@gmail.com>, andreas.herrmann3@amd.com

Eric Piel wrote:
> Hi Peter,
> 
> Thank you for the pointer. You are talking about setup_data, right? I'll 
> try to use it for reading the DSDT table. I have a couple of questions 
> though:
> * I can find reference of it only in setup_64.c, is it planned to add 
> support also for 32bit? (That's a must for me)
> * From inside the kernel, all I have to do is to add a hook inside 
> parse_setup_data(), allocate memory and I'll be able to copy the data 
> into this safe place, right?
> * Is there any bootloader which already has support for this extension? 
>  By chance, would you have a patch for grub?
> 

It is planned, but not yet implemented, because the early reservations 
infrastructure hasn't been ported over to 32 bits yet.  The intent is to 
reserve this memory early and automatically.

So far this has only been used for large EFI SGI machines, so it's 
probably been implemented on ELILO only.  As far as Grub is concerned, I 
won't touch it with a ten-foot pole.

	-hpa
