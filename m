From: Mattia Dongili <malattia@linux.it>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 5 Jan 2007 10:15:40 +0100
Message-ID: <20070105091539.GA13533@inferi.kami.home>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <200701040024.29793.lenb@kernel.org> <1167905384.7763.36.camel@localhost.localdomain> <20070104191512.GC25619@inferi.kami.home> <20070104125107.b82db604.akpm@osdl.org> <1167953784.4901.5.camel@localhost.localdomain> <Pine.LNX.4.61.0701050110170.8556@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:47091 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965112AbXAEJQg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jan 2007 04:16:36 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0701050110170.8556@yvahk01.tjqt.qr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Stelian Pop <stelian@popies.net>, Andrew Morton <akpm@osdl.org>, Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

On Fri, Jan 05, 2007 at 01:11:16AM +0100, Jan Engelhardt wrote:
> 
> On Jan 5 2007 00:36, Stelian Pop wrote:
> >@@ -61,6 +61,7 @@ static struct acpi_driver sony_acpi_driv
> > 
> > static acpi_handle sony_acpi_handle;
> > static struct proc_dir_entry *sony_acpi_dir;
> >+static struct acpi_device *sony_acpi_acpi_device = NULL;
> 
> acpi_acpi?
> 
> >@@ -310,7 +315,7 @@ static int sony_acpi_add(struct acpi_dev
> > 		    		 item->acpiset, &handle)))
> > 		    	continue;
> > 
> >-		item->proc = create_proc_entry(item->name, 0600,
> >+		item->proc = create_proc_entry(item->name, 0666,
> > 					       acpi_device_dir(device));
> > 		if (!item->proc) {
> > 			printk(LOG_PFX "unable to create proc entry\n");
> 
> Is this safe? I would not want normal users to poke on that.

Hmmm, seconded. It also seems quite a gratuitous change and I have a
different patch that takes care of permissions and the /proc stuff is
going away in any case.

-- 
mattia
:wq!
