From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: New SmartBattery DSDT-based controller
Date: Sun, 06 Feb 2005 22:40:03 +0100
Message-ID: <m2r7jtz7t8.fsf@phoenix.squirrel.nl>
References: <41FBDDE2.1050403@bartol.udel.edu>
	<m24qgyorl3.fsf@phoenix.squirrel.nl>
	<200501311002.36671.david.goodenough@btconnect.com>
	<m2oef5oksl.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m2oef5oksl.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org> (Johan Vromans's message
 of "Mon, 31 Jan 2005 13:16:58 +0100")
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

Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org> writes:

>> This would be wonderful.  Do you know of a patch that implements this?
>
> No, but I'll take a look.

Seems to be a bit harder than I expected. At the point where the ACPI
table is overridden, you cannot do anything yet (in particular, no
disk I/O)... So the only way to implement this would be to get the DSDT
table from the initrd, making the 'improvement' to the current initrd
patch not worth the trouble.

On a side note: wouldn't it be better if the initrd patch started to
look for the DSDT signature *backwards* from the end? This would
guarantee that always the last DSDT appended is used. In other words,
updating the initrd is easy: just append a new signature + table.
If you're like me, you'll probably going to build a new kernel + new
initrd way before it gets to big ...

-- Johan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
