From: Dominik Brodowski <devel-JhLEnvuH02M@public.gmane.org>
Subject: Re: Failure w/ latest ACPI patch...
Date: Tue, 30 Jul 2002 16:54:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730165433.A1445@brodo.de>
References: <20020729210341.B11837@tarnation.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020729210341.B11837-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>; from prothonotar-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org on Mon, Jul 29, 2002 at 09:03:41PM -0400
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Aaron Gaudio <prothonotar-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Cc: Linux ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

Intersting problem you're reporting here:

On Mon, Jul 29, 2002 at 09:03:41PM -0400, Aaron Gaudio wrote:
> I notice that in the acpi-patched version, there is some (possibly
> BIOS?) message before the actual dmesg output gets printed
Even before "uncompressing kernel...." ??? 

, and
> for at least one of those devices for which an IRQ is not found, it
> says it will use IRQ 255.
That's BAD. IRQ 255 does not exist on any known laptop, I dare to say. 

> Unfortunately, because the boot sequence does not complete, I don't
> have the output of dmesg available for the failed boot (I can always
> attach one for the RH-based kernel, if anyone would like to see that).
Could you pass pci=noacpi to the ACPI kernel, and try if it boots, please?

Dominik


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
