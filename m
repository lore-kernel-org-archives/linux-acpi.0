From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] warning: implicit declaration of function mp_config_ioapic_for_sci
Date: Tue, 8 Oct 2002 12:59:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021008125912.Q18545@parcelfarce.linux.theplanet.co.uk>
References: <1034060159.1541.24.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1034060159.1541.24.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>; from sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org on Tue, Oct 08, 2002 at 02:55:57AM -0400
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 08, 2002 at 02:55:57AM -0400, Sérgio Monteiro Basto wrote:
> +++ linux-2.4.19acpi/include/asm-i386/mpspec.h	Sun Oct  6 21:34:06 2002
                               ^^^^^^^^
> +#ifdef CONFIG_X86
> +extern void mp_config_ioapic_for_sci(int irq);
> +#endif /*CONFIG_X86*/

you really don't need to encase this in CONFIG_X86.  if it's in asm-i386
and some other cpu type is including this file, things are already
hideously wrong.

-- 
Revolutions do not require corporate support.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
