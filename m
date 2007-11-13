From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Tue, 13 Nov 2007 14:31:08 -0700
Message-ID: <20071113213108.GB7541@ldl.fc.hp.com>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113170129.GA20185@kroah.com> <20071113183353.GE17785@parisc-linux.org> <20071113185122.GA22536@kroah.com> <20071113211509.GB19146@auslistsprd01.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palrel11.hp.com ([156.153.255.246]:56342 "EHLO palrel11.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757900AbXKMVbO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Nov 2007 16:31:14 -0500
Content-Disposition: inline
In-Reply-To: <20071113211509.GB19146@auslistsprd01.us.dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

* Matt Domsch <Matt_Domsch@dell.com>:
> 
> The only reported _SUN problems on Dell systems were on the
> PE6800 and PE6850 systems, which we've fixed with an updated
> BIOS several months ago.  IIRC the values weren't always unique
> which kind of defeated the purpose.

FWIW, the ACPI 2.0 spec did not require uniqueness for _SUN.
(although there is a strange table that refers to _SUN as the
slot-unique ID (table 6-1 in spec v2.0b), the actual definition
of _SUN does not mention uniqueness).

Uniqueness was first required in the 3.0 spec.

/ac

