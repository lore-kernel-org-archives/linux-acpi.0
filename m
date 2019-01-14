From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv3 08/13] Documentation/ABI: Add node performance
 attributes
Date: Mon, 14 Jan 2019 08:53:11 -0700
Message-ID: <20190114155310.GB22829@localhost.localdomain>
References: <20190109174341.19818-1-keith.busch@intel.com>
 <20190109174341.19818-9-keith.busch@intel.com>
 <20190113231012.GD18710@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190113231012.GD18710@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 14, 2019 at 12:10:12AM +0100, Pavel Machek wrote:
> On Wed 2019-01-09 10:43:36, Keith Busch wrote:
> > +		This node's write latency in nanosecondss available to memory
> > +		initiators in nodes found in this class's
> > initiators_nodelist.
> 
> "nanosecondss", twice.

Thanks for the catch, fixed up for the next rev.
