From: Nico Sabbi <nsabbi-IWqWACnzNjyonA0d6jMUrA@public.gmane.org>
Subject: Re: 2.6 won't poweroff
Date: Tue, 25 May 2004 10:59:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40B30AEC.5020806@tiscali.it>
References: <20040525044514.GC2217@smeagol> <16563.119.414292.134855@aber.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16563.119.414292.134855-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
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

Fred Labrosse wrote:

>Emma Jane Hogbin writes:
> > I have two big irritants for the 2.6.5/2.6.6 (patched for ACPI) kernels 
> > with ACPI. 
> > 
> > 	1. My computer no longer powers off. acpi_power_off is called, but the
> > 	computer doesn't actually turn itself off. In fact when I use
> > 	"poweroff" directly I get a message flashing across my screen saying:
> > 		syntax error on 658 of stdin
> > 
>
>Sorry, no solution, but exactly the same problem with an Acer TM636
>(although I don't have any syntax error, only "power down").
>
>This is a really annoying problem, even dangerous for the laptop as it
>sometimes, randomly, "shuts down" because of the erratic temperature
>reading but doesn't power off so stays there, still powered, still heating
>but not cooling down (fan off)...
>
>I did try various combinations (APIC off, on, no compiled in, went back to
>2.4.26, 2.4.25-gentoo-r2, 2.6.4, 2.6.6-rc2(?)), to no avail.  It used to
>work fine when I was running RH8 with (I think) 2.4.24 (I now run gentoo).
>
>Any suggestions would be more than appreciated.
>
>TIA,
>
>Fred
>
>
>  
>

same unresolved problem; the only way to shut down my Abit motherboard 
in this case is to use
AltGR-Sysrq-O, which first repeats for the second time "acpi_power_off 
called" and then
finally shuts down the pc.

Is there a way to make poweroff *really* power-off ?

Thanks,
       Nico



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
