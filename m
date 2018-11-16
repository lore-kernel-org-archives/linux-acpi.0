From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
Date: Fri, 16 Nov 2018 11:57:58 +0530
Message-ID: <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
References: <20181114224902.12082-1-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114224902.12082-1-keith.busch@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 11/15/2018 04:19 AM, Keith Busch wrote:
> This series provides a new sysfs representation for heterogeneous
> system memory.
> 
> The previous series that was specific to HMAT that this series was based
> on was last posted here: https://lkml.org/lkml/2017/12/13/968
> 
> Platforms may provide multiple types of cpu attached system memory. The
> memory ranges for each type may have different characteristics that
> applications may wish to know about when considering what node they want
> their memory allocated from. 
> 
> It had previously been difficult to describe these setups as memory
> rangers were generally lumped into the NUMA node of the CPUs. New
> platform attributes have been created and in use today that describe
> the more complex memory hierarchies that can be created.
> 
> This series first creates new generic APIs under the kernel's node
> representation. These new APIs can be used to create links among local
> memory and compute nodes and export characteristics about the memory
> nodes. Documentation desribing the new representation are provided.
> 
> Finally the series adds a kernel user for these new APIs from parsing
> the ACPI HMAT.

Not able to see the patches from this series either on the list or on the
archive (https://lkml.org/lkml/2018/11/15/331). IIRC last time we discussed
about this and the concern which I raised was in absence of a broader NUMA
rework for multi attribute memory it might not a good idea to settle down
and freeze sysfs interface for the user space. 
