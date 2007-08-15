From: raphaello-mouse@altern.org
Subject: Packard Bell DSDT issue
Date: Wed, 15 Aug 2007 11:19:08 +0200
Message-ID: <200708151119.09045.raphaello-mouse@altern.org>
References: <46BDBAEF.5030204@suse.de> <200708150044.29820.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp23.orange.fr ([193.252.22.126]:21341 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759694AbXHOKlj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Aug 2007 06:41:39 -0400
Received: from smtp23.orange.fr (mwinf2302 [10.232.4.24])
	by mwinf2320.orange.fr (SMTP Server) with ESMTP id 7656D1C44E1F
	for <linux-acpi@vger.kernel.org>; Wed, 15 Aug 2007 11:19:55 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2302.orange.fr (SMTP Server) with ESMTP id B57131C000BB
	for <linux-acpi@vger.kernel.org>; Wed, 15 Aug 2007 11:19:10 +0200 (CEST)
Received: from unshared.local (ASt-Lambert-151-1-38-162.w82-120.abo.wanadoo.fr [82.120.228.162])
	by mwinf2302.orange.fr (SMTP Server) with ESMTP id 8FBC91C000B5
	for <linux-acpi@vger.kernel.org>; Wed, 15 Aug 2007 11:19:10 +0200 (CEST)
In-Reply-To: <200708150044.29820.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Dear all! 

I submit you this issue with my laptop, a Packard Bell Easynote R1983 W 
(running an updated Kubuntu 7.04, with updated BIOS). Issue not documented 
elsewhere I've looked for. 
Problem: I need to put at boot the option "acpi=force" to kernel (2.6.20-16)  
in order to have atheros wifi card working. But then, this disables my usb 
devices! 

More technical details have been posted on: 
kubuntuforums.net/forums/index.php?topic=3083009.msg68885#msg68885

Some comments made on http://madwifi.org/ticket/1454
"This is an ACPI error. [...] However, the problem in this case looks like a 
badly written DSDT. [...] the problem is the fault of your system vendor."
(I first thought it was a madwifi issue)

Please help, or at least give some hint that allow me to go on (I'm newbie)! 
Thanks in advance. 

Raf

