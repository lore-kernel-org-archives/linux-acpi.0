From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Sun, 29 Nov 2009 23:47:41 -0600
Message-ID: <1259560061.3508.9.camel@laptop>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
	 <alpine.LFD.2.00.0911242347030.4058@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:56845 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbZK3Frl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2009 00:47:41 -0500
In-Reply-To: <alpine.LFD.2.00.0911242347030.4058@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Lutomirski <luto@mit.edu>, linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

I found in the patches are in the Ubuntu karmic kernel git tree, that
should make things easier. Here are links from git web to them. You can
pull them from the tree also.

http://kernel.ubuntu.com/git?p=ubuntu/ubuntu-karmic.git;a=blob;f=drivers/acpi/blacklist.c;hb=992429cc3eb4277e07811a690cf04905bdc8b756
http://kernel.ubuntu.com/git?p=ubuntu/ubuntu-karmic.git;a=blob;f=drivers/acpi/blacklist.c;hb=4c0863e159b64424e9d02f846b23705b88785468
http://kernel.ubuntu.com/git?p=ubuntu/ubuntu-karmic.git;a=blob;f=drivers/acpi/blacklist.c;hb=b7d5194f5e19b7d91808ea8f3dc31819d22f220a
http://kernel.ubuntu.com/git?p=ubuntu/ubuntu-karmic.git;a=blob;f=drivers/acpi/blacklist.c;hb=f989a47a3f344d0a26ab96038a5221f021a2735e
http://kernel.ubuntu.com/git?p=ubuntu/ubuntu-karmic.git;a=blob;f=drivers/acpi/blacklist.c;hb=8843ac2d4fdc6f616157c1e86e4826dedfca7f60


They were reverted in the final tree since they had not made it
upstream.

				Jerone


On Tue, 2009-11-24 at 23:50 -0500, Len Brown wrote:
> On Mon, 9 Nov 2009, Andrew Lutomirski wrote:
> 
> > The ThinkPad X200s, like the X61, requires OSI=Linux for the mute
> > button to work.  Without this patch (or the equivalent command-line
> > parameter), the mute button does not generate a keystroke and,
> > instead, messes up the sound hardware.
> > 
> > Tested on an X200s.
> > 
> > Signed-off-by: Andy Lutomirski <luto@mit.edu>
> 
> I just applied the analogous T400/T500 patch from
> http://bugzilla.kernel.org/show_bug.cgi?id=13934
> 
> and I'd apply this one too if it were not malformed.
> 
> 
> Jerome,
> Perhaps you can post the patches from the canonical list
> so we can take care of these "all at once"?
> 
> Somebody tell Lenovo (again) that they are being bad.
> 
> thanks,
> -Len Brown, Intel Open Source Technology Center
> 
> 


