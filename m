From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: ACPI; S5 state; powerbutton->clean shutdown
Date: Fri, 07 Jan 2005 12:46:33 +0000
Message-ID: <1105101993.8674.104.camel@tyrosine>
References: <20050107005652.GA17647@squash.dsto.defence.gov.au>
	 <1105061056.8674.91.camel@tyrosine>
	 <20050107013051.GF17647@squash.dsto.defence.gov.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050107013051.GF17647-670g5dPm81kHVWjHP2o3SMhQixhbPYnYEK66K81epY8@public.gmane.org>
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

On Fri, 2005-01-07 at 12:00 +1030, Wilkinson, Alex wrote:
>     0n Fri, Jan 07, 2005 at 01:24:16AM +0000, Matthew Garrett wrote: 

>     >Linux has no in-kernel policy for acpi events. The userspace acpid (SuSE
>     >have something with a different name) receives the events and can be
>     >configured to do anything in response.
> 
> man page ?
> Tool to disassemble DSDT into ASL ?

I'm not quite sure what you're asking. You can check if the power button
will generate an ACPI event by checking whether it's present
in /proc/acpi/buttons/ - you shouldn't need to touch the DSDT. acpid
seems to have a manpage. Intel's ACPI compiler includes a disassemble
option.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
