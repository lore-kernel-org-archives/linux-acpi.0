From: "Wilkinson, Alex" <alex.wilkinson-7BNmJD1m9TP299njBJCvBrpzq4S04n8Q@public.gmane.org>
Subject: Re: ACPI; S5 state; powerbutton->clean shutdown
Date: Mon, 10 Jan 2005 13:40:09 +1030
Message-ID: <20050110031008.GD24291@squash.dsto.defence.gov.au>
References: <20050107005652.GA17647@squash.dsto.defence.gov.au>
    <1105061056.8674.91.camel@tyrosine>
    <20050107013051.GF17647@squash.dsto.defence.gov.au>
    <1105101993.8674.104.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1105101993.8674.104.camel@tyrosine>
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

    0n Fri, Jan 07, 2005 at 12:46:33PM +0000, Matthew Garrett wrote: 

    >On Fri, 2005-01-07 at 12:00 +1030, Wilkinson, Alex wrote:
    >>     0n Fri, Jan 07, 2005 at 01:24:16AM +0000, Matthew Garrett wrote: 
    >
    >>     >Linux has no in-kernel policy for acpi events. The userspace acpid (SuSE
    >>     >have something with a different name) receives the events and can be
    >>     >configured to do anything in response.
    >> 
    >> man page ?
    >> Tool to disassemble DSDT into ASL ?
    >
    >I'm not quite sure what you're asking. You can check if the power button
    >will generate an ACPI event by checking whether it's present
    >in /proc/acpi/buttons/ - you shouldn't need to touch the DSDT. acpid
    >seems to have a manpage. Intel's ACPI compiler includes a disassemble
    >option.

Ok, thanks. I have a RH 9.0 (2.4.20-8smp) that does not have ACPI
support. Do 2.4 kernels support ACPI ?

If not, is it possible to configure a 2.4 system to do a clean shutdown
upon a power button  press ?

Cheers

  - aW


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
