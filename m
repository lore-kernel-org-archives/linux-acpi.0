From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 0/3] create sysfs representation of ACPI HMAT
Date: Fri, 22 Dec 2017 09:13:59 -0800
Message-ID: <5d7df981-69c2-e371-f48d-13c418fff134@intel.com>
References: <20171214021019.13579-1-ross.zwisler@linux.intel.com>
 <2d6420f7-0a95-adfe-7390-a2aea4385ab2@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24754 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756079AbdLVROB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Dec 2017 12:14:01 -0500
In-Reply-To: <2d6420f7-0a95-adfe-7390-a2aea4385ab2@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>, "Box, David E" <david.e.box@intel.com>, "Kogut, Jaroslaw" <Jaroslaw.Kogut@intel.com>, "Koss, Marcin" <marcin.koss@intel.com>, "Koziej, Artur" <artur.koziej@intel.com>, "Lahtinen, Joonas" <joonas.lahtinen@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Nachimuthu, Murugasamy" <murugasamy.nachimuthu@intel.com>, "Odzioba, Lukasz" <lukasz.odzioba@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Schmauss, Erik" <erik.schmauss@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Balbir Singh <bsingharora@gmail.com>, Brice Goglin <brice.goglin@gmail.com>, Dan

On 12/21/2017 07:09 PM, Anshuman Khandual wrote:
> I had presented a proposal for NUMA redesign in the Plumbers Conference this
> year where various memory devices with different kind of memory attributes
> can be represented in the kernel and be used explicitly from the user space.
> Here is the link to the proposal if you feel interested. The proposal is
> very intrusive and also I dont have a RFC for it yet for discussion here.

I think that's the best reason to "re-use NUMA" for this: it's _not_
intrusive.

Also, from an x86 perspective, these HMAT systems *will* be out there.
Old versions of Linux *will* see different types of memory as separate
NUMA nodes.  So, if we are going to do something different, it's going
to be interesting to un-teach those systems about using the NUMA APIs
for this.  That ship has sailed.
