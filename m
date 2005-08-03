From: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hot-plug notification help needed
Date: Wed, 3 Aug 2005 14:41:46 -0700
Message-ID: <20050803144143.A5422@unix-os.sc.intel.com>
References: <200507251735.23394.bjorn.helgaas@hp.com> <200508031427.11057.bjorn.helgaas@hp.com> <20050803135511.B5010@unix-os.sc.intel.com> <200508031513.30570.bjorn.helgaas@hp.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200508031513.30570.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>; from bjorn.helgaas-VXdhtT5mjnY@public.gmane.org on Wed, Aug 03, 2005 at 03:13:30PM -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 03, 2005 at 03:13:30PM -0600, Bjorn Helgaas wrote:
> On Wednesday 03 August 2005 2:55 pm, Keshavamurthy Anil S wrote:
> > Once we have the
> > core ACPI changes done, we need to clean up the affected drivers
> > and all of this has to get comitted at once. This is going to be
> > a huge efforts in terms of testing:-)
> 
> Better now than later then, I guess.  As far as I can see, this
> affects acpi_memhotplug, container, processor_core, and acpiphp.
> Are these widely used yet?  Do distros support them?  These drivers
> seem fairly immature, so I'm curious about why the testing should
> be so onerous.
Not sure about any distros specifically enabling this stuff but 
some of the code are common for boot path too, hence our changes 
affect lots of system. If we don't have any complains booting then
that is more than 80% coverage and rest 20% is specifically targetting
the hotplug path for CPU, Memory and Rootbridge.

Cheers,
-Anil


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
