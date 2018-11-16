From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
Date: Fri, 16 Nov 2018 08:55:20 -0800
Message-ID: <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com>
References: <20181114224902.12082-1-keith.busch@intel.com>
 <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anshuman Khandual <anshuman.khandual@arm.com>, Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 11/15/18 10:27 PM, Anshuman Khandual wrote:
> Not able to see the patches from this series either on the list or on the
> archive (https://lkml.org/lkml/2018/11/15/331). IIRC last time we discussed
> about this and the concern which I raised was in absence of a broader NUMA
> rework for multi attribute memory it might not a good idea to settle down
> and freeze sysfs interface for the user space. 

This *is* the broader NUMA rework.  I think it's just a bit more
incremental that what you originally had in mind.

Did you have an alternative for how you wanted this to look?
