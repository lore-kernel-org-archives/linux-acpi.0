From: Hrvoje Habjanic <hrvoje.habjanic-ZeoyiJGIzEM@public.gmane.org>
Subject: [PATCH] HP xw6000 - loading order of SSDT tables!!!
Date: Tue, 24 Jun 2003 19:35:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306241935.19049.hrvoje.habjanic@htnet.hr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


IS IMPORTANT!!!!!

I've modified acpi-20030424-2.4.21-rc1 and noticed that it is loading SSDT 
tables in "normal" order - tables_id are INCREMENTING ...

BUT every acpi driver after that is loading SSDT tables in DECREMENTING 
(table_id) order ... so i've made a small patch to mimic  
acpi-20030424-2.4.21-rc1 order of loading.

And that was it!!!

Andy, please verify this and i hope this will not broke some other things ...

And for  dmesg's see:
1. modified acpi-20030424-2.4.21-rc1
- http://free-zg.htnet.hr/HrvojeHabjanic/acpi/HP_xw6000-rc2-OK.2.dmesg
2. modified  acpi-20030619
- http://free-zg.htnet.hr/HrvojeHabjanic/acpi/HP_xw6000-20030619-OK.dmesg

And at the end, thanx to everyone who helped to find and fix this ... hmm ... 
bug or feature?


Hrvoje



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
