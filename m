From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Re: Re: Smart Battery System driver
Date: Fri, 21 Jan 2005 18:22:57 +0000
Message-ID: <1106331777.30227.24.camel@tyrosine>
References: <F760B14C9561B941B89469F59BA3A84708CBB988@orsmsx401.amr.corp.intel.com>
	 <20050121141449.GA15288@message-id.gmane0305.slipkontur.de>
	 <41F136AE.3010603@bartol.udel.edu> <1106328167.30227.18.camel@tyrosine>
	 <41F14424.6010600@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41F14424.6010600-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-01-21 at 13:04 -0500, Rich Townsend wrote:

> Yes, but isn't the lm-sensors kernel code accessed through a uniform 
> API?   That's what we need for the kernel battery stuff; at the moment, 
> CM batteries are interfaced using ACPI control methods, while Smart 
> Batteries are interfaced using SMBus accesses. Wouldn't it be a good 
> idea to present all of the available battery info through some unified 
> interface? Or are you arguing that this should all be done (as much as 
> possible) in userland?

In general, if it can be done in userland, it should be done in
userland. A power management abstraction layer is needed anyway (A
userspace app should be able to request a suspend without knowing
whether the system is ACPI, APM, a Mac or whatever), so implementing the
batteries in whichever way requires least kernel code is almost
certainly the right answer.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
