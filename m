From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 4/4] ACPI: Battery: Add support for _BIX extended info
 method
Date: Mon, 15 Mar 2010 08:38:37 -0300
Message-ID: <20100315113837.GA8296@khazad-dum.debian.net>
References: <20091015103122.3853.34760.stgit@thinkpad>
 <20091015103144.3853.9717.stgit@thinkpad>
 <9b2b86520910160208l5bc6e20dkca79ae54505428ed@mail.gmail.com>
 <20091017154124.GA31182@khazad-dum.debian.net>
 <4B9D601A.3050708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51673 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753142Ab0COLiw (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 15 Mar 2010 07:38:52 -0400
Content-Disposition: inline
In-Reply-To: <4B9D601A.3050708@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Mon, 15 Mar 2010, Alexey Starikovskiy wrote:
> Henrique de Moraes Holschuh ??????????:
> > On Fri, 16 Oct 2009, Alan Jenkins wrote:
> >> So userspace is supposed to realise that "0" means "this attribute is
> >> not supported", as opposed to "I am a brand new battery and don't
> >> remember being factory-tested".
> >>
> >> How about returning -1 for batteries without _BIX?
> >
> > How about NOT registering attributes that don't exist?  That's the proper
> > way of doing things in sysfs.
> >   
> That is going to be too complex (2 duplicated arrays)

It would be the Right Thing to do.  Still, you could return a proper error
as I suggested.

> > When that's not possible, I'd suggest doing the right thing and returning an
> > error of some sort (ENXIO, ENOTSUP, etc)...
> >   
> None of power class members does it, and all ACPI classes are returning
> -1 in not-supporting case.

That just means the ACPI sysfs conversion on that area was not as good as it
should have been.  It is hardly the only place where the sysfs ABI is not
well implemented, but that doesn't mean the breakage should remain, or that
it should be made worse.

What is the technical case to returning invalid values for something that is
not supported when you could return a proper error on open() instead (since
you're not going to do the Right Thing and not register that attribute it in
the first place)?  Not only the "-1" way wastes more system resources (all
clients have to do open+read+close), it also needs userspace to special case
something, and that is always a Bad Idea for *many* reasons.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
