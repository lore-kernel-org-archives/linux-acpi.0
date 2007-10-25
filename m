From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: new Linux/ACPI home page
Date: Thu, 25 Oct 2007 23:23:44 +0200
Message-ID: <200710252323.45234.rjw@sisk.pl>
References: <200710251507.56335.lenb@kernel.org> <4720ED77.6090109@gmail.com> <200710251629.19006.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48879 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbXJYVH0 (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Thu, 25 Oct 2007 17:07:26 -0400
In-Reply-To: <200710251629.19006.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

On Thursday, 25 October 2007 22:29, Len Brown wrote:
> On Thursday 25 October 2007 15:24, Alexey Starikovskiy wrote:
> > Len Brown wrote:
> 
> > > and going away), and the DSDT databse -- which I believe
> > > is also somewhat of a historical artifact.
> 
> > DSDT database or better acpidump.out database might be very useful,
> > if could be searched for particular feature -- absence of EC, use of SBS, etc.
> 
> True.
> 
> I don't like the original DSDT database -- it was from an era
> when people thought that it was a good idea to hack a DSDT
> to workaround Linux failures and share the hacked DSDT
> with others.  That was a bad strategy and it should be abandoned.
> DSDT hacking is for Linux debugging only -- Linux should
> always be made to work with an un-modified DSDT.

I violently agree.

> yes, acpidump would be more useful than just the DSDT --
> as we get all kinds of issues with all the tables.
> 
> One problem is that shipping around BIOS images, particularly
> modified ones, is sort of a touchy area.  This is the code
> of the manufacturer, who may or may not be happy that the
> community is hacking their code.  If any of those manufactureres
> got mad at Intel for mucking with their BIOS code,
> that would be a bad day for we Intel employees.
> 
> lesswatts.org is hosted by Intel.  So we'd need to
> sort though this issue before adding an acpidump database.

Well, we have suspend.sf.net and the acpidump database can safely be put in
there, I think. ;-)

Greetings,
Rafael
