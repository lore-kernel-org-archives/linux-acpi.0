From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Sun, 09 Nov 2008 11:55:23 +0200
Message-ID: <4916B38B.7050905@redhat.com>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <200811080930.21462.arvidjaar@mail.ru> <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain> <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:41463 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470AbYKIJzu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Nov 2008 04:55:50 -0500
In-Reply-To: <20081108115956.GE8354@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

Ingo Molnar wrote:
> Len, please consider my Lenovo T60 laptop "possibly affected" too. I 
> was seeing weird sporadic reboot hangs which went away roughly since 
> around that revert.
>
>   

Given that Windows uses ACPI reboot, I find it unlikely that it is so 
unreliable.  Maybe some other problem in the tree got fixed?

> So the negative scope of the change, even after such short amount of 
> testing, is non-trivial, and we simply have to go via a flag day date 
> approach. Or, if these bugs are debuggable, make the ACPI reboot 
> sequence more reliable.

I think the sequence should be acpi -> kbd -> triple fault.  Given that 
Windows uses ACPI, the number of machines that support it is much larger 
(and growing daily) than the number of machines that do not.

-- 
error compiling committee.c: too many arguments to function

