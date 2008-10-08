From: Thomas Renninger <trenn@suse.de>
Subject: Re: Problem: ACPI related soft lockup on Fujitsu-Siemens AMILO Si 2636
Date: Wed, 8 Oct 2008 13:08:51 +0200
Message-ID: <200810081308.52221.trenn@suse.de>
References: <48E9F51A.4080107@gmail.com> <48EC7430.1010001@gmail.com> <48EC9004.6010105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:54260 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052AbYJHLIx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Oct 2008 07:08:53 -0400
In-Reply-To: <48EC9004.6010105@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Lindroth <thomas.lindroth@gmail.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux-acpi@vger.kernel.org

On Wednesday 08 October 2008 12:48:36 Thomas Lindroth wrote:
> Alexey Starikovskiy wrote:
> > Alexey Starikovskiy wrote:
> >> This is AML implementation of EC driver... it relies on certain speed
> >> of AML interpreter to work properly (look for Noop inserted as delay).
> >>
> >> It is possible to replace this driver with the native Linux one, which
> >> might be
> >> more robust, but this involves heavy DSDT hacking.
> >>
> >> Overall, it is heavily mis-designed BIOS, so don't expect it to be
> >> fixed on Linux side.
> >>
> >> Regards,
> >> Alex.
> >
> > Please check if making Noop a small delay helps
>
> I've tried the patch with an udelay of 100 but it did not make any
> difference. I've also tried raising it to 200 but that created an
> unbootable system because one of the ACPI init methods failed.
>
> You are right, this is a really broken BIOS.
>
> I find it odd that only I experience this problem. According to one
> site this laptop is the 7:th most popular laptop right now so someone
> else should have reported something.

Could you provide a short explanation what should be fixed in which way in the 
BIOS tables. Best in a way that I can just forward this.
It's hard in the laptop area to convince fsc to fix it, but I at least like to 
try and to tell them.
Hmm, I think the last two mails should already be enough, I think  I got it.

Is there a general hint I could add into the ACPI Linux guideline, like:
Don't implement EC data/index register reads/writes in AML yourself.
Define a EC variable and e.g. use Store(ECXY, Local0) to read and
Store(Local0, ECXY) to write to specific EC bytes.

Did I get this right?

Thanks,

     Thomas
