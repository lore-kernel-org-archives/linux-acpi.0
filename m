From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] PNPACPI parser fix
Date: Sat, 05 Feb 2005 10:07:08 +0100
Message-ID: <42048CBC.8070700@free.fr>
References: <4203AFC5.8070308@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000704070800050502040905"
In-Reply-To: <4203AFC5.8070308-GANU6spQydw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Cc: Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000704070800050502040905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

matthieu castet wrote:
> Hi,
> 
> This patch is very old (11/2004), but never get merged even if acked by 
> Shaohua Li.
> As you can see in the bugzilla report 
> (http://bugzilla.kernel.org/show_bug.cgi?id=3912), it solve parsing 
> issue in the pnpacpi core : the pnpacpi parser supposed that are no
> resource after EndDependentFn.
> 
> Please apply this patch.
> Thanks.
> 
> Matthieu CASTET

oops, the attachement was wrong.

Here is the patch.


Regards,

Matthieu

--------------000704070800050502040905
Content-Type: text/x-patch;
 name="pnpacpi_parser.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi_parser.patch"

--- linux-2.6.9/drivers/pnp/pnpacpi/rsparser.c.old	2004-11-12 22:55:10.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/rsparser.c	2004-11-20 10:44:36.000000000 +0100
@@ -443,6 +443,7 @@
 
 struct acpipnp_parse_option_s {
 	struct pnp_option *option;
+	struct pnp_option *option_independent;
 	struct pnp_dev *dev;
 };
 
@@ -506,7 +507,15 @@
 			parse_data->option = option;	
 			break;
 		case ACPI_RSTYPE_END_DPF:
-			return AE_CTRL_TERMINATE;
+			/*only one EndDependentFn is allowed*/
+			if (!parse_data->option_independent) {
+				pnp_warn("PnPACPI: more than one EndDependentFn");
+				return AE_ERROR;
+			}
+			parse_data->option = parse_data->option_independent;
+			parse_data->option_independent = NULL;
+			break;
 		default:
 			pnp_warn("PnPACPI:Option type: %d not handle", res->id);
 			return AE_ERROR;
@@ -524,6 +533,7 @@
 	parse_data.option = pnp_register_option_independent(dev);
 	if (!parse_data.option)
 		return AE_ERROR;
+	parse_data.option_independent = parse_data.option;
 	parse_data.dev = dev;
 	status = acpi_walk_resources(handle, METHOD_NAME__PRS, 
 		pnpacpi_option_resource, &parse_data);

--------------000704070800050502040905--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
