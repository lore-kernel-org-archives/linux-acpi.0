From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC v2 0/5] surface heterogeneous memory performance information
Date: Thu, 6 Jul 2017 19:08:04 -0400
Message-ID: <20170706230803.GE2919@redhat.com>
References: <20170706215233.11329-1-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752504AbdGFXIJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Jul 2017 19:08:09 -0400
Content-Disposition: inline
In-Reply-To: <20170706215233.11329-1-ross.zwisler@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>, "Box, David E" <david.e.box@intel.com>, "Kogut, Jaroslaw" <Jaroslaw.Kogut@intel.com>, "Lahtinen, Joonas" <joonas.lahtinen@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Nachimuthu, Murugasamy" <murugasamy.nachimuthu@intel.com>, "Odzioba, Lukasz" <lukasz.odzioba@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Schmauss, Erik" <erik.schmauss@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len

On Thu, Jul 06, 2017 at 03:52:28PM -0600, Ross Zwisler wrote:

[...]

> 
> ==== Next steps ====
> 
> There is still a lot of work to be done on this series, but the overall
> goal of this RFC is to gather feedback on which of the two options we
> should pursue, or whether some third option is preferred.  After that is
> done and we have a solid direction we can add support for ACPI hot add,
> test more complex configurations, etc.
> 
> So, for applications that need to differentiate between memory ranges based
> on their performance, what option would work best for you?  Is the local
> (initiator,target) performance provided by patch 5 enough, or do you
> require performance information for all possible (initiator,target)
> pairings?

Am i right in assuming that HBM or any faster memory will be relatively small
(1GB - 8GB maybe 16GB ?) and of fix amount (ie size will depend on the exact
CPU model you have) ?

If so i am wondering if we should not restrict NUMA placement policy for such
node to vma only. Forbid any policy that would prefer those node globally at
thread/process level. This would avoid wide thread policy to exhaust this
smaller pool of memory.

Drawback of doing so would be that existing applications would not benefit
from it. So workload where is acceptable to exhaust such memory wouldn't
benefit until their application are updated.


This is definitly not something impacting this patchset. I am just thinking
about this at large and i believe that NUMA might need to evolve slightly
to better handle memory hierarchy.

Cheers,
Jérôme
