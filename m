From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external control
 operation interface for domain0 ACPI parser
Date: Thu, 30 Jul 2009 13:52:05 -0700
Message-ID: <4A7207F5.8070802@goop.org>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com> <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com> <4D05DB80B95B23498C72C700BD6C2E0B315D65B6@pdsmsx502.ccr.corp.intel.com> <alpine.LFD.2.00.0907301121080.17818@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:44778 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbZG3UwH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Jul 2009 16:52:07 -0400
In-Reply-To: <alpine.LFD.2.00.0907301121080.17818@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Yu, Ke" <ke.yu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>, Xen-devel <xen-devel@lists.xensource.com>

On 07/30/09 08:37, Len Brown wrote:
> I agree with Kevin that it would be a mistake to put ACPI both into
> both dom0 and the hypervisor.  Frankly, on many levels, ACPI was
> designed with Windows in mind, and the further an OS strays from
> how Windows does things, the less likely you'll run well on many 
> systems.  Obviously, Xen looks nothing like windows, or any other OS,
> for it seems to have not one division between implementation and
> policy, but multiple...
>
> So I have a fundamental lack of understanding of the logic
> behind the partitioning behind the hypervisor and dom0.
> Maybe somebody explain it to me in terms that I'll understand?
>   

The basic idea is that Xen controls the things it must, and leaves
everything else to guest kernels.  At heart that means it controls the
physical CPUs (which includes things like local APICs) and memory (by
maintaining control over the CPU's paging hardware via the pagetables).

Everything beyond that is left to guest domains which handle various
responsibilities; informally we refer to "dom0" which is "the"
privileged domain which handles things like hardware discovery, device
drivers, domain creation, and a number of other services. However
there's no inherent reason why all these jobs must be aggregated
together.  For example, there's active work on having specific "driver
domains" which have responsibility for a specific piece of hardware or
class of hardware, but don't (and can't) do any of the other
"privileged" jobs.

> It reminds me of the partitioning between the Mach microkernel
> and the "user-space OS personality, eg Unix".  This looked really neat
> in proposals for funding and academic papers, but in reality it turned
> out to have little value other than employing programmers to
> re-invent the wheel, only to discover that the original round
> wheel was better than the square one that they produced...
>   

There are some parallels, and there's even a paper with a title
something like "hypervisors: microkernels done right".  I think the
rough sketch of the argument is that a Mach-like system with lots of
server processes fails in practise because its a poor match for the APIs
that people actually want to use and are used to, and if you want
Unix-like functionality then you just need to put a Unix in there. 
Xen's breakdown is more along the lines of the hardware architecture
itself, and therefore is in some sense more "natural": kernels which run
processes are real kernels, with the full programming interfaces
everyone wants to use; shared resources like CPU and memory can be
multiplexed fairly easily using well-understood techniques; with some
extra work, you can even let guest domains have direct hardware access
using their normal device drivers so that the hypervisor doesn't need to
deal with them.

ACPI - which wears many hats affecting many aspects of the system -
doesn't have any neat dividing lines, and doesn't follow the contours of
the underlying architecture, and so appears to be a poor match for a
Xen-like model.  If it were possible to partition ACPI into broad
function groupings, then maybe it would be possible to get a better fit,
but I'm not sure whether that's possible.

In general Xen doesn't have much use for ACPI; aside from this specific
case of needing to know how to control the CPUs for power management, it
doesn't really care about ACPI's services.  It doesn't do interrupt
routing, it doesn't really need to know about thermal management, any
anything it does need to know it can be told by the kernel which does
have a much greater interest in ACPI.  S3 suspend/resume needs to go via
Xen for the final stage, but aside from that it can all be handled in Linux.

    J
