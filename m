From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI suspend: Blacklist HP xw4600 Workstation for old code ordering
Date: Thu, 16 Oct 2008 00:00:59 +0200
Message-ID: <200810160001.00053.rjw@sisk.pl>
References: <200810142254.07024.rjw@sisk.pl> <C075D3D77BA5EF4FBB0939047B182ABF25C79AD3EE@GVW1144EXB.americas.hpqcorp.net> <alpine.LFD.1.10.0810151746460.3026@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54555 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314AbYJOV4v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Oct 2008 17:56:51 -0400
In-Reply-To: <alpine.LFD.1.10.0810151746460.3026@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Brown, John M (WGBU R&D)" <john.brown3@hp.com>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Wednesday, 15 of October 2008, Len Brown wrote:
> Matthew,
> You are right, of course, we're not doing something right
> if a new machine needs this workaround.

Isn't that possible, however, that the BIOS of this new machine is based on an
older one that used to have this problem?

> However, we don't yet know what we're not doing right:-)

Well, John, can you please post the output of acpidump from this machine?

Thanks,
Rafael
