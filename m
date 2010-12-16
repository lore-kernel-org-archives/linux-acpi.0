From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: acpi_battery_init() boot speed
Date: Wed, 15 Dec 2010 20:58:45 -0800
Message-ID: <20101215205845.3e13fad2@infradead.org>
References: <alpine.LFD.2.00.1012150308260.4878@x980>
	<20101215030054.0aae9e1e@infradead.org>
	<alpine.LFD.2.00.1012151517090.21167@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:58232 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab0LPE4H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Dec 2010 23:56:07 -0500
In-Reply-To: <alpine.LFD.2.00.1012151517090.21167@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Wed, 15 Dec 2010 15:27:44 -0500 (EST)
Len Brown <lenb@kernel.org> wrote:

> 
> > wonder if this stuff is polling some battery property ?
> > (like discharge rate or something)
> 
> Is there a simple way to get a profile that starts when
> acpi_battery_init() is called and ends when it returns?
> 
> Note that acpi_battery_init() is not 900ms on all boxes --
> I had to poke around to find a slow one.  My arrandale
> laptop runs acpi_battery_init in 71 ms.

make it a module, and run "perf top" while in an other terminal you do

while :; do modprobe acpi_battery ; rmmod acpi_battery  ; done



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
