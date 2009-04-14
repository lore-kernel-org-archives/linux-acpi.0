From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: 2.6.30-rc1 (latest git): thinkpad-acpi: cannot control
	brightness with hotkeys
Date: Tue, 14 Apr 2009 09:02:36 +0800
Message-ID: <1239670956.7661.245.camel@rzhang-dt>
References: <49E10684.5090101@gmail.com>
	 <20090411150555.8b13ed18.akpm@linux-foundation.org>
	 <20090412161448.GC26502@khazad-dum.debian.net> <49E234ED.5010105@gmail.com>
	 <1239587622.7661.205.camel@rzhang-dt> <49E357D9.40604@gmail.com>
	 <49E3828A.5010004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19433 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbZDNBCQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 21:02:16 -0400
In-Reply-To: <49E3828A.5010004@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Niel Lambrechts <niel.lambrechts@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Andrew Morton <akpm@linux-foundation.org>, "linux.kernel" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Niel,

please make sure CONFIG_ACPI_VIDEO is set,
please attach the full dmesg output.

thanks,
rui

On Tue, 2009-04-14 at 02:20 +0800, Niel Lambrechts wrote:
> On 04/13/2009 05:18 PM, Niel Lambrechts wrote:
> > On 04/13/2009 03:53 AM, Zhang Rui wrote:
> >   
> >> please attach the acpidump output.
> >> please apply this patch and see if it helps,
> >> http://patchwork.kernel.org/patch/17339/
> >>   
> >>     
> > Hi,
> >
> > The patch you mention above has no effect when applied to the latest
> > 2.6.30-rc1 git kernel. I'm still unable to control brightness, and the
> > display is still blank on resume (unless I press both a keyboard key and
> > touch the synaptic pad).
> >
> > dmesg shows:
> > thinkpad_acpi: ThinkPad ACPI Extras v0.22
> > thinkpad_acpi: http://ibm-acpi.sf.net/
> > thinkpad_acpi: ThinkPad BIOS 6FET50WW (1.20 ), EC 7VHT12WW-1.01
> > thinkpad_acpi: Lenovo ThinkPad W500, model 40622XG
> > thinkpad_acpi: radio switch found; radios are enabled
> > thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness
> > control, supported by the ACPI video driver
> > thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
> > Registered led device: tpacpi::thinklight
> > Registered led device: tpacpi::power
> > Registered led device: tpacpi::standby
> > thinkpad_acpi: Standard ACPI backlight interface available, not loading
> > native one.
> > pci 0000:00:02.0: power state changed by ACPI to D0
> >
> > but /sys/class/backlight still is empty.
> >
> > acpidump output attached, please let me know if I can test anything else
> > or provide more info...
> >   
> I've just retried this with the latest Lenovo firmware *2.12-1.01
> *6FET64WW (which came out last week). It still gives the same bad result
> though...
> 
> I attach acpidump again in case it matters after upgrading the BIOS.
> 
> cheers
> Niel
> 

