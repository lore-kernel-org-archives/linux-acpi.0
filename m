From: Franklin Marmon <marmon-a4VQZhDi8cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Starting AML
Date: Thu, 29 Apr 2004 15:59:32 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1083275971.4976.67.camel@laptop.hydeco.com>
References: <20040429192133.GI28420@gaspode.nextlink.co.za>
Reply-To: marmon-a4VQZhDi8cxBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040429192133.GI28420-beYWCVBHuyQmjp9Ioln+9+7fARiR49SZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm pretty new to ACPI in general, but I might recommend reading chapter
11 of the spec.  It lays out in detail what parts of the code you should
be looking in.  If your not familiar with the layout of the asm itself,
I'm not sure where to point you, but someone else probably is.  I just
read the first few chapters of the spec and 'logiced' out the rest,
which will likely result in a broken system in my case, but that remains
to be seen.

You will likely be looking at the _BIF method of your battery device. 
This is the method that returns (by the spec anyway) static information
about your battery, including the design voltage. The battery device
name is different depending on your hardware, but is fairly easy to find
if you search for "_BIF" in the aml.

As far as debugging the DSDT, not a clue.  I'm pretty sure you can't use
kernel calls within the DSDT asm code.  So, my best guess if your sure
your DSDT is wrong is to correct the changes, compile it into the
kernel, and re-check your /proc/acpi/... data.

frm



On Thu, 2004-04-29 at 13:21, Thomas Andrews wrote:
> Hi Everyone,
> 
> I want to try to understand how to debug my DSDT properly, so I'd
> appreciate some hints for debugging. I've started reading through the
> ACPI specification available at http://www.acpi.info/spec.htm
> 
> Firstly, how do I find out in the AML where the relevant pieces of code
> are ? For example, the battery voltage reported is wrong; how do I figure
> out which bits to edit ?
> 
> Secondly, how can I output debugging messages ? Is there some way I can
> use something like printf/printk ?
> 
> I have already fixed the "syntax errors" produced by compiling the
> original BIOS DSDT. That didn't fix anything BTW.
> 
> I have also read the (very helpful) docs and howtos on SF. Thanks.
> The laptop is a Compaq Evo N150, for which there seem to be no fixes
> made public.
> 
> Many thanks,
> Thomas
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
