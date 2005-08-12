From: Bao Tran <bqtran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hangs on boot with ACER Travelmate 3002WTCi
Date: Thu, 11 Aug 2005 22:54:00 -0500
Message-ID: <30543d6b050811205474e45db3@mail.gmail.com>
References: <30543d6b050811090060039664@mail.gmail.com>
	 <42FB7D48.5020008@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42FB7D48.5020008-l3A5Bk7waGM@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Preliminary Results:

early_printk didn't work, but both noapic or pci=3Dnoacpi worked.

I've been able to fix the DSDT completely for this laptop (0 errs, 0
warn, 0 rem, 883 opt), and compiled it with iasl 20050309 (the latest
ver gave me a lot of missing Resource String errs for some reason). I
will be posting it to the dsdt db shortly. Thanks a lot for the hints.

One note that I still had trouble booting even with a fixed DSDT and
had to use 'acpi=3Dnoirq', or if I wanted to use the 'noapic' setting, I
had to add 'irqpoll' also or else peripherals like the nic would
refuse to work properly. My guess is that this laptop still has
firmware issues with irq.

In the mean time, from what I can tell, it detects *everything* (APIC
LAPIC HPET PCI0 ELCR EC0 ACAD BAT1 PWRF LID PWRB SLPB CPU0 USB* RP0*
LANC AZAL GFX0 C* S* THRM).

Anyway, back to more laptop hacking. This 3lb laptop rocks once acpi
starts working its magic. ^_^

bao

On 8/11/05, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org> wrote:
> Bao Tran wrote:
> > First off, just wanted to say thanks for everything so far.
> >
> > Secondly, I just got an Acer Travelmate 3002wtci, and the first thing
> > I did was rip out the hard drive and tried to put linux on it.  I've
> > had it for a couple of days now, and I've gotten most of it working,
> > but I noticed that if ACPI support is enabled on any of my kernels
> > (currently running mm-sources 2.6.13-rc5-mm1), the computer will hang
> > right after I press enter in grub, showing up no messages and giving
> > me a blank black screen.
> >
> > I am thinking like most Acer laptops, it has a buggy DSDT and ECDT
> > problems, so I've considered fixing it, but I can't even run a cat
> > /proc/acpi since acpi has to be disabled in order to boot, so I am
> > stuck.
> >
> > I would post technical specs, but I am currently at work. I will post
> > more when I get home,but for now, here is what i remember off the top
> > of my head:
> >
> > ACPI "compliant" 1.0b
> > PhoenixBIOS
> > Winbond (Nat Semi) PC87591 sensor
> > Pentium M 740 (1.73 GHz)
> > ICH6 Controller (i2c-i801 + eeprom loaded)
> >
> >
> > Is there anything I can do to diagnose/fix the problem more?
> >
> Have you tried:
> noapic
> pci=3Dnoacpi
> options?
> If it comes up you can have a look at your DSDT.
>=20
> early_printk=3Dvga
> could give you a hint where it hangs.
>=20
>      Thomas
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
