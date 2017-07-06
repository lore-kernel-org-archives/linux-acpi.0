From: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC v2 0/5] surface heterogeneous memory performance information
Date: Thu, 6 Jul 2017 16:30:08 -0700
Message-ID: <e85da2ef-88bd-18f9-8b92-b64875d98a8b@intel.com>
References: <20170706215233.11329-1-ross.zwisler@linux.intel.com>
 <20170706230803.GE2919@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20170706230803.GE2919-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Box, David E" <david.e.box-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, "Zheng,
 Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Anaczkowski,
 Lukasz" <lukasz.anaczkowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore,
 Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Odzioba,
 Lukasz" <lukasz.odzioba-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Schmauss, Erik" <erik.schmauss-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, "Kogut,
 Jaroslaw" <Jaroslaw.Kogut-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Nachimuthu,
 Murugasamy" <murugasamy.nachimuthu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Lahtinen, Joonas" <joonas.lahtinen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Tim Chen <tim.c.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 07/06/2017 04:08 PM, Jerome Glisse wrote:
>> So, for applications that need to differentiate between memory ranges based
>> on their performance, what option would work best for you?  Is the local
>> (initiator,target) performance provided by patch 5 enough, or do you
>> require performance information for all possible (initiator,target)
>> pairings?
> 
> Am i right in assuming that HBM or any faster memory will be relatively small
> (1GB - 8GB maybe 16GB ?) and of fix amount (ie size will depend on the exact
> CPU model you have) ?

For HBM, that's certainly consistent with the Xeon Phi MCDRAM.

But, please remember that this patch set is for fast memory *and* slow
memory (vs. plain DRAM).

> If so i am wondering if we should not restrict NUMA placement policy for such
> node to vma only. Forbid any policy that would prefer those node globally at
> thread/process level. This would avoid wide thread policy to exhaust this
> smaller pool of memory.

You would like to take the NUMA APIs and bifurcate them?  Make some of
them able to work on this memory, and others not?  So, set_mempolicy()
would work if you passed it one of these "special" nodes with
MPOL_F_ADDR, but would fail otherwise?


> Drawback of doing so would be that existing applications would not benefit
> from it. So workload where is acceptable to exhaust such memory wouldn't
> benefit until their application are updated.

I think the guys running 40-year-old fortran binaries might not be so
keen on this restriction.  I bet there are a pretty substantial number
of folks out there that would love to get new hardware and just do:

	numactl --membind=fast-node ./old-binary

If I were working for a hardware company, I'd sure like to just be able
to sell somebody some fancy new hardware and have their existing
software "just work" with a minimal wrapper.
