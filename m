From: Rob North <tzwvgwv2001-O/bDAPVd7B0N+BqQ9rBEUg@public.gmane.org>
Subject: Re: ACPI ignoring IRQ flags in PRT
Date: Mon, 14 Jul 2003 12:07:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <beu2rr$j1h$1@main.gmane.org>
References: <F760B14C9561B941B89469F59BA3A8470255EE87@orsmsx401.jf.intel.com> <200307140951.18569.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307140951.18569.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
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

Andrew de Quincey wrote:
>>Great to see someone's digging into this. BTW have you looked at the
>>ACPI 2.0 spec section 6.2.8? It talks about the contents of _PRT.
>>Basically, it can contain either the interrupt number itself OR point to
>>a link device, which in turn lets ACPI read (via _CRS) write (via _SRS)
>>and see the possiblities (_BRS) for controlling the interrupt routing
>>for that device.
>>
>>The code *should* be handling both these cases, but obviously there are
>>still some bugs lurking.
> 
> 
> I think its handling both cases OK, its just that it was ignoring the polarity 
> and mode settings for link device IRQs.
> 
> What I was wondering was if/where these settings were for global IRQs... i.e. 
> when the _PRT contains the actual interrupt number, what settings should be 
> used.
> 
> I suppose since its the PCI routing table, it might just expect you to default 
> to PCI settings, but as I found link-device IRQs specified in the PRT don't 
> necessary follow the PCI standard... problem is, my board doesn't specify 'em 
> in this way.

Yes, I assumed that global IRQs were set up with default PCI polarities:
I was assuming that there was a direct electrical connection from the
PCI bus to the APIC pins in the global IRQ case.

As you have decompiled you ACPI table maybe you should look for
Interrupt definitions in strange places. i.e. outside link devices?

Might there also be a default polarity specified in the APIC defintions?
(Or after looking at the spec, might APICs with you APIC ID have 
interupt polarities reverse of "normal" APICS?)






-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
