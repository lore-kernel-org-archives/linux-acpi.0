From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Sony Vaio VGN-SZ340 (was Re: sonypc with Sony Vaio VGN-SZ1VP)
Date: Fri, 5 Jan 2007 21:09:35 -0700
Message-ID: <200701052109.35707.bjorn.helgaas@hp.com>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <7ce7bf330701050924h47546970w36ed189ed147ddb3@mail.gmail.com> <200701051310.41131.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:46055 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbXAFEJn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Jan 2007 23:09:43 -0500
In-Reply-To: <200701051310.41131.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: MoRpHeUz <morpheuz@gmail.com>, Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

On Friday 05 January 2007 11:10, Len Brown wrote:
> On Friday 05 January 2007 12:24, MoRpHeUz wrote:
> > > What workaround are you using?
> > 
> >  This one: http://bugzilla.kernel.org/show_bug.cgi?id=7465
> 
> Ah yes, the duplicate MADT issue is clearly a BIOS bug.
> It is possible that we can tweak our Linux workaround for it to be more
> Microsoft Windows Bug Compatbile(TM).

Maybe Windows discovers processors using the namespace rather
than the MADT.
