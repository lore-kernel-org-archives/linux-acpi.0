From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Re: [PATCH] unresolved symbols with ACPI_DEBUG
Date: Tue, 01 Oct 2002 10:07:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1033459629.358.5.camel@bacchus.gpphy.uni-duesseldorf.de>
References: <Pine.BSF.4.44.0210010937360.427-100000@e0-0.zab2.int.zabbadoz.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <Pine.BSF.4.44.0210010937360.427-100000-pDROZl1FiGxrJICXbmAK0A3q8rc3x57SrE5yTffgRl4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Bjoern A. Zeeb" <bzeeb-lists-mt/InyFV0sMN6vK3N8ee0qxOck334EZe@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hmmm....I provided pretty much the same for 2.4 yesterday. Only
difference is that I had to add a few lines to acpi/utilities/Makefile
to set ACPI_DEBUG_OUTPUT on CONFIG_ACPI_DEBUG. As I have no access to an
2.5 source tree could you check if that is necessary for 2.5 too?

-Knut

Am Die, 2002-10-01 um 09.40 schrieb Bjoern A. Zeeb:
> Hi,
> 
> following patch prevents unresolved symbols when compiling with
> ACPI_DEBUG. (I sent a quite similar patch to Andrew Grover ~2 days
> ago but I think this one is better.)
> We should always use ACPI_DEBUG_OUTPUT and not CONFIG_ACPI_DEBUG I
> think to keep things consistent across multiple directories.
> 
> 
> --- linux-20020930-175132/drivers/acpi/acpi_ksyms.c.orig	Mon Sep 30 17:55:54 2002
> +++ linux-20020930-175132/drivers/acpi/acpi_ksyms.c	Tue Oct  1 06:30:23 2002
> @@ -43,7 +43,7 @@
> 
>  /* ACPI Core Subsystem */
> 
> -#ifdef ACPI_DEBUG
> +#ifdef ACPI_DEBUG_OUTPUT
>  EXPORT_SYMBOL(acpi_dbg_layer);
>  EXPORT_SYMBOL(acpi_dbg_level);
>  EXPORT_SYMBOL(acpi_ut_debug_print_raw);
> @@ -52,7 +52,7 @@
>  EXPORT_SYMBOL(acpi_ut_value_exit);
>  EXPORT_SYMBOL(acpi_ut_exit);
>  EXPORT_SYMBOL(acpi_ut_trace);
> -#endif /*ACPI_DEBUG*/
> +#endif /*ACPI_DEBUG_OUTPUT*/
> 
>  EXPORT_SYMBOL(acpi_get_handle);
>  EXPORT_SYMBOL(acpi_get_parent);
> --- linux-20020930-175132/drivers/acpi/utils.c.orig	Mon Sep 30 17:56:25 2002
> +++ linux-20020930-175132/drivers/acpi/utils.c	Tue Oct  1 06:29:59 2002
> @@ -39,7 +39,7 @@
>                              Object Evaluation Helpers
>     -------------------------------------------------------------------------- */
> 
> -#ifdef ACPI_DEBUG
> +#ifdef ACPI_DEBUG_OUTPUT
>  #define acpi_util_eval_error(h,p,s) {\
>  	char prefix[80] = {'\0'};\
>  	acpi_buffer buffer = {sizeof(prefix), prefix};\
> --- linux-20020930-175132/drivers/acpi/scan.c.orig	Tue Oct  1 06:29:08 2002
> +++ linux-20020930-175132/drivers/acpi/scan.c	Tue Oct  1 06:29:21 2002
> @@ -584,7 +584,7 @@
> 
>  void acpi_device_get_debug_info(struct acpi_device * device, acpi_handle handle, int type)
>  {
> -#ifdef CONFIG_ACPI_DEBUG
> +#ifdef ACPI_DEBUG_OUTPUT
>  	char		*type_string = NULL;
>  	char		name[80] = {'?','\0'};
>  	acpi_buffer	buffer = {sizeof(name), name};
> @@ -618,7 +618,7 @@
>  	}
> 
>  	pr_debug("Found %s %s [%p]\n", type_string, name, handle);
> -#endif /*CONFIG_ACPI_DEBUG*/
> +#endif /*ACPI_DEBUG_OUTPUT*/
>  }
> 
>  static void acpi_device_attach(struct acpi_device * device, struct acpi_device * parent)
> 
> -- 
> Greetings
> 
> Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
> 56 69 73 69 74				http://www.zabbadoz.net/
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: DEDICATED SERVERS only $89!
> Linux or FreeBSD, FREE setup, FAST network. Get your own server 
> today at http://www.ServePath.com/indexfm.htm
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Physikalische Grundpraktika - Heinrich-Heine Universitaet Duesseldorf
Raum 25.33.01.63  -   Universitaetsstrasse 1   -  D-40225 Duesseldorf
fon: +49-211-81-11314                           fax: +49-211-81-13105











-------------------------------------------------------
This sf.net email is sponsored by: DEDICATED SERVERS only $89!
Linux or FreeBSD, FREE setup, FAST network. Get your own server 
today at http://www.ServePath.com/indexfm.htm
