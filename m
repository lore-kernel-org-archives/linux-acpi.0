From: Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCH] hmat: Register attributes for memory hot add
Date: Wed, 10 Apr 2019 13:07:37 +0200
Message-ID: <30db4768-5dc8-d493-1bac-03f382e867e4@inria.fr>
References: <20190409214415.3722-1-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190409214415.3722-1-keith.busch@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

Thanks Keith, this solves my issue.

On a machine where node4 (PMEM) is close to node0 and node1 (1st socket
SNCs), hotplugging that node makes node0 and node1 appear as initiators
to node4 (and node4 as target to them). Same for the other socket. And
perf attributes look good.

Reported-and-tested-by: Brice Goglin <Brice.Goglin@inria.fr>

Just one minor typo below.


Le 09/04/2019 à 23:44, Keith Busch a écrit :
> Some types of memory nodes that HMAT describes may not be online at the
> time we initially parse their nodes' tables. If the node should be set
> to online later, as can happen when using PMEM as RAM after boot, the
> node's attributes will be missing their initiator links and performance.
>
> Regsiter a memory notifier callback and set the memory attributes when

Typo regsiter->register

thanks

Brice
