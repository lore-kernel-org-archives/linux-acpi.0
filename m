From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: Wakeup code way too big
Date: Wed, 12 Feb 2003 15:41:58 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030212154158.GA32406@clara.net>
References: <3E451DDA.7010309@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E451DDA.7010309-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: VOLTZ st?phane <svoltz-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

VOLTZ st?phane [svoltz-39ZsbGIQGT5GWvitb5QawA@public.gmane.org] wrote:
>        while booting 2.5.59, I got the following message :
> ACPI: Wakeup code way too big, will crash on attempt to suspend

2.5.60 same message, Sony GRX516MD.

>        I added some printk to arch/i386/kernel/acpi.c in
> acpi_reserve_bootmem() to get wakeup_end and wakeup_start values, and I got:
> 
> ACPI: have wakeup address 0xc0001000
> ACPI: have wakeup_end     0x00000000
> ACPI: have wakeup_start   0xffffffb8

I have an identical wakeup address, haven't put the printks in yet, but
I bet they're the same too :)

I don't think there's that many bytes from ffffffb8 to 100000000
Perhaps that's the problem?

I see a couple of patches about wakeup, so I'll apply those first.

I'm very interested in getting suspend working.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

Never be led astray onto the path of virtue.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
