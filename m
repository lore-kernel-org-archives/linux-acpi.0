From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Tue, 11 Nov 2008 10:26:07 -0800
Message-ID: <4919CE3F.4010008@zytor.com>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <200811080930.21462.arvidjaar@mail.ru> <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain> <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu> <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com> <20081110083938.GD22392@elte.hu> <4917F6A9.3020408@redhat.com> <20081110090241.GH22392@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45802 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbYKKS1Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2008 13:27:16 -0500
In-Reply-To: <20081110090241.GH22392@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Avi Kivity <avi@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

Ingo Molnar wrote:
> 
> well then we could insert CF9 to before the triple fault, and solve 
> some of the problems as well, without unnecessary risks.
> 
> This is a separate patch from ACPI reboot itself, naturally.
> 

This is a pretty good point.  There is extremely low risk of being
something at port CF9 that is something other than the reset register.
It may not be there, but if it isn't, the worst thing that happened is
we confused a device right before reset.

Even better if we condition the port CF9 write on existence a PCI bus
(or even more specifically PCI Configuration Method #1 or #2).  Port CF9
is extremely unlikely to exist on a machine without a PCI bus, and
extremely unlikely to conflict with anything else on a machine with a
PCI bus.

	-hpa
