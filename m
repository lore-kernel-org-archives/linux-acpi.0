From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: FAN Processor and Thermap
Date: Fri, 10 Apr 2009 18:32:06 -0600
Message-ID: <49DFE506.8040307@gmail.com>
References: <335b7d740903190118r32d6f4d4ia9146bf2f0d9f6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f160.google.com ([209.85.217.160]:33397 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbZDKAcP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Apr 2009 20:32:15 -0400
Received: by gxk4 with SMTP id 4so2969670gxk.13
        for <linux-acpi@vger.kernel.org>; Fri, 10 Apr 2009 17:32:13 -0700 (PDT)
In-Reply-To: <335b7d740903190118r32d6f4d4ia9146bf2f0d9f6f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ken Perl <kenperl@gmail.com>
Cc: linux-acpi@vger.kernel.org

Ken Perl wrote:
> After I replaced my mainboard, then I can see errors related to ACPI
> during the Linux booting, I can also reproduce it with command below,
> 
> moproble fan processor thermap
> 
> I got error "no such device",  I ever tried to append following lines
> to the /etc/modprobe.d/blacklist but can not succeed, I can still see
> same error during boot, another error is "ACPI unable to load system
> description tables",
> 
> blacklist fan
> blacklist processor
> blacklist thermap
> 
> Do these a big problem? Can anyone tell how I can fix the issue?
> 

Can you post your dmesg output? Make sure that the motherboard doesn't 
have ACPI disabled in the BIOS or something (I don't think many even 
have that option anymore, but who knows).
