From: Jarkko Laiho <acpi.50.lifeless-w1QkCcy0X+BxKfgMtfWJuA@public.gmane.org>
Subject: dmesg: AE_BAD_CHARACTER, no /proc/acpi on ASRock 939S56-M
Date: Wed, 04 Jan 2006 19:48:59 +0200
Message-ID: <43BC0A8B.50704@spamgourmet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

(My e-mail address is a redirecting spamcatcher, in case you're 
wondering... zero spam to my real inbox in three years, and I like to 
keep it that way ;-))

I'm experiencing a very strange ACPI problem with my new motherboard, 
and no amount of googling has helped so far. It's an ASRock 939S56-M, 
with a SiS765/965L chipset and a Socket 939 AMD64 3500+ processor. It 
has an AMI BIOS, updated to the latest version (1.40).

I'm running a Gentoo system with the kernel.org "vanilla" sources 
(2.6.15-rc7). I've got ACPI support compiled in (URL to kernel config 
below).

The machine boots fine and all the peripherals seem to work. However, 
/proc/acpi does not exist, and the dmesg output contains related errors 
(AE_BAD_CHARACTER; URL to complete listing below). This even though the 
DSDT has been compiled with the Intel compiler. Thus, loading the ACPI 
tables fails. Still, I don't understand how this would cause /proc/acpi 
to just not appear at all.

I don't have the necessary knowledge to properly diagnose, let alone 
debug this problem, so I'll turn this over to the experts. What 
particularly baffles me about this problem is that I got the exact same 
error message with a previous motherboard for the same CPU, an Asus 
A8N-VM CSM, which has an nForce430 chipset and an AMI BIOS. I sold it 
and switched to the ASRock for better Linux support (which it has, 
except for ACPI). Back then I had the 2.6.14.3 kernel with the gentoo 
patchset. The only thing connecting the two boards (that I know of) is 
that the BIOS is made by AMI.

I've dumped the DSDT using acpidump (URL below). Trying to decompile it 
with iasl -d DSDT produces a file, DSDT.dsl, with the following contents 
and nothing else (delimiting lines added by me, naturally):

-------------

nssearch-0407: *** Error: NsSearchAndEnter: Bad character in ACPI Name: 
43045350
  dswload-0393: *** Error: Looking up [0x43045350] (NON-ASCII)
  in namespace, AE_BAD_CHARACTER
Could not parse ACPI tables, AE_BAD_CHARACTER

-------------

With iasl producing this instead of the decompiled output, I haven't 
gotten any further with actually debugging things.

Here are the promised URLs to the various debugging information:


Kernel configuration:
http://elamaton.no-ip.com/acpi/conf-2.6.15-rc7

dmesg output (a row or two is missing from the top, I don't know why it 
does that):
http://elamaton.no-ip.com/acpi/dmesg

DSDT (with acpidump -t DSDT -b -o DSDT):
http://elamaton.no-ip.com/acpi/DSDT

Complete ACPI dump (with acpidump -o acpidump.out):
http://elamaton.no-ip.com/acpi/acpidump.out


If someone could help me in any way, I'd really appreciate it. If more 
debugging info is needed, tell me what to get and I'll provide it.

TIA!

Jarkko Laiho
Finnish Gentooist
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
