From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 8/8] ACPI / trace: Add trace interface for eMCA driver
Date: Tue, 15 Oct 2013 21:43:46 -0300
Message-ID: <20131015214346.68718bcd.m.chehab@samsung.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-9-git-send-email-gong.chen@linux.intel.com>
 <20131015165435.GA2777@naverao1-tp.ibm.com> <20131015170039.GF7908@pd.tnic>
 <525D7BCD.7080303@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <525D7BCD.7080303@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Borislav Petkov <bp@alien8.de>, "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Aristeu Rozanski Filho <arozansk@redhat.com>
List-Id: linux-acpi@vger.kernel.org

I see a few problems on this patchset:

Em Tue, 15 Oct 2013 23:00:53 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> escreveu:

> On 10/15/2013 10:30 PM, Borislav Petkov wrote:
> > On Tue, Oct 15, 2013 at 10:24:35PM +0530, Naveen N. Rao wrote:
> >> On 2013/10/11 02:32AM, Chen Gong wrote:
> >>> Use trace interface to elaborate all H/W error related
> >>> information.
> >>>
> >>> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> >>> ---
> >> <snip>
> >>> +TRACE_EVENT(extlog_mem_event,
> >>> +	TP_PROTO(u32 etype,
> >>> +		char *dimm_loc,
> >>> +		const uuid_le *fru_id,

Using a custom typedef here seems problematic, as that can make userspace
interface more complicated.

> >>> +		char *fru_text,
> >>> +		u64 error_count,
> >>> +		u32 severity,
> >>> +		u64 phy_addr,
> >>> +		char *mem_loc),

By looking on the rest of the changes, the mem_loc can now contain the 
right location of the memory error, including on what DIMM the error
happened. It can also (optionally) contain the DIMM label. 

Mangling those information on just one string field seems to be a very
bad idea to me, as it prevents to write a generic logic, on userspace,
that would apply a per-DIMM threshold policy.

Also, userspace needs to know what's the granularity for the error
that an eMCA driver will give, in order to adjust its policies.

> >>
> >> [Adding Mauro...]
> >>
> >> This looks very similar to the trace event I wrote a while back,
> >> which was similar to the one provided by ghes_edac:
> >> http://thread.gmane.org/gmane.linux.kernel.pci/24616
> >>
> >> Seems to me this has the same issues we previously discussed w.r.t
> >> EDAC conflicts...

Agreed.

> >
> > Right, I'm inclined to leave this trace_mc_event in ras_event.h to edac
> > use alone because of all those layers which don't mean whit for GHES and
> > eMCA error sources.

If you don't create the EDAC nodes, it means that userspace doesn't have any
glue about what error information will be provided.

The right thing to do is, IMHO, add some additional EDAC sysfs nodes that
shows what kind of error information will be provided by the device, e. g.:

	- a complete hardware-based type of information directly obtained from
	  the hardware;

	- a very poor BIOS-based type of error information, where the provided
	  data is not sufficient to pinpoint to the DIMM where the error actually
	  occurred (what's currently there at ghes_edac);

	- an eMCA-based type of error information, where the BIOS and ACPI will
	  provide the complete error path, allowing userspace to properly parse
	  the errors as if they come from the hardware-based approach.

In any case, this is provided by the EDAC core functions that describe the
memory in details. So, IMHO, get rid of EDAC is a big mistake.

> > And maybe define a trace_mem_event which is shared by GHES and eMCA and
> > not use the edac tracepoint there not load ghes_edac on such systems
> > which have sufficient decoding capability in firmware.
> >
> > Thoughts?
> 
> I thought the primary problem was the conflict with edac core itself. 
> So, if I'm not mistaken, we would have to prevent all edac drivers from 
> loading.

Yes, this is another aspect of this approach: whatever provided mechanism,
the Kernel should assure that one error path won't conflict with the other
ones. We know by experience that enabling both BIOS-based and hardware-based
mechanisms cause race conditions, with affects both ways.
It is also nice to allow the user to choose his preferred mechanism, when
more than one is properly supported on a given system.

Regards,
Mauro

(c/c Aristeu, as he might also being working with similar stuff)
