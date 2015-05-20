From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell Inspiron
 7437
Date: Wed, 20 May 2015 19:42:42 +0100
Message-ID: <20150520184242.GA32453@srcf.ucam.org>
References: <20150427174646.GA22664@srcf.ucam.org>
 <CAJ=jquZ7wTNBMEwZaxKRd6B2iC6qaum5h+oW=Qf364+xhs20kg@mail.gmail.com>
 <20150428052448.GA3458@srcf.ucam.org>
 <CAJ=jquYYDixG7-XtVJRvuHDWHgF3Ww3fiafDbmgD5KY8QJjeQQ@mail.gmail.com>
 <20150428171100.GA24599@srcf.ucam.org>
 <CAJ=jquZMMBNsKO2CZe649OcXTBxfzO43gkxwkJn2mvHhnp+zSQ@mail.gmail.com>
 <5554F12A.3010003@dell.com>
 <20150514191358.GB23853@srcf.ucam.org>
 <5554F4B2.8080801@dell.com>
 <555CC776.3030802@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40477 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778AbbETSmq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2015 14:42:46 -0400
Content-Disposition: inline
In-Reply-To: <555CC776.3030802@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Alex Hung <alex.hung@canonical.com>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Wed, May 20, 2015 at 12:42:14PM -0500, Mario Limonciello wrote:

> I've gotten some more information on this.
> Windows: Asks for battery information update multiple times.
> Linux: Only asks once for battery information update.
> 
> The net result is that on Linux ACPI battery is missing.  In the
> _REV test BIOS workaround, a SMI event was added to ask for battery
> information update.

Hm. Why does only asking once not result in us seeing the battery?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
