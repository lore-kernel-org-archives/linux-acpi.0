From: MoRpHeUz <morpheuz@gmail.com>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 5 Jan 2007 00:20:23 -0200
Message-ID: <7ce7bf330701041820l5132ddbfsd3dd2b6ea826f3ae@mail.gmail.com>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
	 <1167905384.7763.36.camel@localhost.localdomain>
	 <20070104191512.GC25619@inferi.kami.home>
	 <20070104125107.b82db604.akpm@osdl.org>
	 <1167953784.4901.5.camel@localhost.localdomain>
	 <20070104154434.7e1a7c83.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:36182 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030279AbXAECUZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jan 2007 21:20:25 -0500
Received: by ug-out-1314.google.com with SMTP id u2so3524834uge
        for <linux-acpi@vger.kernel.org>; Thu, 04 Jan 2007 18:20:23 -0800 (PST)
In-Reply-To: <20070104154434.7e1a7c83.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

Hi,

  I own a Sony Vaio VGN-SZ340 and I had problems regarding acpi + it's
dual core processor. The guys from Intel gave me a workaround and now
it recognises both cores.

  The problem is that it does not do cpu frequency scaling for both
cores, just for cpu0...And when I boot with acpi the Nvidia graphic
card doesnt work also.

  I don't know if you know about these problems regarding sony acpi.
The guys from Intel said that this notebook have 2 dst's. So to detect
both cores the workaround just uses the second dst (although frequency
scaling does work for both.)

  I can help you to fix this bug...I have the machine where we can do
some tests..


Best regards,


On 1/4/07, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 05 Jan 2007 00:36:23 +0100
> Stelian Pop <stelian@popies.net> wrote:
>
> > Added acpi_bus_generate event for forwarding Fn-keys pressed to acpi subsystem,
> > and made correspondent necessary changes for this to work.
>
> neato.
>
> err, how does one use this?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
