From: Prabhakar Reddy Gudla Venkata Siva <reddyg-3+M4TpyeDAP2fBVCVOL8/A@public.gmane.org>
Subject: Compaq 1720US, 2.4.18, acpi-7,24 - Help
Date: Mon, 12 Aug 2002 23:02:37 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.21.0208122148460.7266-100000@sediment.umd.edu>
References: <20020812144907.30057.qmail@web11102.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020812144907.30057.qmail-2nHsiZiiNUuA/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi list,

I have compiled acpi-pacth-20020724 for kernel 2.4.18 on a compaq presario
1720US (running Red Hat 7.3). However, the acpi-patched kernel no longer
boots. I just get a blank screen on bootup. FYI, I do run some of the
earlier acpi-patched kernel.

I have done the following:

1) On a old kernel (2.4.18-5 Redhat Stock Update)
<prompt>acpidump > acpi_dsdt.asl

2)Corrected the acpi_dsdt.asl for some errors

3)Compiled the modified acpi_dsdt.asl using "iasl"
<prompt>iasl -tc acpi_dsdt.asl

4)Got the kernel 2.4.18 and applied the acpi-patch-20020724

5)Copied the acpi_dsdt.hex to /usr/src/linux/drivers/acpi/tables
<prompt> cp acpi_dsdt.hex <kernel-src>/drivers/acpi/tables/acpi_dsdt.c

6)complied the kernel with all options of ACPI as modules (I did turn off
APM options).


Is there some step that I am missing ? Do I need to change something in
the acpi code to override the new dsdt table ? Any help appreciated.

TIA
-- 

*******************************--------------**********************************
GVS Prabhakar Reddy
Research Assistant

Model Analysis Lab (GIS Lab)
Dept. of Biological Resources Engineering 
University of Maryland 
College Park, MD, 20742.

tel: 301-405-0109 (o)
   : 301-982-7148 (r)
fax: 301-314-9023

email: reddyg-0KJXeWapumv2fBVCVOL8/A@public.gmane.org
**************************--------------------*********************************



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
