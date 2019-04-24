From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 21/63] Documentation: ACPI: move cppc_sysfs.txt to
 admin-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 01:22:34 +0800
Message-ID: <20190424172232.qtzogm6sweaa4gva@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-22-changbin.du@gmail.com>
 <20190424114844.5de4cfa5@coco.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20190424114844.5de4cfa5@coco.lan>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: fenghua.yu@intel.com, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 24, 2019 at 11:48:44AM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:28:50 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  .../acpi/cppc_sysfs.rst}                      | 71 ++++++++++---------
> >  Documentation/admin-guide/acpi/index.rst      |  1 +
> >  2 files changed, 40 insertions(+), 32 deletions(-)
> >  rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
> > 
> > diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> > similarity index 51%
> > rename from Documentation/acpi/cppc_sysfs.txt
> > rename to Documentation/admin-guide/acpi/cppc_sysfs.rst
> > index f20fb445135d..a4b99afbe331 100644
> > --- a/Documentation/acpi/cppc_sysfs.txt
> > +++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> > @@ -1,5 +1,11 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> >  
> > -	Collaborative Processor Performance Control (CPPC)
> > +==================================================
> > +Collaborative Processor Performance Control (CPPC)
> > +==================================================
> > +
> > +CPPC
> > +====
> >  
> >  CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
> >  performance of a logical processor on a contigious and abstract performance
> > @@ -10,31 +16,28 @@ For more details on CPPC please refer to the ACPI specification at:
> >  
> >  http://uefi.org/specifications
> >  
> > -Some of the CPPC registers are exposed via sysfs under:
> > -
> > -/sys/devices/system/cpu/cpuX/acpi_cppc/
> > -
> 
> 
> > -for each cpu X
> 
> Hmm... removed by mistake?
>
I comfirmed that no content removed.

> > +Some of the CPPC registers are exposed via sysfs under::
> >  
> > ---------------------------------------------------------------------------------
> > +  /sys/devices/system/cpu/cpuX/acpi_cppc/
> 
> Did you parse this with Sphinx? It doesn't sound a valid ReST construction
> to my eyes, as:
> 
> 1) I've seen some versions of Sphinx to abort with severe errors when 
>    there's no blank line after the horizontal bar markup;
> 
> 2) It will very likely ignore the "::" (I didn't test it myself), as you're
>    not indenting the horizontal bar. End of indentation will mean the end
>    of an (empty) literal block.
> 
> So, I would stick with:
> 
> 
> 	Some of the CPPC registers are exposed via sysfs under:
> 
> 	  /sys/devices/system/cpu/cpuX/acpi_cppc/
> 
> 	---------------------------------------------------------------------------------
> 
> 	for each cpu X::
> 
> 
> or:
> 
> 	Some of the CPPC registers are exposed via sysfs under:
> 
> 		/sys/devices/system/cpu/cpuX/acpi_cppc/
> 
> 	for each cpu X
> 
> 	--------------------------------------------------------------------------------
> 
> 	::
> 
> (with is closer to the original author's intent)
> 
> Same applies to the other similar changes on this document.
>
I didn't seen any warning here and the generated html is good. So I think it is
ok.

> >  
> > -$ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
> > -/sys/devices/system/cpu/cpu0/acpi_cppc/:
> > -total 0
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
> > +for each cpu X::
> >  
> > ---------------------------------------------------------------------------------
> > +  $ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
> > +  /sys/devices/system/cpu/cpu0/acpi_cppc/:
> > +  total 0
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
> >  
> >  * highest_perf : Highest performance of this processor (abstract scale).
> > -* nominal_perf : Highest sustained performance of this processor (abstract scale).
> > +* nominal_perf : Highest sustained performance of this processor
> > +  (abstract scale).
> >  * lowest_nonlinear_perf : Lowest performance of this processor with nonlinear
> >    power savings (abstract scale).
> >  * lowest_perf : Lowest performance of this processor (abstract scale).
> > @@ -48,22 +51,26 @@ total 0
> >  * feedback_ctrs : Includes both Reference and delivered performance counter.
> >    Reference counter ticks up proportional to processor's reference performance.
> >    Delivered counter ticks up proportional to processor's delivered performance.
> > -* wraparound_time: Minimum time for the feedback counters to wraparound (seconds).
> > +* wraparound_time: Minimum time for the feedback counters to wraparound
> > +  (seconds).
> >  * reference_perf : Performance level at which reference performance counter
> >    accumulates (abstract scale).
> >  
> > ---------------------------------------------------------------------------------
> >  
> > -		Computing Average Delivered Performance
> > +Computing Average Delivered Performance
> > +=======================================
> > +
> > +Below describes the steps to compute the average performance delivered by
> > +taking two different snapshots of feedback counters at time T1 and T2.
> > +
> > +  T1: Read feedback_ctrs as fbc_t1
> > +      Wait or run some workload
> >  
> > -Below describes the steps to compute the average performance delivered by taking
> > -two different snapshots of feedback counters at time T1 and T2.
> > +  T2: Read feedback_ctrs as fbc_t2
> >  
> > -T1: Read feedback_ctrs as fbc_t1
> > -    Wait or run some workload
> > -T2: Read feedback_ctrs as fbc_t2
> > +::
> >  
> > -delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
> > -reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
> > +  delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
> > +  reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
> >  
> > -delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
> > +  delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
> > diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
> > index d68e9914c5ff..9049a7b9f065 100644
> > --- a/Documentation/admin-guide/acpi/index.rst
> > +++ b/Documentation/admin-guide/acpi/index.rst
> > @@ -10,3 +10,4 @@ the Linux ACPI support.
> >  
> >     initrd_table_override
> >     dsdt-override
> > +   cppc_sysfs
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
