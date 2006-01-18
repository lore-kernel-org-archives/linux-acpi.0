From: Thomas Renninger <acpi@renninger.de>
Subject: Re: Shutdown without poweroff (notebook)
Date: Wed, 18 Jan 2006 13:19:34 +0100
Message-ID: <43CE3256.3050200@renninger.de>
References: <200601171121.49406.oliver.eichler@dspsolutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:50154 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030301AbWARMTi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 07:19:38 -0500
In-Reply-To: <200601171121.49406.oliver.eichler@dspsolutions.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: oliver.eichler@dspsolutions.de
Cc: linux-acpi@vger.kernel.org

Oliver Eichler wrote:
> Hi,
> 
> My system:
> Acer 5024 notebook
> SuSE 10.0
> 
> My problem:
> The notebook will not poweroff at shutdown.
> 
> I guess there is something wrong with ACPI. However I have no clue where to 
> start looking. Can anyone give me a hand on troubleshouting?
> 
Ndiswrapper should be unrelated (just try without loading the module and you'll know).
I got reports for an ACER Ferrari.
Some reported that uncommenting the gfxmenu entry in /boot/grub/menu.lst helped.
For some others it will reveal another problem then: shutdown is doing a reboot one time...
Also see:
https://bugzilla.novell.com/show_bug.cgi?id=141238

Good luck,

     Thomas
