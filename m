From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Thu, 20 Jan 2005 22:10:44 +0100
Message-ID: <20050120211044.GA27543@message-id.gmane0305.slipkontur.de>
References: <1105747983.7368.3.camel@tyrosine> <47e0449d05011419037877f931@mail.gmail.com> <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu> <41EC7C7D.1070003@bartol.udel.edu> <41EC9316.80109@bartol.udel.edu> <41EDE2EA.7090404@bartol.udel.edu> <41EF1F6A.5000807@bartol.udel.edu> <41EFCA59.6040100@arrakis.dhis.org> <41EFD672.2040308@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41EFD672.2040308-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 20, 2005 at 11:04:02AM -0500, Rich Townsend wrote:

> The best solution would be to perform a run-time check. I'll see if I 
> can add code to dynamically detect if the ac_adapter and battery 
> directories are empy on module insertion, and only add the legacy 
> interfaces if they are.

not "empty" but "do not exist". We will probably find machines that have
working CM Battery but can also be used with SBS.
Or maybe it is possible from kernelspace to check if a module is loaded
to lock each other out => if battery or ac is loaded, sbs will refuse
to load and the other way round.

> PS Last night, I got a proof-of-concept for event notifications working. 
> I still haven't got battery alarms working, but we should now be able to 
> do event-driven AC and battery present/charging/discharging statuses.

It would be pretty cool to throw an event on every change of battery charge
level (some HP notebooks do this even with CM battery), so there is no need
to poll for battery charge level.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
