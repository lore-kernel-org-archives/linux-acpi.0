From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Sun, 09 Nov 2008 02:00:59 -0800
Message-ID: <4916B4DB.90602@zytor.com>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <200811080930.21462.arvidjaar@mail.ru> <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain> <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu> <4916B38B.7050905@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:50570 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbYKIKBo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Nov 2008 05:01:44 -0500
In-Reply-To: <4916B38B.7050905@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

Avi Kivity wrote:
> 
> I think the sequence should be acpi -> kbd -> triple fault.  Given that
> Windows uses ACPI, the number of machines that support it is much larger
> (and growing daily) than the number of machines that do not.
> 

Like with many other things ACPI, there probably should be an ACPI date
cutoff for using it by default.  There is also port CF9 reboot (often
incorrectly described as "PCI reboot", but it has nothing to do with the
PCI standard.)

	-hpa
