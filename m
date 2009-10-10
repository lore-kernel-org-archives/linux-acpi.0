From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: lenovo ideapad s12 dsdt errors...
Date: Fri, 09 Oct 2009 19:42:29 -0600
Message-ID: <4ACFE685.1020209@gmail.com>
References: <1255116847.12236.272.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:47663 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942AbZJJBnJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2009 21:43:09 -0400
Received: by qyk2 with SMTP id 2so6995820qyk.21
        for <linux-acpi@vger.kernel.org>; Fri, 09 Oct 2009 18:42:32 -0700 (PDT)
In-Reply-To: <1255116847.12236.272.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scott Dylewski <scott@dylewski.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 10/09/2009 01:34 PM, Scott Dylewski wrote:
> I just bought a Lenovo S12 netbook (atom processor) and installed Ubuntu
> Karmic netbook remix on it, and I'm having some issues.  I'm getting
> some long boot times, and wonder if it's related to the ACPI stuff.
>
> So I found some stuff online that suggests that my dsdt may have some
> errors, and when I checked, it used a MSFT compiler and had a bunch of
> warnings and errors, but I don't know how to fix them.  Can someone
> direct me a bit and either help me fix the errors if needed, or let me
> know what to do?

That's probably outdated advice - the kernel normally tries to deal with 
such issues itself (or handle them the same way as Windows does, which 
presumably works) and so replacing the DSDT isn't likely to help much. 
Anyway, it's far from clear that your problem is at all related.

Are there any errors showing up in dmesg?
