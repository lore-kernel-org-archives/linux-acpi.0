From: Olivier Nicolas <olivn@trollprod.org>
Subject: Re: 2.6.19-rc5 x86_64 irq 22: nobody cared
Date: Thu, 09 Nov 2006 10:29:05 +0100
Message-ID: <4552F4E1.2090104@trollprod.org>
References: <4551D12D.4010304@trollprod.org> <20061109064956.GG4729@stusta.de> <86802c440611082355q67c69da2v316062bbe0170a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outmx023.isp.belgacom.be ([195.238.4.204]:33209 "EHLO
	outmx023.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1754799AbWKIJ3H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Nov 2006 04:29:07 -0500
In-Reply-To: <86802c440611082355q67c69da2v316062bbe0170a9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: Adrian Bunk <bunk@stusta.de>, Stephen Hemminger <shemminger@osdl.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com, linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Yinghai Lu wrote:
> olivier,
> 
> lspci -vvxxx please.
> 
> it seems usb and audio share the interrtupts by ioapic.
> 
> YH

lspci -vvxxx is available at http://olivn.trollprod.org/lspci.gz

2.6.19-rc5 can be booted properly on my system if "notsc" parameter is used.

Could it be related to http://lkml.org/lkml/2006/10/27/141 as I'm usage 
a dual core AMD64 ?



Olivier


