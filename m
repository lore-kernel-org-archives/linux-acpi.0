From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ACPI trouble in SHG 4000 notebook
Date: Thu, 06 Oct 2005 19:18:12 +0200
Message-ID: <43455C54.5040309@suse.de>
References: <62093.84.48.53.145.1128599474.squirrel@84.48.53.145>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <62093.84.48.53.145.1128599474.squirrel-Eqzx7D6fnAkrTD4VUCDH0w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: foolish-joSiycWv2dg+3ClZCHpbBg@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

foolish-joSiycWv2dg+3ClZCHpbBg@public.gmane.org wrote:
> 
> Forgot the dmesg output, here it is.
> 
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0, disabled.
> ACPI: PCI Interrupt Link [ALKB] (IRQs 23) *11
> ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *5, disabled.
>     ACPI-0229: *** Error: Return object type is incorrect [\_SB_.PCI0.ALKD._CRS] (Node f7ecdee0), AE_TYPE
> ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *0
> Linux Plug and Play Support v0.97 (c) Adam Belay

This probably can be fixed by overwriting/evaluating your DSDT. Can you also 
send me acpidmp ouput, please.

    Thomas


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
