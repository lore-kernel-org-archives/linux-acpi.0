From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Fan running continuously after kernel switch
Date: Fri, 16 Jan 2009 14:52:16 +0800
Message-ID: <1232088736.4001.6.camel@yakui_zhao.sh.intel.com>
References: <1232008941.24218.6.camel@pancake>
	 <1232011776.3989.25.camel@yakui_zhao.sh.intel.com>
	 <1232011930.24218.13.camel@pancake>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41702 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565AbZAPGlB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Jan 2009 01:41:01 -0500
In-Reply-To: <1232011930.24218.13.camel@pancake>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, hmh@hmh.eng.br

On Thu, 2009-01-15 at 17:32 +0800, Florian Echtler wrote:
> Hello Zhao,
> 
> > > yesterday, I switched from kernel 2.6.25-gentoo-r8 to 2.6.27-gentoo-r7
> > Please attach the output of acpidump so that we can confirm whether the
> > fan device is controlled by thinkpad acpi driver or generic fan driver.
> Dumpfile is attached.
thanks for the acpidump.
>From the dumpfile it seems that the fan is not controlled by the generic
ACPI fan driver. It seems that it is controlled by thinkpad_acpi driver.
cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> 
> > Will you please check the kernel version of 2.6.27-gentoo-r7?
> If you mean what stock kernel this is based on: it's 2.6.27.10.
> 
> > How about this issue if you only update the kernel?
> I'm quite sure I didn't update anything besides the kernel..
Please double check it again. 
Thanks.
> 
> Thanks, Yours, Florian

