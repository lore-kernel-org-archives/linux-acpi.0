From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Fan running continuously after kernel switch
Date: Fri, 16 Jan 2009 19:23:26 -0200
Message-ID: <20090116212326.GE5719@khazad-dum.debian.net>
References: <1232008941.24218.6.camel@pancake> <1232011776.3989.25.camel@yakui_zhao.sh.intel.com> <1232011930.24218.13.camel@pancake> <1232088736.4001.6.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50200 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755748AbZAPVXa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Jan 2009 16:23:30 -0500
Content-Disposition: inline
In-Reply-To: <1232088736.4001.6.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Florian Echtler <floe@butterbrot.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 16 Jan 2009, Zhao Yakui wrote:
> On Thu, 2009-01-15 at 17:32 +0800, Florian Echtler wrote:
> > > > yesterday, I switched from kernel 2.6.25-gentoo-r8 to 2.6.27-gentoo-r7
> > > Please attach the output of acpidump so that we can confirm whether the
> > > fan device is controlled by thinkpad acpi driver or generic fan driver.
> > Dumpfile is attached.
> thanks for the acpidump.
> >From the dumpfile it seems that the fan is not controlled by the generic
> ACPI fan driver. It seems that it is controlled by thinkpad_acpi driver.
> cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The thinkpad-acpi driver exports an interface that can be used to control
the fan, but you do it on your own risk, and you have to EXPLICLTY opt-in by
giving it the fan_control=1 parameter.

Even if you do give thinkpad-acpi the fan_control=1 parameter, it won't
touch the fan at all unless you command it to through procfs or sysfs.

The driver doesn't do any sort of automated control, the EC does it by
itself.

What can help is for you to tell us the temperatures that thinkpad-acpi
report.  If any of them is above 43C, the fan will be left on continuously
by the EC.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
