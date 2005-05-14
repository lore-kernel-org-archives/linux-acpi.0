From: Manuel J.Galan <mjgalan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Whait is CFGD for?
Date: Sat, 14 May 2005 02:17:31 +0000 (UTC)
Message-ID: <loom.20050514T041524-961@post.gmane.org>
References: <42820E57.7030309@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

DJAX <djax@...> writes:

> 
> Hello,
> I got an Acer Aspire 1694WLMi with bios 3c25.
> I try to fix the DSDT, but  I don't how to correct the last errors.
> The compiler tell me about an object CFGD that doesn't exist, but I
> don't know how and where to declare it and with  which value to
> initialise it.
> 
> Can you help me?
> 
> Thank you
> Didier
> 

Try this diff:
============================
--- dsdt.20050509.custom.dsl.orig       2005-05-14 03:12:47.000000000 +0100
+++ dsdt.20050509.custom.dsl    2005-05-14 03:13:20.000000000 +0100
@@ -209,6 +209,7 @@
     Name (\CTYP, 0x00)
     Name (\L01C, 0x00)
     Name (\INSX, 0x00)
+    External (CFGD)
     Method (\_PIC, 1, NotSerialized)
     {
         Store (Arg0, GPIC)
============================



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
