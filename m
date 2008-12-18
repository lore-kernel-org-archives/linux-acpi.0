From: Andi Kleen <andi@firstfloor.org>
Subject: Re: state of some x86 acpi patches
Date: Thu, 18 Dec 2008 14:44:49 +0100
Message-ID: <874p111tta.fsf@basil.nowhere.org>
References: <4947FF4C.80706@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:46036 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYLRNoO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Dec 2008 08:44:14 -0500
In-Reply-To: <4947FF4C.80706@goop.org> (Jeremy Fitzhardinge's message of "Tue, 16 Dec 2008 11:19:40 -0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Brown, Len" <len.brown@intel.com>, Yinghai Lu <yinghai@kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

Jeremy Fitzhardinge <jeremy@goop.org> writes:
>
> However, unlike early_ioremap(), __acpi_map_table just maintains a
> single mapping which gets replaced each call, and has no corresponding
> unmap function.  Implement this by just removing the previous mapping
> each time its called.  Unfortunately, this will leave a stray mapping
> at the end.

Stray mappings are dangerous. They can lead to illegal cache aliases
later. Better avoid them.

I guess ACPI could call a cleanup function after it's done with
all early mappings.

-Andi


-- 
ak@linux.intel.com
