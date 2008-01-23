From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Fan resume not working on nx6325 without userland assistance
Date: Wed, 23 Jan 2008 16:02:10 +0100
Message-ID: <200801231602.10298.rjw@sisk.pl>
References: <200801220241.43230.rjw@sisk.pl> <47962AA8.9010600@suse.de> <200801222156.50768.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35828 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbYAWPEh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jan 2008 10:04:37 -0500
In-Reply-To: <200801222156.50768.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tuesday, 22 of January 2008, Rafael J. Wysocki wrote:
> On Tuesday, 22 of January 2008, Alexey Starikovskiy wrote:
> > Does revert of 93ad7c07ad487b036add8760dabcc35666a550ef helps?
> 
> Yes, it does, thanks.

Well, reverting commit 93ad7c07ad487b036add8760dabcc35666a550ef is the only
thing that makes it work in all situations, AFAICS.

Len, can you push the revert to Linus for 2.6.24, please?

Thanks,
Rafael
