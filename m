From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Fwd: [PATCH] Don't save state in ACPI on shutdown/reboot]
Date: Tue, 11 Nov 2003 18:00:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031111170035.GD29175@poupinou.org>
References: <1068567824.24982.21.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1068567824.24982.21.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 11, 2003 at 11:23:44AM -0500, Len Brown wrote:
> 

Content-Description: Forwarded message - [PATCH] Don't save state in ACPI on shutdown/reboot
> From: Andi Kleen <ak-h9bWGtP8wOw@public.gmane.org>
> To: marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, len.brown@intel.com
> Subject: [PATCH] Don't save state in ACPI on shutdown/reboot
> X-Scanned-By: MIMEDefang 2.31 (www . roaringpenguin . com / mimedefang)
> X-OriginalArrivalTime: 11 Nov 2003 13:15:03.0923 (UTC)
> 	FILETIME=[D1A1BC30:01C3A855]
> 
> 
> The ACPI code in 2.4 currently saves the machine state as for a 
> suspend when doing an reboot or shutdown. This fails on x86-64
> on some boxes.
> 
> Don't save/restore state in ACPI when entering S5.

That break also some i386 boxes.  That why I submitted another patch (do
I have to post it again?)

> 
> -Andi
> 

...

> @@ -127,6 +128,7 @@
>  		 * interrupts.
>  		 */
>  #ifdef CONFIG_X86
> +		/* AK: this looks rather broken in APIC mode */
>  		init_8259A(0);

I know.  In fact, this may be not sufficiant for PIC mode
as well.


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
