From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hotplug
Date: Mon, 17 Jan 2005 14:17:51 -0800 (PST)
Message-ID: <20050117221751.49612.qmail@web50204.mail.yahoo.com>
References: <20050117140121.A21143@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050117140121.A21143-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Rajesh,

I do have an IBM Thinkpad, and I am using IBM_ACPI
module. But this module is limited in functionality
until we get proper ACPI hotplug support.

The problem is that current acpi implementation cannot
dynamically add devices not existant at boot time, or
this is what I was told.
If I boot docked in, I have more ACPI devices than if
I boot undocked, and that info is not possible for
ACPI to get dynamically when I plug the laptop in
docking station. (IE: find /sys/firmware/acpi produces
different output for docked and undocked laptop).
IBM_ACPI module deals with some non ACPI standard
functionality, but it says in the README file that you
need to have booted with the laptop docked, otherwise
it is unable to see the devices.

Thanks,
Paul


--- Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> On Sat, Jan 15, 2005 at 02:14:53AM -0800, Paul
> Ionescu wrote:
> > 
> > I was hoping that I can use my docking station
> without
> > being necessary to boot docked.
> 
> I see. Docking functionality needs more support that
> does
> not live in acpiphp. There have been some recent
> posts,
> for example, about docking support in Thinkpads and
> this functionality is separately enabled by a
> different
> ACPI config option. Grep for ACPI_IBM in
> acpi/Kconfig
> and see Documentation/ibm-acpi.txt for more details.
> 
> Rajesh
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
