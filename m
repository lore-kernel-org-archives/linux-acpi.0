From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: New SmartBattery DSDT-based controller
Date: Mon, 31 Jan 2005 10:50:16 +0100
Message-ID: <m24qgyorl3.fsf@phoenix.squirrel.nl>
References: <41FBDDE2.1050403@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41FBDDE2.1050403-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> (Rich Townsend's message of
 "Sat, 29 Jan 2005 14:02:58 -0500")
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

> 5) Download the modified DSDT, and install it following the
> instructions at http://forums.gentoo.org/viewtopic.php?t=122145 (see
> section 9; although in Gentoo forums, these instructions should work
> on most systems).

Although appending the DSDT to the initrd is a neat trick, wouldn't it
be better to have a kernel boot parameter, e.g. "dsdt_override=myDSDT.aml"?

-- Johan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
