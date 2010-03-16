From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 4/4] ACPI: Battery: Add support for _BIX extended info
 method
Date: Mon, 15 Mar 2010 21:12:53 -0300
Message-ID: <20100316001253.GB8296@khazad-dum.debian.net>
References: <20091015103122.3853.34760.stgit@thinkpad>
 <20091015103144.3853.9717.stgit@thinkpad>
 <9b2b86520910160208l5bc6e20dkca79ae54505428ed@mail.gmail.com>
 <20091017154124.GA31182@khazad-dum.debian.net>
 <4B9D601A.3050708@gmail.com>
 <20100315113837.GA8296@khazad-dum.debian.net>
 <4B9E95EB.8000604@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49361 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932779Ab0CPAM5 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 15 Mar 2010 20:12:57 -0400
Content-Disposition: inline
In-Reply-To: <4B9E95EB.8000604@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, Len Brown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Mon, 15 Mar 2010, Alexey Starikovskiy wrote:
> Henrique de Moraes Holschuh ??????????:
> > That just means the ACPI sysfs conversion on that area was not as good as it
> > should have been.  It is hardly the only place where the sysfs ABI is not
> > well implemented, but that doesn't mean the breakage should remain, or that
> > it should be made worse.
> > What is the technical case to returning invalid values for something that is
> > not supported when you could return a proper error on open() instead (since

> Power Class interface does not give me control over open() as far as I know.

Hmm, you're correct.  We can return errors, but they'll be on
read()/write(), not open().

> > you're not going to do the Right Thing and not register that attribute it in
> > the first place)?  Not only the "-1" way wastes more system resources (all
> > clients have to do open+read+close), it also needs userspace to special case
> > something, and that is always a Bad Idea for *many* reasons.
> If you know how this could be done, please show the patch...

Let me look at that code, and I will get back to you.  Might have to use the
recently introduced sysfs helpers or some somewhat ugly crap I had to add to
thinkpad-acpi to do just that, though.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
