From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Asus P1-AH2 won't suspend (regression)
Date: Sat, 5 Jan 2008 18:59:47 +0000
Message-ID: <20080105185946.GA24267@srcf.ucam.org>
References: <20080104144238.GA5176@zoy.org> <200801051107.14677.carlos@strangeworlds.co.uk> <20080105145539.GE16376@zoy.org> <200801051926.33641.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:56656 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127AbYAETAO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 14:00:14 -0500
Content-Disposition: inline
In-Reply-To: <200801051926.33641.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Michel Lespinasse <walken@zoy.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org

On Sat, Jan 05, 2008 at 07:26:33PM +0100, Rafael J. Wysocki wrote:
> On Saturday, 5 of January 2008, Michel Lespinasse wrote:
> > The patch did not work as you sent it, but doing the same in acpi_pm_open()
> > (i.e. forcing it to execute the revision<3 code) worked.
> > I'm now doing a happy dance :)
> > 
> > So what now, do you need some kind of signature for the system ?
> > (I realize that would probably be some kind of DMI string,
> > but I'm not sure where/how to obtain it)
> 
> Well, I think I'd rather want to introduce a boot parameter for that.  Stay
> tuned.

Surely this implies that the only behaviour tested (and, so, presumably 
the only behaviour implemented in Windows) is the 1.0-style flow? If so, 
we should just default to that regardless of what the spec says.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
