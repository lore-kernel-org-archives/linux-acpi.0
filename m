From: Andi Kleen <ak@linux.intel.com>
Subject: Re: acpi based pci gap calculation  - v3
Date: Wed, 16 Jul 2008 07:42:08 +0200
Message-ID: <487D8A30.2070702@linux.intel.com>
References: <1216148382.6135.21.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:61643 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751465AbYGPFmI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jul 2008 01:42:08 -0400
In-Reply-To: <1216148382.6135.21.camel@alok-dev1>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akataria@vmware.com
Cc: Ingo Molnar <mingo@elte.hu>, "Brown, Len" <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Alok Kataria wrote:
> Hi Andi,
> 
> I don't see this patch being applied in any of the tree yet.
> Resending this incase you guys might have missed it. 

Sorry still some backlog from vacation last week. However the focus
right now is on patches for 2.6.27 and I don't think your patch
is really tested well enough yet for that. It is fairly intrusive
and changes a critical piece of code. More likely it's a .28 thing,
or possibly a late merge candidate (but that's also not clear)

-Andi
