From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC] EC registers - Adding sysfs interface?
Date: Tue, 13 Nov 2007 21:40:48 +0300
Message-ID: <4739EFB0.7080507@suse.de>
References: <200711131724.31868.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:55437 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751947AbXKMSkz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Nov 2007 13:40:55 -0500
In-Reply-To: <200711131724.31868.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

Carlos Corbacho wrote:
> Alexey,
> 
> I'm considering writing a sysfs interface for the EC registers, and was 
> wondering if you would be ok with such a patch (before I start work on it)?
What do you need that for?
> 
> I'd like to expose the registers to userspace, as it is already possible to 
> access the EC registers in userspace via /dev/ports (and quite a few of us 
Well, this is not an argument. You have access to all memory through /dev/mem, 
so what?
> would like to access them) - however, the problem with doing this is that 
> ACPI throws quite a few warnings/ errors in dmesg whilst doing this; it would 
> therefore be far preferable to expose the registers through sysfs, which 
> would in turn be based on the ec_{read,write} calls, so we don't end up 
> stepping on ACPI's toes.
I think it is better to do it in file system that allows seek(). So you could do with 
1 file instead of 256 of them. 
> 
> So, basically, I'm proposing something like:
> 
> /sys/firmware/acpi/ec/ecX
> |
> |-> 0
> |-> 1
> |-> 2
> |-> etc... (up to 255)
> 
> Where each file returns the contents of the EC register in question (via 
> ec_read()), and writing to the file calls ec_write().
Carlos, I don't like the idea of 256 files. This will consume too many resources and will not bring much value.
If you want to have something permanent, it should be slim and fast.
If we talk about some debug/research/RE, do it as you like, but don't ask for submission into kernel :) 

Regards,
Alex.
