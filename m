From: Tobias Matzat <tobiasmatzat-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org>
Subject: Re: Problem with acpi and HP Compaq nx7000 laptop
Date: Fri, 21 Nov 2003 07:31:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031121073159.65e78efe.tobiasmatzat@freenet.de>
References: <3ACA40606221794F80A5670F0AF15F8401720BDC@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720BDC-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

But it seems there are only patches for the 2.6 kernel.
I will try it, but I'm currently using mainly the 2.4 kernel.

THX

On Fri, 21 Nov 2003 09:00:19 +0800
"Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> Please try latest patch at http://bugzilla.kernel.org/show_bug.cgi?id=1444   - Luming
> 
> 
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-admin@lists.sourceforge.net]On Behalf Of Tobias Matzat
> Sent: 2003?11?21? 6:05
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] Problem with acpi and HP Compaq nx7000 laptop
> 
> 
> 
> 
> Hi!
> 
> I get the following error messages from my kernel (2.4.22):
> 
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: System [ACPI] (supports S0 S3 S4bios S4 S5)
> dsopcode-0515 [20] ds_init_buffer_field  : Field size 1392 exceeds Buffer size 1296 (bits)
>  psparse-1121: *** Error: Method execution failed [\_SB_.C046.C052] (Node dffc09e8), AE_AML_BUFFER_LIMIT
>  psparse-1121: *** Error: Method execution failed [\_SB_.C046.C056] (Node dffc0ae8), AE_AML_BUFFER_LIMIT
>  psparse-1121: *** Error: Method execution failed [\_SB_.C046._CRS] (Node dffc0be8), AE_AML_BUFFER_LIMIT
>   uteval-0098: *** Error: Method execution failed [\_SB_.C046._CRS] (Node dffc0be8), AE_AML_BUFFER_LIMIT
> ACPI: PCI Root Bridge [C046] (00:00)
> 
> What do they mean and how can i fix them? Is it something dsdt-related?
> I took a look at the acpi4linux page but i found nothing related to 
> my laptop.
> 
> Please help me, i am completetly new to acpi.
> 
> Greets, Tobias
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
