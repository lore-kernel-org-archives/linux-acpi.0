From: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hot-plug notification help needed
Date: Wed, 3 Aug 2005 13:55:12 -0700
Message-ID: <20050803135511.B5010@unix-os.sc.intel.com>
References: <200507251735.23394.bjorn.helgaas@hp.com> <200508021641.26007.bjorn.helgaas@hp.com> <20050803123627.A4443@unix-os.sc.intel.com> <200508031427.11057.bjorn.helgaas@hp.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200508031427.11057.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>; from bjorn.helgaas-VXdhtT5mjnY@public.gmane.org on Wed, Aug 03, 2005 at 02:27:11PM -0600
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

On Wed, Aug 03, 2005 at 02:27:11PM -0600, Bjorn Helgaas wrote:
> Did you have a patch to fake add/remove notifications?  I'd
> be interested in it.
Sent to you in another mail:-)
> 
> I see the acpiphp_configure_bridge() call between the add
> and start calls, which I assume is what you mean here.

Yup,that's correct.

> 
> But rather than adding more interaction between the drivers
> and the ACPI core, I think it would be better to put this
> configuration in the driver's add() or start() method.
> Then you have more consistency between the "present at boot"
> case and the "hot-added later" case, at least in terms of
> the driver/core interaction.

Sure, I agree with your suggested approach. Once we have the
core ACPI changes done, we need to clean up the affected drivers
and all of this has to get comitted at once. This is going to be
a huge efforts in terms of testing:-)

> 
> (I know the driver probably has to handle hot-added bridges
> specially because the BIOS treats them differently, but that
> seems like something only acpiphp_glue.c needs to know about.)

> 
> Sorry for so much talk and so little code :-)  I'll try to
No problem:-)
> rectify that...
Thanks for your interest in cleaning this 
hotplug registration logic.

-Cheers,
Anil



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
