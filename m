From: Andi Kleen <ak@linux.intel.com>
Subject: Re: acpi based pci gap calculation  - v3
Date: Wed, 16 Jul 2008 18:33:46 +0200
Message-ID: <487E22EA.8030005@linux.intel.com>
References: <1216148382.6135.21.camel@alok-dev1> <200807151553.41403.jbarnes@virtuousgeek.org> <487D89E3.9070604@linux.intel.com> <200807160906.43632.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200807160906.43632.jbarnes@virtuousgeek.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: akataria@vmware.com, Ingo Molnar <mingo@elte.hu>, "Brown, Len" <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, TJ <linux@tjworld.net>
List-Id: linux-acpi@vger.kernel.org


> The only problem there is that linux-next doesn't get nearly the sort of 
> testing coverage we need for this kind of change.

Normally I tend to wait for one -mm release, which seems to be tested
by a reasonable number of people. If it survives that it is good
to be tested in Linus' tree.

Just stuffing this in in literally the last minute doesn't seem
like a good idea.

-Andi
