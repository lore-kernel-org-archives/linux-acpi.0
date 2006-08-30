From: keith mannthey <kmannth@us.ibm.com>
Subject: Re: [PATCH 1/2] acpi hotplug cleanups, move install notifier to
	add function
Date: Wed, 30 Aug 2006 14:48:26 -0700
Message-ID: <1156974506.5663.26.camel@keithlap>
References: <20060810142329.EB03.Y-GOTO@jp.fujitsu.com>
	 <1155643418.4302.1154.camel@queen.suse.de>
	 <20060825205423.0778.Y-GOTO@jp.fujitsu.com>
	 <1156699188.1852.13.camel@linux-1vxn.site>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:13218 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932134AbWH3Vsc
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Aug 2006 17:48:32 -0400
In-Reply-To: <1156699188.1852.13.camel@linux-1vxn.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mail@renninger.de
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>, trenn@suse.de, andrew <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, ACPI-ML <linux-acpi@vger.kernel.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>, naveen.b.s@intel.com

On Sun, 2006-08-27 at 19:19 +0200, Thomas Renninger wrote:
> On Fri, 2006-08-25 at 20:59 +0900, Yasunori Goto wrote:
> > > I sent a patch a while ago that gets rid of the whole namespace walking
> > > by making acpi_memoryhotplug an acpi device and making use of the .add
> > > callback function and the acpi_bus_register_driver call.
> > > 
> > > I am not sure whether this is possible if you have multiple memory
> > > devices, though (if not maybe it should be made possible?)...
> > > 
> > > Yasunori even tested the patch and sent an Ok:
> > > http://marc.theaimsgroup.com/?t=114065312400001&r=1&w=2
> > > 
> > > If this is acceptable I can rebase the patch on a current kernel.
> > 
> > Hi. Thomas-san.
> > Did you rebase your patch?
> > 
> > I'm trying to do it now too. 
> > But, current code (2.6.18-rc4) seems to register handler for
> > only enable status devices at boot time.
> > So, notification is -discarded- due to no handler for new memory
> > device when hot-add event occurs. Hmmm. :-(
> 
> Trying again with a real mailer, sorry about the previous junk ...
> The email address of the module author (naveen.b.s@intel.com) seems to
> be invalid?
> 
>     Thomas

Sorry for taking so long to test this out.  I just hooked it up with
2.6.18-rc4-mm3 (I built with CONFIG_ACPI_HOTPLUG_MEMORY=y) and I get

ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object
[ffff81107357a5d0] [20060707]

when I do a hot-add. It might be a day or two before I can sort out what
is going on but I think Yasunori's mail may be getting at the issue. (My
device is only presented to the OS at add time.)

Thanks,
  Keith 



