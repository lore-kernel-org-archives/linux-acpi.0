From: dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org
Subject: Re: Store(Local0, Local0); Nvidia
Date: 18 Aug 2002 12:55:36 -0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020818125536.21336.qmail@mail.supereva.it>
Reply-To: dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: berberic-vmG2aq7wDA3mFSIgyKwhw7NAH6kLmebB@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,
I don't know how to fix your dsdt errors, but I can report my experience with ACPI + NVidia closed drivers.

well they work together :)

I have a TNT2 on an Asus P4S533 mb and all ACPI  options copiled in. AGP doesn't work right now so you could try to boot without agp support 
Hope this helps.

bye,
-- Mattia

>I could not get the NVidia-driver to coexist with acpi, it chrashes the machine 
>if startet with an acpi-patched kernel.
>
>The interrupts change if acpi is used:
>
>   |  with ACPI       | without ACPI ---+------------------+----------------
>16 |                  | NVidia
>17 |  EMU10k1, NVidia | EMU10k1
>18 |  eth0            | eth0
>19 |  sym53c8xx, usb  | sym53c8xx, usb
>
>I doubt this is the reason, but anyone knows fore sure?
>
>	MfG 	bmg
>
>-- 
>"Des is völlig wurscht, was heut beschlos- | M G Berberich
> sen wird: I bin sowieso dagegn!"          | berberic-vmG2aq7wDA3mFSIgyKwhw7NAH6kLmebB@public.gmane.org
>(SPD-Stadtrat Kurt Schindler; Regensburg)  |
>
>


-----------------------------------------------------
Compra e vendi su eBay: registrati gratis!
http://www.ebay.it/registrazione.html

messaggio inviato con Freemail by www.superEva.it
-----------------------------------------------------



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
