From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 00/17] PNP Lindent
Date: Wed, 25 Jul 2007 10:57:49 -0600
Message-ID: <200707251057.49518.bjorn.helgaas@hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com> <20070723160007.d40b42a3.akpm@linux-foundation.org> <200707251224.44567.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:51926 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753182AbXGYQ6e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 12:58:34 -0400
In-Reply-To: <200707251224.44567.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, helgaas@ldl.fc.hp.com, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

On Wednesday 25 July 2007 10:24:44 am Len Brown wrote:
> > We could do it now if it's more convenient for you - there's not usually
> > much happening in that area.
> 
> I agree it would be make-work to carry Lindent patches in -mm.
> 
> I think it is also a PITA to push them to Linus before RC1
> because that is when a huge torrent of functional patches go in.
> 
> I think that between RC1 and RC2 (now) is as good a time as any
> to push a Lindent cleanup to Linus.  If you guys agree, I'll
> be happy to Lindent pnp and push it right now.  Heck, I try
> to keep acpi Lindent-clean, so I could do that at the same time.
> 
> Bjorn, did you have to do any manual fix-ups to Lindent, or
> did it actually get it right automatically?
> Over time, I've actually changed some of the syntax of the ACPI code
> so that it wouldn't confuse subsequent Lindent passes:-)
> In particular, it didn't like macros that included their own ';'s.

I did do some manual fixups afterward.  I can collect those into a
separate patch if you want.
