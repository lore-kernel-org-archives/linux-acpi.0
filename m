From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 27/30] ACPI: EC: Add a quirk for CLEVO M720T/M730T laptop
Date: Mon, 8 Oct 2012 23:59:07 -0700
Message-ID: <20121009065907.GB3648@elie.Belkin>
References: <e3f25e6e5836c4790fbe395ff42e241f372d859d.1349761836.git.len.brown@intel.com>
 <67bfa9b60bd689601554526d144b21d529f78a09.1349761836.git.len.brown@intel.com>
 <20121009061633.GA3648@elie.Belkin>
 <20121009142206.63dd9981@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55226 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab2JIG7M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2012 02:59:12 -0400
Content-Disposition: inline
In-Reply-To: <20121009142206.63dd9981@feng-i7>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>

Feng Tang wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:

>> What would go wrong if the threshold were just increased to 20 on all
>> models?
>
> Then some other platform will stop to work.
>	https://bugzilla.kernel.org/show_bug.cgi?id=11892 
>
> The 26/30 and 27/30 patches are bound together to fix one bug. Some
> quote from description from the 26th patch:
>
> ACPI_EC_STORM_THRESHOLD was initially 20 when it's created, and
> was changed to 8 in 2.6.28 commit 06cf7d3c7 "ACPI: EC: lower interrupt storm
> threshold" to fix kernel bug 11892 by forcing the laptop in that bug to
> work in polling mode.
>
> Hope this answers your question.

Thanks much.  Yes, that clarifies.

The magic numbers are not too thrilling.  If the polling mode just
doesn't work on the Clevo M720, why isn't the appropriate storm
threshold 999999 or infinity rather than 20?  Do we know why the
polling mode doesn't work?

Jonathan
