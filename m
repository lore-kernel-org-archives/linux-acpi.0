From: Khalid Aziz <khalid.aziz@hp.com>
Subject: Re: [PATCH] ACPI: Add ACPI CPU hot-remove support
Date: Tue, 10 Jul 2012 16:56:18 -0600
Message-ID: <1341960978.1065.12.camel@lyra>
References: <1340981479-6521-1-git-send-email-toshi.kani@hp.com>
	 <4FF711DE.1030108@gmail.com> <1341602020.16730.695.camel@misato.fc.hp.com>
	 <4FF745F1.9030103@hp.com>  <1341608402.16730.730.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0185.atlanta.hp.com ([15.193.32.62]:13396 "EHLO
	g6t0185.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab2GJW4U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jul 2012 18:56:20 -0400
In-Reply-To: <1341608402.16730.730.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: Jiang Liu <liuj97@gmail.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2012-07-06 at 15:00 -0600, Toshi Kani wrote:
> Yes, offlining and eject are similar operations to a core as it alone
> cannot be removed physically.  Ejecting a core is a logical eject
> operation, which updates the status (_STA) of the object in ACPI after
> offlining.  The difference from the offlining is that the ejected core
> is no longer assigned to the partition.  Here is one example.  Say, a
> core is assigned to a guest partition as a dedicated resource (ex. 100%
> of its CPU time is bound to the partition).  Offlining this core saves
> the power-consumption, but this core is still bound to the partition.
> Ejecting the core removes it from the partition (logically), and allows
> it to be assigned to other partition as a dedicated resource with
> hot-add.
> 

Ejecting a core is reasonable when eject happens from a guest. I still
wonder what firmware would do if kernel calls eject method on a core
when running on the native host platform. If firmware behavior is not
well defined in this case, there might be some risk associated with
calling eject method on core. 

Makes sense?

-- 
Khalid Aziz <khalid.aziz@hp.com>

