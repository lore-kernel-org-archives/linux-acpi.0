From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv3 07/13] node: Add heterogenous memory access attributes
Date: Fri, 11 Jan 2019 08:58:28 -0700
Message-ID: <20190111155828.GD21095@localhost.localdomain>
References: <20190109174341.19818-1-keith.busch@intel.com>
 <20190109174341.19818-8-keith.busch@intel.com>
 <87y37sit8x.fsf@linux.ibm.com>
 <20190110173016.GC21095@localhost.localdomain>
 <20190111113238.000068b0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190111113238.000068b0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 11, 2019 at 11:32:38AM +0000, Jonathan Cameron wrote:
> On Thu, 10 Jan 2019 10:30:17 -0700
> Keith Busch <keith.busch@intel.com> wrote:
> > I am not aware of a real platform that has an initiator-target pair with
> > better latency but worse bandwidth than any different initiator paired to
> > the same target. If such a thing exists and a subsystem wants to report
> > that, you can register any arbitrary number of groups or classes and
> > rank them according to how you want them presented.
> > 
> 
> It's certainly possible if you are trading off against pin count by going
> out of the soc on a serial bus for some large SCM pool and also have a local
> SCM pool on a ddr 'like' bus or just ddr on fairly small number of channels
> (because some one didn't put memory on all of them).
> We will see this fairly soon in production parts.
> 
> So need an 'ordering' choice for this circumstance that is predictable.

As long as the reported memory target access attributes are accurate for
the initiator nodes listed under an access class, I'm not sure that it
matters what order you use. All the information needed to make a choice
on which pair to use is available, and the order is just an implementation
specific decision.
