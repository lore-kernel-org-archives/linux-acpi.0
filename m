From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
Date: Tue, 4 Dec 2018 09:54:11 -0700
Message-ID: <20181204165411.GA16666@localhost.localdomain>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181115135710.GD19286@bombadil.infradead.org>
 <20181115145920.GG11416@localhost.localdomain>
 <20181115203654.GA28246@bombadil.infradead.org>
 <20181116183254.GD14630@localhost.localdomain>
 <87sgzd5mca.fsf@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87sgzd5mca.fsf@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 04, 2018 at 09:13:33PM +0530, Aneesh Kumar K.V wrote:
> Keith Busch <keith.busch@intel.com> writes:
> >
> > Indeed, that particular example is out of scope for this series. The
> > first objective is to aid a process running in node B's CPUs to allocate
> > memory in B1. Anything that crosses QPI are their own.
> 
> But if you can extrapolate how such a system can possibly be expressed
> using what is propsed here, it would help in reviewing this.

Expressed to what end? This proposal is not trying to express anything
other than the best possible pairings because that is the most common
information applications will want to know.

> Also how
> do we intent to express the locality of memory w.r.t to other computing
> units like GPU/FPGA?

The HMAT parsing at the end of the series provides an example for how
others may use the proposed interfaces.

> I understand that this is looked at as ACPI HMAT in sysfs format.
> But as mentioned by others in this thread, if we don't do this platform
> and device independent way, we can have application portability issues
> going forward?

Only the last patch is specific to HMAT. If there are other ways to get
the same attributes, then those drivers or subsystems may also register
them with these new kernel interfaces.
