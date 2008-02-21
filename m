From: Len Brown <lenb@kernel.org>
Subject: Re: Kernel Version specific vendor override possibilities needed - Revert and provide osi=linux or provide a replacement
Date: Thu, 21 Feb 2008 03:41:13 -0500
Message-ID: <200802210341.13809.lenb@kernel.org>
References: <1203471860.3358.177.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37550 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566AbYBUIp2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 03:45:28 -0500
In-Reply-To: <1203471860.3358.177.camel@linux-2bdv.site>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@mit.edu>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

Thomas,
Thanks for the note.
Please read the messages on linux-acpi with "dmi" in the subject
for some background.

yes, OSI(Linux) was enabled by default through 2.6.22
and was disabled by default starting in 2.6.23.

The reason it has come up recently is because
it got into a reference BIOS -- and I'm sorry
to admit that I was a party to that -- I
wasn't thinking.

Tomas Carnecky's reply is 100% correct.
We can't support OSI(Linux) any more than we
could support _OS="Linux", or Microsoft
could support OSI(Windows) -- particularly
on an OS that changes as fast as Linux does.
To do so would in some cases put Linux at
a permanent disadvantage to competing operating systems.

Yes, we are attempting to close Pandora's box.
I think we'll be successful, though we have to handle the
Dell and Lenovo systems which actually use OSI(Linux)
on purpose. Everybody else appears to be using it
by mistake, sometimes with no effect,
sometimes with negative effect.

No, the DMI list is not large,
it is mostly comments and it is __init.

I _strongly_ urge you to not fork from
the .stable and mainline kernel in this area.

OEMs that really want to modify the BIOS to recognize
OS interfaces that are in Linux should propose
new OSI strings that specify interfaces, not broad
categories of operating sytems; and in Linux we
shoudl use, or not use, those strings, as appropriate.
I've recently been in discussion with OEMs on exactly
this topic -- I'm sorry it didn't happen a year ago.

thanks,
-Len
