From: Mattia Dongili <malattia@linux.it>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 5 Jan 2007 17:24:48 +0100
Message-ID: <20070105162448.GE13533@inferi.kami.home>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <200701040024.29793.lenb@kernel.org> <1167905384.7763.36.camel@localhost.localdomain> <20070104191512.GC25619@inferi.kami.home> <459E1909.9020703@fnxweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:38064 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161142AbXAEQYz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jan 2007 11:24:55 -0500
Content-Disposition: inline
In-Reply-To: <459E1909.9020703@fnxweb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Neil Bird <neil@fnxweb.com>
Cc: linux-acpi@vger.kernel.org

On Fri, Jan 05, 2007 at 09:23:21AM +0000, Neil Bird wrote:
> Around about 04/01/07 19:15, Mattia Dongili typed ...
> >I have the hw and I'd be happy to do some basic working on the code
> 
>   OK, I'm going to jump in here with something I've been meaning to post 
> for a while;  now seems as good a time as any :)
> 
>   I *think* I'm using the code you're all talking about on my Vaio:  the 
> sony_acpi (0.3?) module that works where the stick s=kernel sonypi doesn't.
>
>   I'm also (currently) using the fsfn daemon/osd-app, or at least modified 
> versions of them (my laptop, like other poeple's, doesn't report back the 
> current brightness, so the fsfn daemon remembers the value and uses that 
> instead for higher/lower settings).
> 
> 
>   I've been tinkering with the module code, initially just to add this 
> brightness-value memory to the module (so the /proc entries do actually 
> work) via a module param, and this works a treat.
> 
>   I've also added the ability to watch for key presses and inject fake key 
> presses, so that the Fn buttons are seen by the kernel and X, etc., and can 
> thus be bound by GNOME or KDE in the normal fashion, making it (for me) 
> more immediately useful, esp. for the generic keys (S1/S2 on mine).
> 
>   But last time I tried (couple of kernel releases ago) it crashes on 
> start-up;  I think it's something to do with kmallocs in the ACPI code 
> tyhat I'm calling that aren't allowed in certain contexts, buit I have no 
> control over what kmallocs are used in acpi.
> 
>   If anyone's interested, I'll email them my latest copy.  I got a bit 
> stuck as the last attempt lost the actual error off the top of the screen 
> before locking and I don't know how to get the console output, erm, output 
> to anything other than the screen on my laptop.

Ok, could you send me a copy? I'll see if I can add some of your code.
BTW, which vaio model is this?

Can you send me the DSDT too?
(acpidump -b -t DSDT -o DSDT.aml && iasl -d DSDT.aml)

Thanks
-- 
mattia
:wq!
