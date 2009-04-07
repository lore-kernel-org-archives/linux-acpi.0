From: Len Brown <lenb@kernel.org>
Subject: Re: sony-laptop: ACPI Exception when a Fn-Key is pressed
Date: Tue, 07 Apr 2009 01:00:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904070055140.5698@localhost.localdomain>
References: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com>
 <20090406110154.GA25085@kamineko.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55807 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbZDGFBt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 01:01:49 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHP0068VSMXWMT2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 00:01:45 -0500 (CDT)
In-reply-to: <20090406110154.GA25085@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Rodrigo Luiz <rodrigo@gus-mg.org>, linux-acpi@vger.kernel.org, bob.moore@intel.com



> Does booting with acpi_osi=Linux makes things any worse?

acpi_osi=Linux will make Linux answer YES if/when a BIOS asks OSI(Linux).

However, it does not change if/when the BIOS asks if we are XP,
nor would it change our (YES) answer if asked.

Unlike all previous uses of OSI where what matters is what Linux ANSWERs,
this port blocking feature depends on what the BIOS ASKS.

Len Brown, Intel Open Source Technology Center



