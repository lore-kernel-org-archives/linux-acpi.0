From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 0/5] ACPI: Add _OST support for ACPI hotplug
Date: Mon, 16 Apr 2012 12:24:16 -0600
Message-ID: <1334600656.20190.139.camel@misato.fc.hp.com>
References: <1334096510-17319-1-git-send-email-toshi.kani@hp.com>
	 <1334161991.2226.18.camel@lorien2>
	 <1334170247.20190.34.camel@misato.fc.hp.com>
	 <1334240353.2222.3.camel@lorien2> <4F88371D.7030305@gmail.com>
	 <1334330617.2250.4.camel@lorien2>
	 <1334333152.20190.85.camel@misato.fc.hp.com>
	 <1334342089.3422.5.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:39119 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab2DPSZd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Apr 2012 14:25:33 -0400
In-Reply-To: <1334342089.3422.5.camel@lorien2>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: shuahkhan@gmail.com
Cc: Jiang Liu <liuj97@gmail.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2012-04-13 at 12:34 -0600, Shuah Khan wrote:
> > I would like to explain more detail about my testing.  Unlike other ACPI
> > methods, the functionality of _OST method is not defined by the spec.
> > It is all up to the firmware implementation.  
> 
> A good reason why this patch requires more testing than on simulated
> firmware code that is based on one single firmware implementation.

Thanks Shuah for the guidance.  Do they summarize your point properly?

1. Testing a new feature on simulated / virtualized environment alone is
not sufficient.

2. Pre-enablement of a new feature is not allowed.

3. Contributing code that supports a new feature shall wait until there
are multiple firmware implementations available for the testing.

I like clear guidance, but this may be challenging for emerging
features.
-Toshi 


