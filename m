From: "J.A. Magallon" <jamagallon-cer70A47DaU@public.gmane.org>
Subject: Re: Linux 2.4.23-rc4
Date: Mon, 24 Nov 2003 23:01:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031124220146.GA1823__9963.61516085944$1069746253@werewolf.able.es>
References: <Pine.LNX.4.44.0311241656430.8709-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311241656430.8709-100000-IP5UegVbiV6sTnJN9+BGXg@public.gmane.org> (from marcelo.tosatti@cyclades.com on Mon, Nov 24, 2003 at 19:58:06 +0100)
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On 11.24, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> Here goes -rc4, fixing modular IDE breakage present in 2.4.23 kernels.
> 

Hey, you posted rc4 before I could talk about rc3... ;)
Good and bad news. Good are that pci=noacpi works. Bad are that
ACPI still fails to setup PCI bus 1 on a ServerWorks LE.
I think this is not a showstopper, but...
Relevant info is at

http://giga.cps.unizar.es/~magallon/linux/acpi/

dmesg for -rc3 without acpi, just what CONFIG_SMP uses, with acpi, and with
acpi but booted with pci=noacpi (all with lspci at the end), and output
from dmidecode, biosdecode and acpidmp.

I have also submited an entry in bugzilla.
For my blind eyes, it looks like an IRQ routing problem.

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.4.23-rc3-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
