From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
Date: Thu, 15 Nov 2018 05:57:10 -0800
Message-ID: <20181115135710.GD19286@bombadil.infradead.org>
References: <20181114224921.12123-2-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181114224921.12123-2-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 14, 2018 at 03:49:14PM -0700, Keith Busch wrote:
> Memory-only nodes will often have affinity to a compute node, and
> platforms have ways to express that locality relationship.
> 
> A node containing CPUs or other DMA devices that can initiate memory
> access are referred to as "memory iniators". A "memory target" is a
> node that provides at least one phyiscal address range accessible to a
> memory initiator.

I think I may be confused here.  If there is _no_ link from node X to
node Y, does that mean that node X's CPUs cannot access the memory on
node Y?  In my mind, all nodes can access all memory in the system,
just not with uniform bandwidth/latency.
