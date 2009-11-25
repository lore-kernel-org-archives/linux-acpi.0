From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Wed, 25 Nov 2009 11:30:25 -0600
Message-ID: <1259170225.4391.4.camel@laptop>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
	 <alpine.LFD.2.00.0911242347030.4058@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:38896 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbZKYRa1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 12:30:27 -0500
In-Reply-To: <alpine.LFD.2.00.0911242347030.4058@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Lutomirski <luto@mit.edu>, linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

I had a set of patches for the different thinkpad lines could test.
Couldn't verify though with Thinkpads like the T400s needed this.

Here are direct links from the archive:

https://lists.ubuntu.com/archives/kernel-team/2009-August/007065.html
https://lists.ubuntu.com/archives/kernel-team/2009-August/007068.html
https://lists.ubuntu.com/archives/kernel-team/2009-August/007064.html
https://lists.ubuntu.com/archives/kernel-team/2009-August/007066.html
https://lists.ubuntu.com/archives/kernel-team/2009-August/007067.html


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


