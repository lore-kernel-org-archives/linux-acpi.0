From: Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCHv4 10/13] node: Add memory caching attributes
Date: Tue, 12 Feb 2019 09:11:03 +0100
Message-ID: <854e892c-0c0d-6ab8-bc83-3c6b462bcf72@inria.fr>
References: <20190116175804.30196-1-keith.busch@intel.com>
 <20190116175804.30196-11-keith.busch@intel.com>
 <4a7d1c0c-c269-d7b2-11cb-88ad62b70a06@inria.fr>
 <20190210171958.00003ab2@huawei.com>
 <20190211152303.GA4525@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211152303.GA4525@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org


Le 11/02/2019 à 16:23, Keith Busch a écrit :
> On Sun, Feb 10, 2019 at 09:19:58AM -0800, Jonathan Cameron wrote:
>> On Sat, 9 Feb 2019 09:20:53 +0100
>> Brice Goglin <Brice.Goglin@inria.fr> wrote:
>>
>>> Hello Keith
>>>
>>> Could we ever have a single side cache in front of two NUMA nodes ? I
>>> don't see a way to find that out in the current implementation. Would we
>>> have an "id" and/or "nodemap" bitmask in the sidecache structure ?
>> This is certainly a possible thing for hardware to do.
>>
>> ACPI IIRC doesn't provide any means of representing that - your best
>> option is to represent it as two different entries, one for each of the
>> memory nodes.  Interesting question of whether you would then claim
>> they were half as big each, or the full size.  Of course, there are
>> other possible ways to get this info beyond HMAT, so perhaps the interface
>> should allow it to be exposed if available?
> HMAT doesn't do this, but I want this interface abstracted enough from
> HMAT to express whatever is necessary.
>
> The CPU cache is the closest existing exported attributes to this,
> and they provide "shared_cpu_list". To that end, I can export a
> "shared_node_list", though previous reviews strongly disliked multi-value
> sysfs entries. :(
>
> Would shared-node symlinks capture the need, and more acceptable?


As a user-space guy reading these files/symlinks, I would prefer reading
a bitmask just like we do for CPU cache "cpumap" or CPU "siblings" files
(or sibling_list).

Reading a directory and looking for dentries matching "foo%d" is far
less convenient  in C. If all these files are inside a dedicated
subdirectory, it's better but still not as easy.

Brice
