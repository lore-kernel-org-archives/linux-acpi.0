From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ACPI hangs on boot with ACER Travelmate 3002WTCi
Date: Thu, 11 Aug 2005 18:31:04 +0200
Message-ID: <42FB7D48.5020008@suse.de>
References: <30543d6b050811090060039664@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <30543d6b050811090060039664-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bao Tran <bqtran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Bao Tran wrote:
> First off, just wanted to say thanks for everything so far.
> 
> Secondly, I just got an Acer Travelmate 3002wtci, and the first thing
> I did was rip out the hard drive and tried to put linux on it.  I've
> had it for a couple of days now, and I've gotten most of it working,
> but I noticed that if ACPI support is enabled on any of my kernels
> (currently running mm-sources 2.6.13-rc5-mm1), the computer will hang
> right after I press enter in grub, showing up no messages and giving
> me a blank black screen.
> 
> I am thinking like most Acer laptops, it has a buggy DSDT and ECDT
> problems, so I've considered fixing it, but I can't even run a cat
> /proc/acpi since acpi has to be disabled in order to boot, so I am
> stuck.
> 
> I would post technical specs, but I am currently at work. I will post
> more when I get home,but for now, here is what i remember off the top
> of my head:
> 
> ACPI "compliant" 1.0b
> PhoenixBIOS
> Winbond (Nat Semi) PC87591 sensor
> Pentium M 740 (1.73 GHz)
> ICH6 Controller (i2c-i801 + eeprom loaded)
> 
> 
> Is there anything I can do to diagnose/fix the problem more?
> 
Have you tried:
noapic
pci=noacpi
options?
If it comes up you can have a look at your DSDT.

early_printk=vga
could give you a hint where it hangs.

     Thomas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
