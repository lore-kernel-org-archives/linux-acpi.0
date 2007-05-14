From: Mattia Dongili <malattia@linux.it>
Subject: Re: Fwd: Re: Linux 2.6.22-rc1
Date: Mon, 14 May 2007 10:55:41 +0900
Message-ID: <20070514015541.GB4800@inferi.kami.home>
References: <Pine.LNX.4.61.0705131123280.9570@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi12.ns.itscom.net ([219.110.2.182]:53130 "EHLO
	mtoichi12.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758597AbXENBzs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 May 2007 21:55:48 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0705131123280.9570@yvahk01.tjqt.qr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, May 13, 2007 at 11:27:31AM +0200, Jan Engelhardt wrote:
> On May 12 2007 20:20, Linus Torvalds wrote:
> >
> >Ok, the merge window has closed, and 2.6.22-rc1 is out there.
> 
> I have hit a randconfig compile failure. .config attached.
> 
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `acpi_bus_generate_event':
> (.text+0x233f7): undefined reference to `event_is_open'
> drivers/built-in.o: In function `acpi_bus_get_power':
> (.text+0x236ad): undefined reference to `acpi_power_get_inferred_state'
> drivers/built-in.o: In function `acpi_bus_set_power':
> (.text+0x237c3): undefined reference to `acpi_power_transition'
> drivers/built-in.o: In function `acpi_bus_set_power':
> (.text+0x23835): undefined reference to `acpi_power_transition'
> drivers/built-in.o: In function `sony_pic_fanspeed_store':
> sony-laptop.c:(.text+0x91930): undefined reference to `ec_write'
> drivers/built-in.o: In function `sony_pic_fanspeed_show':
> sony-laptop.c:(.text+0x9195d): undefined reference to `ec_read'
> make: *** [.tmp_vmlinux1] Error 1

I actually can't reproduce it with your .config.
>From a clean tree, running make fires up the oldconfig which fixes the
many missing/garbled dependencies. In any case SONY_LAPTOP depends on
ACPI which always build EC statically if selected.

clues?

-- 
mattia
:wq!
