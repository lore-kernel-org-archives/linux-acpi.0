From: Bela Lubkin <blubkin@vmware.com>
Subject: RE: [Openipmi-developer] [PATCH 2/4] ipmi: Remove SPMI table based
	device discovery method
Date: Wed, 3 Mar 2010 23:56:10 -0800
Message-ID: <E0AA796A7E3F4C4E8F1065D15FE478610176ABB89F@EXCH-MBX-4.vmware.com>
References: <20100304033146.30205.68689.stgit@bob.kio>
 <20100304034415.30205.59685.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:41366 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753651Ab0CDH4M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Mar 2010 02:56:12 -0500
In-Reply-To: <20100304034415.30205.59685.stgit@bob.kio>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Myron Stowe' <myron.stowe@hp.com>, "minyard@acm.org" <minyard@acm.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>

Myron Stowe wrote:

> Remove optional ACPI static Service Processor Management Interface
> (SPMI) table based IPMI device discovery mechanism.

Myron,

The other patches look reasonable.  This one, I'm not so sure.

My concern is based on these thoughts:

During early hardware bring-up, both ACPI and IPMI subsystems
of a new system design tend to be a total mess.  The static
table parts of ACPI are likely to be usable much earlier than
the parts that require a fully functional ACPI subsystem.

For the people developing and testing the new system's IPMI
subsystem, losing the SPMI discovery method could be a
significant pain point.

A new IPMI subsystem may also be "bolted on" to an existing
system for early development before the new system is mature
enough to even power on.  In such a situation it may be easier
to supply a fake table than fake live ACPI information.  The
hardware at that point may not be in PCI space, yet may also
not be at static addresses that would be easy to supply as
module load parameters.

I would be more comfortable if you kept this code, perhaps
suppressed under a "CONFIG_IPMI_SPMI" config option.

>Bela<