From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: Linux 2.6.28-rc1] ACPI Warning (nspredef-0852)[...]
Date: Tue, 28 Oct 2008 20:45:36 +0100
Message-ID: <8db1092f0810281245k14555e26w30547cf17fde534f@mail.gmail.com>
References: <fa.1HaqObZirROiyqr922A7hRDVc54@ifi.uio.no>
	 <fa.Rzh43vSl9NX1QQ2nOYQSgEJcZAw@ifi.uio.no> <49035313.9080309@shaw.ca>
	 <200810252004.01274.rjw@sisk.pl>
	 <8db1092f0810251151l4c7f9382r34defa6d4d6ee24c@mail.gmail.com>
	 <8db1092f0810271319s5d15c2ffrab37a548fa388738@mail.gmail.com>
	 <1225187050.5189.146.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:20695 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbYJ1Tpi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 15:45:38 -0400
In-Reply-To: <1225187050.5189.146.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Robert Hancock <hancockr@shaw.ca>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "fabio.comolli@gmail.com" <fabio.comolli@gmail.com>

2008/10/28 Zhao Yakui <yakui.zhao@intel.com>:
> Will you please try the attached patch on the latest kernel(2.6.28-rc1)
> and see whether the issue still exists?
>
> After the test, please attach the output of dmesg.
> Thanks.

It seems that patch solves problem.  Dmesg:
http://unixy.pl/maciek/download/kernel/2.6.28-rc1_tz/dmesg_2.6.28-rc1_ec.txt

On 2.6.27-rcx and 2.6.27 this error never happen.

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
