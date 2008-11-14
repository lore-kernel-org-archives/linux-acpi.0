From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Thu, 13 Nov 2008 17:22:42 -0800
Message-ID: <491CD2E2.1060505@zytor.com>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>	 <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu>	 <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com>	 <20081110083938.GD22392@elte.hu>	<20081110115732.GA30181@srcf.ucam.org>	 <20081110125630.GC28643@elte.hu>	<20081110130029.GC30894@srcf.ucam.org>	 <alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>	 <20081112115806.GD11352@elte.hu> <491ACAB9.40203@redhat.com>	 <1226546613.4006.110.camel@yakui_zhao.sh.intel.com>	 <m1skpwntyu.fsf@frodo.ebiederm.org>	 <1226554186.4006.136.camel@yakui_zhao.sh.intel.com>	 <m1ljvom7sz.fsf@frodo.ebiederm.org>	 <1226567180.4006.171.camel@yakui_zhao.sh.intel.com>	 <491C66EA.7030900@zytor.com> <1226626153.4006.184.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:55005 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460AbYKNBZM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Nov 2008 20:25:12 -0500
In-Reply-To: <1226626153.4006.184.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>

Zhao Yakui wrote:
> I do the test as required. First the 0x02 is written to 0xCF9 I/O port.
> The return value by reading the 0xCF9 I/O port is 0x02. Then the 0x06 is
> written to the 0xCF9 I/O port. The screen becomes black but the box
> can't be rebooted.

What is the value of the CF9 port before you do anything?

	-hpa
