From: Alimin Bijosono Oei <alimin-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>
Subject: Re: dsdt patch
Date: Wed, 04 Feb 2004 01:40:42 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <401FB2EA.7000304@ihug.com.au>
References: <3ACA40606221794F80A5670F0AF15F8401CBB674@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB674-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Yu, Luming wrote:
>>Just want to ask where can I find a patch that will allow me 
>>to use my 
>>own dsdt for kernel 2.4.24? 
> 
> 
> Can you let me know what exact error need be fixed in DSDT?
> 
> 

I am using a Compaq Presario 1500AP notebook and so far I have been 
using the fixed dsdt of Compaq EVO N1000V and it works just fine. The 
only problem I have was that I upgrade from kernel 2.4.22 to 2.4.24 and 
I can't find any patch for 2.4.24 that will allow me to patch osl.c so 
that I can implement the fixed dsdt. When using 2.4.22 before, I got a 
patch for osl.c from 
http://cabibbo.physics.wm.edu/~bryan/computer/dsdt.patch_2.4.22
The author was using Dell Inspiron, but the patch works for me.





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
