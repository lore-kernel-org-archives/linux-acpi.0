From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Mon, 10 Nov 2008 11:57:32 +0000
Message-ID: <20081110115732.GA30181@srcf.ucam.org>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <200811080930.21462.arvidjaar@mail.ru> <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain> <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu> <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com> <20081110083938.GD22392@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34027 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbYKJL6H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2008 06:58:07 -0500
Content-Disposition: inline
In-Reply-To: <20081110083938.GD22392@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Nov 10, 2008 at 09:39:38AM +0100, Ingo Molnar wrote:

> so, the sequence should be:
> 
>  [ acpi if date > 2007 ] -> kbd -> triple fault

No. We should find out which versions of Windows use the ACPI boot 
mechanism and then

[ acpi if firmware indicates Vista support ] -> whatever

or something. Microsoft appear to have moved away from using date 
cutoffs for anything other than whether or not to enable ACPI in the 
first place, and we ought to attempt compatibility with them.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
