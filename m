From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] ACPI suspend: Blacklist HP xw4600 Workstation for old
 code ordering
Date: Thu, 16 Oct 2008 22:07:11 -0600
Message-ID: <48F80F6F.6090608@shaw.ca>
References: <fa./6DR3VeG3JltQZvwctIdnZpBOO8@ifi.uio.no> <fa.TMVI/3KJQDTBIWAfYmLw01GczF4@ifi.uio.no> <fa./GCX/x0zwCB6BIEvtQehNpVDSVk@ifi.uio.no> <fa.MkpTJy5Iw9ZR3PXWpugQeK5oN1o@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:11069 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbYJQEHT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Oct 2008 00:07:19 -0400
In-Reply-To: <fa.MkpTJy5Iw9ZR3PXWpugQeK5oN1o@ifi.uio.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, "Brown, John M (WGBU R&D)" <john.brown3@hp.com>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

Rafael J. Wysocki wrote:
> On Wednesday, 15 of October 2008, Len Brown wrote:
>> Matthew,
>> You are right, of course, we're not doing something right
>> if a new machine needs this workaround.
> 
> Isn't that possible, however, that the BIOS of this new machine is based on an
> older one that used to have this problem?

Maybe, but it doesn't matter. If it's a new machine it's presumably 
going to work fine on Vista, etc. so it doesn't make much sense that 
this machine should require the old ACPI code ordering.
