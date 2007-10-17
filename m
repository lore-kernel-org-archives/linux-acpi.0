From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] Recent Lenovo ThinkPads define a dummy grahpics
	device, find it and ignore it
Date: Wed, 17 Oct 2007 10:25:37 +0200
Message-ID: <1192609537.9847.630.camel@queen.suse.de>
References: <1192465995.9847.587.camel@queen.suse.de>
	 <20071016175053.GB17671@netswarm.net>
	 <20071016180919.GH7262@bart.intergenia.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:58173 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754059AbXJQIZq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Oct 2007 04:25:46 -0400
In-Reply-To: <20071016180919.GH7262@bart.intergenia.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maik Broemme <mbroemme@plusserver.de>
Cc: Christian Birchinger <joker@netswarm.net>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, ibm-acpi-devel <ibm-acpi-devel@lists.sourceforge.net>

On Tue, 2007-10-16 at 20:09 +0200, Maik Broemme wrote:
> Hi,
> 
> Christian Birchinger <joker@netswarm.net> wrote:
> > On Mon, Oct 15, 2007 at 06:33:15PM +0200, Thomas Renninger wrote:
> > > Recent Lenovo ThinkPads define a dummy grahpics device, find it and ignore it
> > 
> > I think it's ok. dmesg says:
> > 
> > ACPI: Video device VID not physically connected, ignoring
> > input: Video Bus as /devices/virtual/input/input11
> > ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
> > 
> 
> No i think thats not enough because not everyone is using the ACPI video
> extension at this moment and at least for my ThinkPad X61 i got:
> 
> babyface@bart:~$ ls /proc/acpi/video/VID
> CRT0  DOS  DVI0  LCD0  POST  POST_info  ROM  info
> babyface@bart:~$ ls /proc/acpi/video/VID1
> CRT0  DOS  DVI0  LCD0  POST  POST_info  ROM  info
> 
> input: Video Bus as /devices/virtual/input/input3
> ACPI: Video Device [VID] (multi-head: yes rom: no  post: no)
> input: Video Bus as /devices/virtual/input/input4
> ACPI: Video Device [VID1] (multi-head: yes rom: no  post: no)
> 
> Anyway, also tools like lspci should show you the fake vga device and
> the X.org will complaint about it like:
> 
> (WW) intel: No matching Device section for instance (BusID PCI:0:2:1) found
> 
> And if you add this section (just for people who want to fix those
> warnings) your X server will no longer start. :) Can someone correct me if
> i am wrong?
Can you send lspci output and check your BIOS version (dmidecode |less,
there should be a string like KEWWT456 and a version, not sure, AFAIK
2.01 should be about the latest...).

Thanks,

    Thomas

