From: Felipe Alfaro Solana <felipe_alfaro-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: about held locks in acpi_psx_execute()
Date: Sun, 30 Nov 2003 22:53:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1070229185.2183.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Linux Kernel Mailinglist <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

While looking at drivers/acpi/parser/psxface.c,I have noticed that the
acpi_psx_execute(0 function seems to held some structures referrenced
when an error occurs during its execution:


acpi_status
acpi_psx_execute (
        struct acpi_namespace_node      *method_node,
        union acpi_operand_object       **params,
        union acpi_operand_object       **return_obj_desc)
{
...
        if (params) {
                /*
                 * The caller "owns" the parameters, so give each one an
extra
                 * reference
                 */
                for (i = 0; params[i]; i++) {
                        acpi_ut_add_reference (params[i]);
                }
        }

        /*
         * 1) Perform the first pass parse of the method to enter any
         * named objects that it creates into the namespace
         */
        ACPI_DEBUG_PRINT ((ACPI_DB_PARSE,
                "**** Begin Method Parse **** Entry=%p obj=%p\n",
                method_node, obj_desc));

        /* Create and init a Root Node */

        op = acpi_ps_create_scope_op ();
        if (!op) {
                return_ACPI_STATUS (AE_NO_MEMORY);
        }

As you can see, acpi_psx_execute() will hold a lock for each element of
the params[] array if there's an error while invoking
acpi_ps_create_scope_op(), for example.

Is this intentional?
Thanks!



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
