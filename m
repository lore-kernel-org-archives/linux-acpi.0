From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: sbs-linux: smart batteries on SourceForge
Date: Mon, 07 Feb 2005 10:32:40 +0100
Message-ID: <m23bw8zpdz.fsf@phoenix.squirrel.nl>
References: <41FBDDE2.1050403@bartol.udel.edu>
	<42057EBE.5090102@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42057EBE.5090102-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> (Rich Townsend's message of
 "Sat, 05 Feb 2005 21:19:42 -0500")
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

> Full instructions are provided in the accompanying README file.

If I understand the instructions correctly, _every_ change to the BIOS
settings would require me to:
 - boot a non-DSDT-overriding kernel
 - extract the (possibly modified) DSDT
 - repeat the patch procedure, building a new DSDT
 - strip the old one from my initrd, and append the new DSDT
 - reboot the new kernel

This is quite cumbersome.
Is there any insight in what changes to BIOS settings would lead to
changes in the DSDT?

-- Johan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
