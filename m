From: Cristiano De Michele <demichel-rI6Jj+0/M9+onA0d6jMUrA@public.gmane.org>
Subject: gcc-3.3: I can't compile latest acpi patches
Date: 26 May 2003 11:18:39 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1053940718.1761.5.camel@piro>
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
List-Id: linux-acpi@vger.kernel.org

Hi,
I tried to compile linux-2.4.21-rc3+acpi-2.4.21rc3 using gcc-3.3
but I get following error during compilation:

acpiphp_glue.c: In function `find_host_bridge':
acpiphp_glue.c:815: warning: passing arg 2 of
`acpi_get_object_info_R4d2dc830' from incompatible pointer type
acpiphp_glue.c:821: error: subscripted value is neither array nor
pointer
acpiphp_glue.c:826: error: incompatible type for argument 1 of `strcmp'

no problem I had with -rc2 or with gcc-2.95...

best regards
Cristiano

---
Cristiano De Michele <demichel-rI6Jj+0/M9+onA0d6jMUrA@public.gmane.org>
Department of Physics, University of Naples "Federico II"


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
