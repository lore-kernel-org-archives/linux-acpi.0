From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: Patching 2.6.9 for custom DSDT
Date: Sat, 23 Oct 2004 23:01:43 +0200 (IST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0410232300340.30630-100000@nova.cs.tau.ac.il>
References: <8d158e1f041022020763faf71a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8d158e1f041022020763faf71a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Fri, 22 Oct 2004, Patrick Ale wrote:

> Good morning all!
> 
> I'd like to try the custom Acer Aspire 1703 DSDT found on the acpi.sf.net site.
> 
> in drivers/acpi/osl.c I see the folloiwing
> 
> #ifdef CONFIG_ACPI_CUSTOM_DSDT
> #include CONFIG_ACPI_CUSTOM_DSDT_FILE
> #endif
> 
> 
> Does this mean I can add the following to the top of the c file?
> 
> #define CONFIG_ACPI_CUSTOM_DSDT_FILE "/path/to/dsdt.file"
> #define CONFIG_ACPI_CUSTOM_DSDT
> 

You can do that (thats what I do).

I think though that there should be a menu item in make config if this is 
already in the source.

> Or do I need the kernel patch mentioned on
> http://acpi.sourceforge.net/wiki/index.php/HowToOverrideTable
> 
> In the later case I have a problem since I get the following error
> when applying the patch:
> juliana:/usr/src/linux-2.6.9# patch -p1 -i ../osl.diff
> patching file drivers/acpi/osl.c
> patch: **** malformed patch at line 21: }
> 
> 
> Thanks in advance for the replies :D
> 
> Patrick
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
