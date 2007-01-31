From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: Re: Missing "alarm"
Date: Wed, 31 Jan 2007 09:26:39 +0800
Message-ID: <58A36151585E4047913F40517D307BAE43BDD7@pdsmsx404.ccr.corp.intel.com>
References: <135ab3ff0701301336gc04fee7lc799cc3a07679700@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16796 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932175AbXAaB0p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jan 2007 20:26:45 -0500
Content-class: urn:content-classes:message
In-Reply-To: <135ab3ff0701301336gc04fee7lc799cc3a07679700@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Morten Friesgaard <friesgaard@gmail.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

># CONFIG_HOTPLUG_CPU is not set
Please set "Support for hot-pluggable CPUs"

Best regards,
Zhang.Rui(Ray)

=20
-----Original Message-----
=46rom: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.=
kernel.org] On Behalf Of Morten Friesgaard
Sent: 2007=C4=EA1=D4=C231=C8=D5 5:37
To: Alexey Starikovskiy
Cc: linux-acpi@vger.kernel.org
Subject: Re: Re: Missing "alarm"

Here it is :)
/Morten


ps. forgot to tell that i have also tried to fix the dsdt ... that
diden't solve the problem either...
http://gentoo-wiki.com/HOWTO_Fix_Common_ACPI_Problems

On 30/01/07, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com=
> wrote:
> Please attach your config file.
>
> Regards,
>     Alex.
>
> Morten Friesgaard wrote:
> > Hey.
> > I have searched various sites, but cannot find a solution to my pro=
blem.
> > I'm running a mythtv media center, and I need automatic startup - s=
o
> > of course I use ACPI. (it works with speed stepping
> > CONFIG_X86_POWERNOW_K8_ACPI=3Dy)
> > I have an asus k8n-vm motherboard that support acpi 2.0
> >
> > # uname -a
> > Linux mythbox 2.6.18-gentoo-r6 #1 SMP Mon Jan 29 20:38:18 CET 2007
> > i686 AMD Sempron(tm) Processor 3000+ AuthenticAMD GNU/Linux
> >
> >
> >
> > However I have one big problem (trying to solve it the last 2-3 mon=
ths)
> >
> > /proc/acpi/alarm is missing
> >
> > so I tried to configure this in my kernel adding the following to m=
y
> > ".config":
> >
> > CONFIG_ACPI_SLEEP=3Dy
> > CONFIG_ACPI_SLEEP_PROC_FS=3Dy
> >
> > (i found the following site
> > http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg04284.htm=
l
> > but haven't had any luck with that either, e.g. adding
> > CONFIG_ACPI_PROCFS)
> >
> > but each time I run "make menuconfig" or "genkernel --menuconfig al=
l"
> > ... the configure is not visible in the menu system or in the .conf=
ig
> > file. Somehow the system does not accept the configuration.
> >
> > I really do not understand this since the system,
> > at http://www.mythtv.org/wiki/index.php/ACPI_Wakeup
> > i found that my system should be able to use this function
> >
> > grep -r CONFIG_ACPI_SLEEP_PROC_FS arch/*
> > arch/x86_64/defconfig:CONFIG_ACPI_SLEEP_PROC_FS=3Dy
> >
> >
> > Anyone might know what is wrong?
> > Regards, Morten
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
