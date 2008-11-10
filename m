From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Mon, 10 Nov 2008 13:56:30 +0100
Message-ID: <20081110125630.GC28643@elte.hu>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <200811080930.21462.arvidjaar@mail.ru> <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain> <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu> <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com> <20081110083938.GD22392@elte.hu> <20081110115732.GA30181@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:48403 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232AbYKJM5N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Nov 2008 07:57:13 -0500
Content-Disposition: inline
In-Reply-To: <20081110115732.GA30181@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>


* Matthew Garrett <mjg@redhat.com> wrote:

> On Mon, Nov 10, 2008 at 09:39:38AM +0100, Ingo Molnar wrote:
> 
> > so, the sequence should be:
> > 
> >  [ acpi if date > 2007 ] -> kbd -> triple fault
> 
> No. We should find out which versions of Windows use the ACPI boot 
> mechanism and then
> 
> [ acpi if firmware indicates Vista support ] -> whatever
> 
> or something. Microsoft appear to have moved away from using date 
> cutoffs for anything other than whether or not to enable ACPI in the 
> first place, and we ought to attempt compatibility with them.

okay, that's fine to me too. My main point is that we need something 
nuanced this time around (be it a string check or a cutoff) - not the 
"enable again" patch that i saw in the ACPI tree and which i had to 
NAK.

	Ingo
