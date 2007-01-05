From: Neil Bird <neil@fnxweb.com>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 05 Jan 2007 09:23:21 +0000
Message-ID: <459E1909.9020703@fnxweb.com>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <200701040024.29793.lenb@kernel.org> <1167905384.7763.36.camel@localhost.localdomain> <20070104191512.GC25619@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.uk.thalesgroup.com ([194.128.85.7]:4593 "EHLO
	CRAWSMAIL2.uk.thalesgroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965135AbXAEJi1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jan 2007 04:38:27 -0500
In-Reply-To: <20070104191512.GC25619@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: malattia@linux.it

Around about 04/01/07 19:15, Mattia Dongili typed ...
> I have the hw and I'd be happy to do some basic working on the code

   OK, I'm going to jump in here with something I've been meaning to post 
for a while;  now seems as good a time as any :)

   I *think* I'm using the code you're all talking about on my Vaio:  the 
sony_acpi (0.3?) module that works where the stick s=kernel sonypi doesn't.

   I'm also (currently) using the fsfn daemon/osd-app, or at least modified 
versions of them (my laptop, like other poeple's, doesn't report back the 
current brightness, so the fsfn daemon remembers the value and uses that 
instead for higher/lower settings).


   I've been tinkering with the module code, initially just to add this 
brightness-value memory to the module (so the /proc entries do actually 
work) via a module param, and this works a treat.

   I've also added the ability to watch for key presses and inject fake key 
presses, so that the Fn buttons are seen by the kernel and X, etc., and can 
thus be bound by GNOME or KDE in the normal fashion, making it (for me) more 
immediately useful, esp. for the generic keys (S1/S2 on mine).

   But last time I tried (couple of kernel releases ago) it crashes on 
start-up;  I think it's something to do with kmallocs in the ACPI code tyhat 
I'm calling that aren't allowed in certain contexts, buit I have no control 
over what kmallocs are used in acpi.

   If anyone's interested, I'll email them my latest copy.  I got a bit 
stuck as the last attempt lost the actual error off the top of the screen 
before locking and I don't know how to get the console output, erm, output 
to anything other than the screen on my laptop.

-- 
[neil@fnx ~]# rm -f .signature
[neil@fnx ~]# ls -l .signature
ls: .signature: No such file or directory
[neil@fnx ~]# exit
