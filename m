From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Wed, 31 Jul 2002 12:41:21 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020731184124.316.qmail@scrye.com>
References: <200207311758.NAA21154@fort-point-station.mit.edu>
	<200207311811.OAA25369@buzzword-bingo.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200207311811.OAA25369-UwFBHNxiom0K2f9UKZ/Dkzyo3AZ8UMn9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Sourav" == Sourav K Mandal <Sourav> writes:

>> Does anyone have a working (or at least more than the default) DSDT
>> they could send me?

Sourav> I don't have my laptop with me, but I just did the following
Sourav> text substitutions (using sed) on the ASL DSDT:

Sourav> "*PNP" -> "PNP" (per Christoph) "C11C" -> "BAT1" "C11B" ->
Sourav> "BAT2" "C11A" -> "ACAD" (I'm not sure about this one -- check
Sourav> your /proc/acpi/ac_adapter dir first)

well, I did that, but then iasl gives me: 

iasl-linux-20020725/iasl -tc -bb -i dsdt.asl-new

Intel ACPI Component Architecture
ASL Compiler / AML Disassembler version 20020725 [Jul 25 2002]
Copyright (C) 2000 - 2002 Intel Corporation
Supports ACPI Specification Revision 2.0a

dsdt.asl-new     1: 
Error   1037 -         ^ parse error, expecting `error' or `PARSEOP_DEFINITIONBLOCK'

ASL Input: dsdt.asl-new - 1 lines, 4 bytes, 0 keywords
AML Output: dsdt.aml - 0 bytes 0 named objects 0 executable opcodes

Compilation complete. 1 Errors 0 Warnings

The top of the dsdt.asl I get is:

RSDP "COMPAQ" @ 0x000f9970
  0000: 52 53 44 20 50 54 52 20 82 43 4f 4d 50 41 51 00  RSD PTR .COMPAQ.
  0010: 84 0c ff 0f                                      ....

RSDT @ 0x0fff0c84
  0000: 52 53 44 54 30 00 00 00 01 08 43 4f 4d 50 41 51  RSDT0.....COMPAQ
  0010: 43 50 51 30 30 34 41 20 20 02 05 31 43 50 51 20  CPQ004A  ..1CPQ 
  0020: 01 00 00 00 00 0c ff 0f c3 64 ff 0f d1 65 ff 0f  .........d...e..

FACP @ 0x0fff0c00
  0000: 46 41 43 50 84 00 00 00 02 42 43 4f 4d 50 41 51  FACP.....BCOMPAQ
  0010: 43 50 51 30 30 34 41 20 02 00 00 00 43 50 51 20  CPQ004A ....CPQ 
  0020: 01 00 00 00 80 be ff 0f b4 0c ff 0f 00 00 09 00  ................
  0030: b2 00 00 00 f1 f0 00 80 00 10 00 00 00 00 00 00  ................
  0040: 04 10 00 00 00 00 00 00 20 10 00 00 08 10 00 00  ........ .......
  0050: 28 10 00 00 2c 10 00 00 04 02 01 04 04 04 10 00  (...,...........
  0060: 02 00 55 00 00 00 00 00 01 03 0d 00 32 03 00 00  ..U.........2...
  0070: a5 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00                                      ....

DSDT @ 0x0fff0cb4
  0000: 44 53 44 54 0f 58 00 00 01 45 43 4f 4d 50 41 51  DSDT.X...ECOMPAQ
  0010: 45 56 4f 4e 38 30 30 00 00 00 01 00 4d 53 46 54  EVON800.....MSFT
  0020: 0d 00 00 01 5b 83 33 5c 2e 5f 50 52 5f 43 30 30  ....[.3\._PR_C00
  0030: 30 01 10 10 00 00 06 14 21 5f 43 53 54 00 a0 13  0.......!_CST...
  0040: 93 5c 2e 5f 53 42 5f 43 30 30 31 0a 00 a4 43 30  .\._SB_C001...C0
...

Is this the wrong format from acpidmp? 

>> Software suspend seems to work well...

Sourav> It was working well until I fixed my DSDT!

Are you using the acpi-swspend patch? I am using the
patch-acpi-acpi20020726-swsusp11.gz patch.

>> The DRI patch seems to work great on it as well, so it can chvt
>> away from X, echo 4 > /proc/acpi/sleep and suspend, and comes back
>> ok. Great work on that!

Sourav> Interesting that you have a /proc/acpi/sleep entry; I don't.
Sourav> I've been using "echo -n '1 0 0' > /proc/sys/kernel/swsusp".
Sourav> It just occurs to me that I should turn on the debugging bits
Sourav> and see if I can understand what's wrong ...

yeah, I think thats due to the acpi-swspend patch? 

>> With the default acpi-20020726 I get temp readings, but it says ac
>> is always on, and battery doesn't give any info at all.

Sourav> This should be repaired once you tweak the DSDT.

ok. 

Sourav> Please report back how it goes -- I'm using the 20020709
Sourav> series of patches on kernel 2.4.18, so if everything works out
Sourav> for you I might upgrade to 20020726.

ok. 

Sourav> Sourav

kevin

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE9SC9U3imCezTjY0ERAkMMAJ0fiBIsRCmE8Q8Og+y1DfG0F5KijgCggyuA
Ft+Lz/ojPwbX+tYu2ZTWGCY=
=W7qf
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
