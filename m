From: Arjen Verweij <a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org>
Subject: Re: Shutting down PCI devices on suspend
Date: Sat, 11 Dec 2004 22:31:32 +0100
Message-ID: <41BB6734.5060607@student.tudelft.nl>
References: <1102779460.5984.17.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1102779460.5984.17.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew,

I asked a similar question some time ago, to figure out what is needed 
to add Wake-on-Lan support. The NIC needs to be put into D3 state, but 
this doesn't happen automagically. Currently I use pci-config from the 
scyld website to accomplish this right before powerdown.

Hopefully someone can comment on how it should work (tm), my guess is 
that device drivers need to be signalled, and hence it will only work if 
the driver supports it. I know from the ATi forum that the linux driver 
does not support this (yet).

Maybe you can use pci-config as a work around.
http://www.scyld.com/diag/index.html
ftp://ftp.scyld.com/pub/diag/pci-config.c
http://atlas.et.tudelft.nl/verwei90/nforce2/scyld/pci-config.c (mirror)
Compile with: gcc-2.95 -O pci-config.c -o pci-config

Regards,

Arjen

Matthew Garrett wrote:

>The default PCI suspend/resume calls (used if the driver doesn't
>implement them itself) don't alter the device power state. This seems to
>cause problems on some Thinkpads - going into S3 doesn't seem to result
>in the on-board Radeon being put into D3, and as a result the battery is
>drained at a higher rate than it should be. Who should be responsible
>for making sure that devices are properly put to sleep:
>
>1) The drivers (not immensely helpful in the case where we don't
>necessarily have drivers registered for every device)
>2) The kernel
>3) The hardware itself?
>
>I seem to remember someone mentioning something about Linux not checking
>for hints from the hardware as to what state devices should be put in,
>but I know little about this.
>  
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
