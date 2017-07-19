From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC v2 0/5] surface heterogeneous memory performance information
Date: Wed, 19 Jul 2017 08:25:13 -0700
Message-ID: <0e72ed92-75d0-3fe1-0ab7-ffa069d11b46@intel.com>
References: <20170706215233.11329-1-ross.zwisler@linux.intel.com>
 <dc224433-3d09-8f2e-d278-fee98ada2afc@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:40156 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbdGSPZO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Jul 2017 11:25:14 -0400
In-Reply-To: <dc224433-3d09-8f2e-d278-fee98ada2afc@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Liu <liubo95@huawei.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>, "Box, David E" <david.e.box@intel.com>, "Kogut, Jaroslaw" <Jaroslaw.Kogut@intel.com>, "Lahtinen, Joonas" <joonas.lahtinen@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Nachimuthu, Murugasamy" <murugasamy.nachimuthu@intel.com>, "Odzioba, Lukasz" <lukasz.odzioba@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Schmauss, Erik" <erik.schmauss@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jerome Glisse <jglisse@redhat.com>, Len Brown <lenb@kernel.org>Tim Chen <t>

On 07/19/2017 02:48 AM, Bob Liu wrote:
>> Option 2: Provide the user with HMAT performance data directly in
>> sysfs, allowing applications to directly access it without the need
>> for the library and daemon.
>> 
> Is it possible to do the memory allocation automatically by the
> kernel and transparent to users? It sounds like unreasonable that
> most users should aware this detail memory topology.

It's possible, but I'm not sure this is something we automatically want
to see added to the kernel.

I look at it like NUMA.  We have lots of details available about how
things are connected.  But, "most users" are totally unaware of this.
We give them decent default policies and the ones that need more can do
so with the NUMA APIs.

These patches provide the framework to help users/apps who *do* care and
want to make intelligent, topology-aware decisions.
