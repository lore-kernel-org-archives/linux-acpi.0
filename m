From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Wed, 25 Nov 2009 13:56:45 -0600
Message-ID: <1259179005.2471.4.camel@laptop>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
	 <alpine.LFD.2.00.0911242347030.4058@localhost.localdomain>
	 <1259170225.4391.4.camel@laptop>
	 <alpine.LFD.2.00.0911251317480.3950@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:35524 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759612AbZKYT4u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 14:56:50 -0500
In-Reply-To: <alpine.LFD.2.00.0911251317480.3950@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Lutomirski <luto@mit.edu>, linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, 2009-11-25 at 13:24 -0500, Len Brown wrote:
> On Wed, 25 Nov 2009, Jerone Young wrote:
> 
> > I had a set of patches for the different thinkpad lines could test.
> > Couldn't verify though with Thinkpads like the T400s needed this.
> > 
> > Here are direct links from the archive:
> > 
> > https://lists.ubuntu.com/archives/kernel-team/2009-August/007065.html
> > https://lists.ubuntu.com/archives/kernel-team/2009-August/007068.html
> > https://lists.ubuntu.com/archives/kernel-team/2009-August/007064.html
> > https://lists.ubuntu.com/archives/kernel-team/2009-August/007066.html
> > https://lists.ubuntu.com/archives/kernel-team/2009-August/007067.html
> 
> 
> Have these been verified as necessary to make sound work on
> the specified models, or are these speculative patches?

Yes they have all been verified for the mute key to work. Actually I
missed the 0 patch that expalins everythig here:

https://lists.ubuntu.com/archives/kernel-team/2009-August/007080.html

Can find some of the verification in this LP bug:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/281732


> 
> I'd rather apply only patches that are verified as necessary upstream.
> 
> Also, I don't know how to apply html without editing -- so if
> you can extract the patches from your tree and e-mail them
> as plain text, that would be less tedious.

hmm .. don't have a tree anymore. Though they where in the ubuntu kernel
tree at one point. Best to just copy and past the diffs from the links.

> 
> thanks,
> -Len Brown, Intel Open Source Technology Center


