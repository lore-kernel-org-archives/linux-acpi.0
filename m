From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Sat, 8 Nov 2008 12:59:56 +0100
Message-ID: <20081108115956.GE8354@elte.hu>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <200811080930.21462.arvidjaar@mail.ru> <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain> <200811081050.25477.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:40675 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031AbYKHMAW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Nov 2008 07:00:22 -0500
Content-Disposition: inline
In-Reply-To: <200811081050.25477.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>


* Andrey Borzenkov <arvidjaar@mail.ru> wrote:

> > Please open up a bug report
> > http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> > and attach the dmesg, plus the output from acpidump and dmidecode.
> > 
> 
> there is already bug report to track this regression; I added files there
> but I am not able to change product (bug was opened by Rafael):
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=11895

Len, please consider my Lenovo T60 laptop "possibly affected" too. I 
was seeing weird sporadic reboot hangs which went away roughly since 
around that revert.

So the negative scope of the change, even after such short amount of 
testing, is non-trivial, and we simply have to go via a flag day date 
approach. Or, if these bugs are debuggable, make the ACPI reboot 
sequence more reliable.

	Ingo
