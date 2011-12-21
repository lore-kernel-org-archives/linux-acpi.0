From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: ACPI _PPC issue with bios_limit
Date: Wed, 21 Dec 2011 12:41:22 +0200
Message-ID: <4EF1B7D2.7000206@iki.fi>
References: <4EEB4F1E.3070908@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tulikuusama.dnainternet.net ([83.102.40.132]:49961 "EHLO
	tulikuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752429Ab1LUKl0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Dec 2011 05:41:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by tulikuusama.dnainternet.net (Postfix) with ESMTP id 783DF3FABF
	for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2011 12:41:24 +0200 (EET)
Received: from tulikuusama.dnainternet.net ([83.102.40.132])
	by localhost (tulikuusama.dnainternet.net [127.0.0.1]) (DNA Postiturva, port 10041)
	with ESMTP id bvqXm9ktWDzC for <linux-acpi@vger.kernel.org>;
	Wed, 21 Dec 2011 12:41:24 +0200 (EET)
Received: from kirsikkapuu.dnainternet.net (kirsikkapuu.dnainternet.net [83.102.40.214])
	by tulikuusama.dnainternet.net (Postfix) with ESMTP id 2B61B3F8B6
	for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2011 12:41:24 +0200 (EET)
Received: from mail.onse.fi (host-109-204-132-101.tp-fne.tampereenpuhelin.net [109.204.132.101])
	by kirsikkapuu.dnainternet.net (Postfix) with ESMTP id 1FAAA2BADF
	for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2011 12:41:23 +0200 (EET)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id CB52840CB3
	for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2011 12:41:22 +0200 (EET)
In-Reply-To: <4EEB4F1E.3070908@iki.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On 16.12.2011 16:01, Anssi Hannula wrote:
> Hi!
> 
> On my laptop, processor _PPC is evaluated as 1 and therefore the
> processor never goes to the highest frequency (1333MHz vs 1666 MHz).
> 
> The system is HP Mini 5102 and processor Atom N450.
> 
> ACPI tables are at http://zarb.org/~anssi/hpmini5102/
> 
> This only started happening since 2.6.34 when 3b1da4c5d1 ("ACPI:
> processor: remove early _PDC optin quirks") was applied and thus the
> _PDC is now evaluated early.
> 
> This causes extra tables to be loaded dynamically on boot:
[...]
> Of these, the first two (SSDT4, SSDT5) seem more interesting, and SSDT4
> contains "Name (_PPC, 0x00)".
> 
> However, I don't know how to debug this further, so I'm asking for
> assistance.
> 
> Boot dmesg with current linus git tree is attached.
> This issue doesn't happen on win7 included with the laptop.

Looking at DSDT, it looks like EC0 method RPPC is the one setting _PPC to 1.

RPPC seems to do
  _PPC++ when OTSI flag is set and OTLL is 0x00
  _PPC-- when OTSI flag is set and OTLL is 0x02
and then it clears the OTSI flag.

OTLL is initialized to 0x00 and OTSI is initialized to 0x01.

RPPC seems to be called from EC0's _REG->ECRI->PRIT and from _Q04 (and
from _WAK->HWAK, though my guess is that that is not relevant).

Since on EC0 registration time OTLL=0 and OTSI=1, this causes RPPC to
bump _PPC to 1.

_Q04, if triggered, would set OTSI=1 and OTLL to the value from OCPS
(from EC's memory region).

So it seems to me like either RPPC is somehow not supposed to set _PPC
when EC0 region is registered, or the EC is supposed to send a '04'
event with OCPS=2 which would cause RPPC to reset _PPC to 0.

If it is the latter, I guess the EC is waiting for some action from the
kernel which never happens. During normal system operation OCPS seems to
have 0x01 (which means no _PPC change), so the issue is not simply a
missing _Q04 call.

Again, any hints or debugging suggestions welcome :)

-- 
Anssi Hannula
