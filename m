From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell Inspiron
 7437
Date: Mon, 27 Apr 2015 18:46:46 +0100
Message-ID: <20150427174646.GA22664@srcf.ucam.org>
References: <1429759476-13186-1-git-send-email-alex.hung@canonical.com>
 <20150424082115.GA3783@srcf.ucam.org>
 <CAJ=jquYe97ObpE=3eTij705QsopnH4+hChssdj0qu7YFHGsSXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60237 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbbD0Rqu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Apr 2015 13:46:50 -0400
Content-Disposition: inline
In-Reply-To: <CAJ=jquYe97ObpE=3eTij705QsopnH4+hChssdj0qu7YFHGsSXg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Mon, Apr 27, 2015 at 04:30:11PM +0800, Alex Hung wrote:
> I don't have any Win8 media to test it but I will try to look for one.
> 
> I recalled that kernel 4.1rc has a patch "ACPICA: Permanently set _REV
> to the value '2'" that may also change firmware's behaviours, but it
> does not fix Inspiron 7437's ACPI event just for references.

The _REV behaviour didn't change between Windows 7 and 8, so it 
shouldn't be relevant here.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
