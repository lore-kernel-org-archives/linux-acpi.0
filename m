From: Maik Broemme <mbroemme@plusserver.de>
Subject: Re: [PATCH 2/2] Recent Lenovo ThinkPads define a dummy grahpics
	device, find it and ignore it
Date: Tue, 16 Oct 2007 20:09:20 +0200
Message-ID: <20071016180919.GH7262@bart.intergenia.de>
References: <1192465995.9847.587.camel@queen.suse.de> <20071016175053.GB17671@netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isis45.plusserver.de ([217.172.174.164]:46035 "EHLO
	isis45.plusserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965305AbXJPSNC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Oct 2007 14:13:02 -0400
Content-Disposition: inline
In-Reply-To: <20071016175053.GB17671@netswarm.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Birchinger <joker@netswarm.net>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, ibm-acpi-devel <ibm-acpi-devel@lists.sourceforge.net>

Hi,

Christian Birchinger <joker@netswarm.net> wrote:
> On Mon, Oct 15, 2007 at 06:33:15PM +0200, Thomas Renninger wrote:
> > Recent Lenovo ThinkPads define a dummy grahpics device, find it and ignore it
> 
> I think it's ok. dmesg says:
> 
> ACPI: Video device VID not physically connected, ignoring
> input: Video Bus as /devices/virtual/input/input11
> ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
> 

No i think thats not enough because not everyone is using the ACPI video
extension at this moment and at least for my ThinkPad X61 i got:

babyface@bart:~$ ls /proc/acpi/video/VID
CRT0  DOS  DVI0  LCD0  POST  POST_info  ROM  info
babyface@bart:~$ ls /proc/acpi/video/VID1
CRT0  DOS  DVI0  LCD0  POST  POST_info  ROM  info

input: Video Bus as /devices/virtual/input/input3
ACPI: Video Device [VID] (multi-head: yes rom: no  post: no)
input: Video Bus as /devices/virtual/input/input4
ACPI: Video Device [VID1] (multi-head: yes rom: no  post: no)

Anyway, also tools like lspci should show you the fake vga device and
the X.org will complaint about it like:

(WW) intel: No matching Device section for instance (BusID PCI:0:2:1) found

And if you add this section (just for people who want to fix those
warnings) your X server will no longer start. :) Can someone correct me if
i am wrong?

> # ls /proc/acpi/video/
> VID/
> 
> (Only one entry now -> good)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--Maik
