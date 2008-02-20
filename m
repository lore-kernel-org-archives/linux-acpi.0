From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Kernel Version specific vendor override possibilities needed -
	Revert and provide osi=linux or provide a replacement
Date: Wed, 20 Feb 2008 10:14:34 -0300
Message-ID: <20080220131434.GB29287@khazad-dum.debian.net>
References: <1203471860.3358.177.camel@linux-2bdv.site> <47BC0174.5050203@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55701 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751675AbYBTNOj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Feb 2008 08:14:39 -0500
Content-Disposition: inline
In-Reply-To: <47BC0174.5050203@dbservice.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
Cc: trenn@suse.de, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, Matthew Garrett <mjg59@srcf.ucam.org>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Wed, 20 Feb 2008, Tomas Carnecky wrote:
> A lot has been discussed in linux-acpi, though mostly hidden in related  
> threads. Ask Henrique, he's been trying to come up with a proper _OSI()  
> interface. See for example this thread:

No, I haven't.  Len is the mastermind behind it, AFAIK.  I am just one of
the interested parties.  I have been burned by halfway-done jobs in the
kernel once-too-many already IMO, so I am sticking around the threads to
make sure THIS time, at least I will also be at fault if it is done wrong.

The fact that Lenovo (and therefore, ThinkPads) is one of the vendors
directly affected by OSI(Linux) issues, has a LOT to do with my continued
participation on this issue, too.  The saner the ThinkPad firmware is, from
a Linux standpoint, the better for me.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
