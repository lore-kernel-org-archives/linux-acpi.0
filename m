From: "A.MAINS" <armains-ZO4F0KnmCDHk1uMJSBkQmQ@public.gmane.org>
Subject: RE: problems with patch acpi-20020725 and Suse kernel
Date: Sun, 4 Aug 2002 18:35:52 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000001c23c07$4b475980$9865fea9@AMAINSLT>
References: <200208042147.g74LlHX22652@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200208042147.g74LlHX22652-pb599fR3TxVkExQqqHjIK3sFFmKitW5W@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: graik-S0/GAf8tV78@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello

I too have a SuSE kernel and tried several patches with no success.
First, if possible, I suggest getting a standard kernel. I think SuSE
already applied a patch to their sources and it needs to be removed. (I
know next to nothing about ACPI and how to modify things, I just read
and learn based on other reports). Second, if your Evo is anything like
my Presario, you will need specific Compaq Patches or edit your own DSDT
in order to have any good functionality. (This does not solve your
compiling issue though).

I hope this little bit helped. If you do find a SuSE patch, let me know
as I will be interested.

Andrew

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of
graik-S0/GAf8tV78@public.gmane.org
Sent: Sunday, August 04, 2002 5:47 PM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] problems with patch acpi-20020725 and Suse kernel

Hi,

I just applied patch acpi-20020725 to my standard Suse 2.14.18-4GB
kernel. The patching fails in several files:

First: 
linux-24/arch/i386/kernel/acpitable.c
Reversed (or previously applied) patch detected!

then there are failed patches reported for:
mpparse.c
mm/init.c
acpi_ksyms.c

Compilation of the kernel stopped in acpi_ksyms.c. I could "fix" this by
commenting out  lines 31, 97, 98:
   #ifdef CONFIG_ACPI_INTERPRETER
   acpi_hw_register_bit_access
   acpi_hw_obtain_sleep_type_register_data
Actually I haven't got a clue what I am doing there but it sort of
worked..

Unfortunately, on my Evo N160 the new kernel stopped booting after
reporting some IRQ's. But this seems to be already a different topic as
it has been reported before for this notebook...

Is there a Suse-specific patch available, or should I revert to the
standard kernel (which one)? 
Has anyone managed to get ACPI functionality on the Evo N160?

Best regards
Raik

________________________________________________________________________
______
ich.bin-WUNohcmBtvU@public.gmane.org - nur eine der witzigsten E-Mail-Adressen der Welt! 
Interesse? Klicken! http://digitaledienste.web.de/MyAdress/?mc=021104



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
