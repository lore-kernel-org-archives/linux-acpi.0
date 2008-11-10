From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Mon, 10 Nov 2008 09:39:38 +0100
Message-ID: <20081110083938.GD22392@elte.hu>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <200811080930.21462.arvidjaar@mail.ru> <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain> <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu> <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:37854 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753909AbYKJIkB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Nov 2008 03:40:01 -0500
Content-Disposition: inline
In-Reply-To: <4916B4DB.90602@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>


* H. Peter Anvin <hpa@zytor.com> wrote:

> Avi Kivity wrote:
> > 
> > I think the sequence should be acpi -> kbd -> triple fault.  Given that
> > Windows uses ACPI, the number of machines that support it is much larger
> > (and growing daily) than the number of machines that do not.
> > 
> 
> Like with many other things ACPI, there probably should be an ACPI 
> date cutoff for using it by default.  There is also port CF9 reboot 
> (often incorrectly described as "PCI reboot", but it has nothing to 
> do with the PCI standard.)

so, the sequence should be:

 [ acpi if date > 2007 ] -> kbd -> triple fault

Where in this sequence should we insert port-CF9 reboot? We have no 
discovery of it, etc. The KGDB reboot will do _something_ on most 
boxes, so inserting it like this:

 [ acpi	if date	> 2007 ] -> kbd -> port-CF9 -> triple fault

... will likely have no practical impact as we rarely get to the 
triple fault method to begin with. So the reboot chain we'd like to 
have is:

 [ acpi	if date	> 2007 ] -> safe-port-CF9 -> kbd -> triple fault

... where safe-port-CF9 is something that can be done safely on all 
x86 boxes.

Anyway, safe-port-CF9 aside, the ACPI sequence should definitely be 
cutoff based, so the plain re-introduction of the patch that changes 
the default is not acceptable.

	Ingo
