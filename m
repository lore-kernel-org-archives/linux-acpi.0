From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: Smart Battery System driver
Date: Thu, 20 Jan 2005 22:31:20 +0100
Message-ID: <m2sm4v4wk7.fsf@phoenix.squirrel.nl>
References: <41E81C2C.8010809@bartol.udel.edu>
	<1105747983.7368.3.camel@tyrosine>
	<47e0449d05011419037877f931@mail.gmail.com>
	<m2fz13x8mw.fsf@phoenix.squirrel.nl>
	<41EA2C1D.3030909@bartol.udel.edu> <41EC7C7D.1070003@bartol.udel.edu>
	<41EC9316.80109@bartol.udel.edu> <41EDE2EA.7090404@bartol.udel.edu>
	<m2wtu74yzq.fsf@phoenix.squirrel.nl>
	<41F01923.1000503@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41F01923.1000503-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> (Rich Townsend's message of
 "Thu, 20 Jan 2005 15:48:35 -0500")
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

Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> writes:

> I do this because everything in /lib/modules/XXX/kernel/* gets
> clobbered when you do a make modules_install from the kernel source
> tree; 

I see.

> I have recently realized that the whole SBS functionality can be
> implemented in terms of control methods in the DSDT, without the
> need for any kernel drivers.

Nice. This would require a kernel recompile/reboot  for each DSDT
modification...

-- Johan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
