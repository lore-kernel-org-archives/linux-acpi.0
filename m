From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: RE: ACPI  question
Date: Mon, 12 May 2003 14:17:11 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0305121413350.12701@dynast.gaugusch.at>
References: <CD08F83C0FFD554CBE4D42ABADAC140904A260@tpeex03.intranet.compal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CD08F83C0FFD554CBE4D42ABADAC140904A260-264r6xcw3CrbFIwZ3jqLltv2kNAIRLhc@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Dear Markus:
> 	I know that "shutdown -h now" or "halt" can power off well.
> S5 will be power off well in Windows XP. Can Linux do, too?
So, you would like that "echo -n 5 > /proc/acpi/sleep" does something like
"init 0"?
Then use "init 0". There was some discussion about S5 and it will be
entirely disabled on future kernels, because some people thought that
lusers will kill their machine/filesystem using it ... (although there are
100.000 other ways to kill your machine, so they could have left it the
way it is ...).

Markus
-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
