From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP
 systems
Date: Wed, 02 Jul 2008 23:44:09 -0600
Message-ID: <486C6729.4020903@shaw.ca>
References: <fa.OuKI5CNmq3HqeBQCfWOUtrq4+oA@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-reply-to: <fa.OuKI5CNmq3HqeBQCfWOUtrq4+oA@ifi.uio.no>
Sender: linux-next-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ingo Molnar <mingo@elte.hu>, Matthew Garrett <mjg59@srcf.ucam.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Maciej W. Rozycki wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
>  Some HP laptops have a problem with their DSDT reporting as
> HP/SB400/10000, which includes some code which overrides all temperature
> trip points to 16C if the INTIN2 input of the I/O APIC is enabled.  This
> input is incorrectly designated the ISA IRQ 0 via an interrupt source
> override even though it is wired to the output of the master 8259A and
> INTIN0 is not connected at all.  So far two models have been identified, 
> namely nx6125 and nx6325.
> 
>  Use a knob provided by the I/O APIC interrupt registration code to
> abandon any attempts to route IRQ 0 through the I/O APIC for these
> systems.

Just a thought.. has anyone recently looked into using the RTC timer 
instead of the PIT as the default clockevent source? There still seem to 
be systems like these seeping through with broken PIT through IOAPIC 
since Windows apparently doesn't use that config at all. If we could use 
the RTC instead (which is apparently what Windows does) we could avoid 
that problem.

The last I read on the subject, the issue was that the RTC timer 
frequencies didn't match the existing Linux HZ values, but I'm not sure 
if that's still an issue with the current clockevents infrastructure..
