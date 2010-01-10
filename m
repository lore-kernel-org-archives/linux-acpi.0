From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [patch] hp-wmi: fix double free
Date: Sun, 10 Jan 2010 10:38:37 +0000
Message-ID: <9b2b86521001100238x5c373f7x856a255e940baa5d@mail.gmail.com>
References: <20100110074529.GF7840@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:52763 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab0AJKij (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Jan 2010 05:38:39 -0500
In-Reply-To: <20100110074529.GF7840@bicker>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>, linux-kernel@vger.kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 1/10/10, Dan Carpenter <error27@gmail.com> wrote:
> kfree(obj) was called earlier.
>
> This was found by smatch and has only been compile tested.  :/

I don't see hp-wmi in MAINTAINERS, but in general platform drivers go
via the ACPI tree.

It looks like several others have discovered this issue the hard way
:-).  <http://www.pubbs.net/kernel/201001/14288/>.

Fortunately it has been fixed in the acpi tree and now submitted to
Linus.  <http://linux.derkeiler.com/Mailing-Lists/Kernel/2010-01/msg02511.html>.

Regards
Alan

> --- orig/drivers/platform/x86/hp-wmi.c	2010-01-09 21:43:13.000000000 +0300
> +++ devel/drivers/platform/x86/hp-wmi.c	2010-01-09 21:43:28.000000000 +0300
> @@ -388,8 +388,6 @@ static void hp_wmi_notify(u32 value, voi
>  	} else
>  		printk(KERN_INFO "HP WMI: Unknown key pressed - %x\n",
>  			eventcode);
> -
> -	kfree(obj);
>  }
