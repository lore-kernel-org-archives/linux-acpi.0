From: Len Brown <lenb@kernel.org>
Subject: Re: new Linux/ACPI home page
Date: Thu, 25 Oct 2007 16:29:18 -0400
Message-ID: <200710251629.19006.lenb@kernel.org>
References: <200710251507.56335.lenb@kernel.org> <4720ED77.6090109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55001 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753923AbXJYU3j (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Thu, 25 Oct 2007 16:29:39 -0400
In-Reply-To: <4720ED77.6090109@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Linux-acpi@vger.kernel.org

On Thursday 25 October 2007 15:24, Alexey Starikovskiy wrote:
> Len Brown wrote:

> > and going away), and the DSDT databse -- which I believe
> > is also somewhat of a historical artifact.

> DSDT database or better acpidump.out database might be very useful,
> if could be searched for particular feature -- absence of EC, use of SBS, etc.

True.

I don't like the original DSDT database -- it was from an era
when people thought that it was a good idea to hack a DSDT
to workaround Linux failures and share the hacked DSDT
with others.  That was a bad strategy and it should be abandoned.
DSDT hacking is for Linux debugging only -- Linux should
always be made to work with an un-modified DSDT.

yes, acpidump would be more useful than just the DSDT --
as we get all kinds of issues with all the tables.

One problem is that shipping around BIOS images, particularly
modified ones, is sort of a touchy area.  This is the code
of the manufacturer, who may or may not be happy that the
community is hacking their code.  If any of those manufactureres
got mad at Intel for mucking with their BIOS code,
that would be a bad day for we Intel employees.

lesswatts.org is hosted by Intel.  So we'd need to
sort though this issue before adding an acpidump database.

thanks,
-Len
