From: Andrew Ross <aross-ncau/BB9MAPvnOemgxGiVw@public.gmane.org>
Subject: Re: Video toggle button hang, Fn+F4 on Compaq Evo N1005v.
Date: Tue, 20 Jul 2004 21:36:02 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1090323362.7894.3.camel@localhost>
References: <200407191808.10728.cbackstrom@chemist.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200407191808.10728.cbackstrom-TTD55EFobGVBDgjK7y7TUQ@public.gmane.org>
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

On Tue, 2004-07-20 at 02:08, Christer Backstrom wrote:
> I got this video-out toggle button Fn-F4 on my Evo, which totally hang my 
> lappy if I use it, no messages and no serial console, no difference if I got 
> something connected or not. I've been looking round on the web for the 
> solution to this, and found patches for ignoring ff buttons and correcting 
> the dsdt, but no go. And Compaq of course gives me the old "Linux is not 
> supported" yadi-yadi-yada. I was wondering if anyone has suggestions for 
> howto debug this? And to be honest, I'm not even sure this is a ACPI problem, 
> but everything else seems to be ACPI controlled. I've seen others complaining 
> about exactly the same problem on the Presario900 list (pretty much the same 
> computer).

Interesting that you never came across the much publicised solution to
this problem (perhaps your searches were too specific). Try disabling
uniprocessor apic, either via a boot time option as suggested by Karol
Kozimor, or in the kernel config itself. The kernel config option is
CONFIG_X86_UP_APIC

Let us know if that works

Cheers

Andrew



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
