From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Tue, 13 Nov 2007 13:36:46 -0800
Message-ID: <20071113213646.GB4426__28194.8486379862$1194989887$gmane$org@kroah.com>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113170129.GA20185@kroah.com> <20071113183353.GE17785@parisc-linux.org> <20071113185122.GA22536@kroah.com> <20071113211509.GB19146@auslistsprd01.us.dell.com> <20071113213108.GB7541@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:55353 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760949AbXKMVhM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Nov 2007 16:37:12 -0500
Content-Disposition: inline
In-Reply-To: <20071113213108.GB7541@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Matt Domsch <Matt_Domsch@dell.com>, Matthew Wilcox <matthew@wil.cx>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, rick.jones2@hp.com, li

On Tue, Nov 13, 2007 at 02:31:08PM -0700, Alex Chiang wrote:
> * Matt Domsch <Matt_Domsch@dell.com>:
> > 
> > The only reported _SUN problems on Dell systems were on the
> > PE6800 and PE6850 systems, which we've fixed with an updated
> > BIOS several months ago.  IIRC the values weren't always unique
> > which kind of defeated the purpose.
> 
> FWIW, the ACPI 2.0 spec did not require uniqueness for _SUN.
> (although there is a strange table that refers to _SUN as the
> slot-unique ID (table 6-1 in spec v2.0b), the actual definition
> of _SUN does not mention uniqueness).

Does your code handle if these are not unique?

thanks,

greg k-h
