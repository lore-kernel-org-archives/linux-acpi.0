From: "Markus Joschko" <markus.joschko-S0/GAf8tV78@public.gmane.org>
Subject: AW: N600c/N610c fan not working problem
Date: Sun, 10 Nov 2002 21:28:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <NGBBLAGMKDNCFAOAPEHOMECCCDAA.markus.joschko@web.de>
References: <20021110174518.GB2544@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021110174518.GB2544-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

Hi,

>Heh, kernel version would be helpfull.
2.4.20-r6

in the mean time I have corrected the dsdt with guidance from presario/800v
users.
I did: remove * from object names. Removing an ALIAS line, changing method
references to absolut references.

Now the fan is working and the notebook switches off if I do a shutdown. The
battery is identified. Nothing more tried yet.

But I have a lot of error reports during the booting of the notebook. May be
someone can explain/help me with them.
(OT: is there a possiblity to search the acpi-devel mailing list? I can't
find any advice on the sourceforge page. Would make research a lot easier):

PCI: Using configuration type 1
	ACPI-0243: *** Error: Could not install Pci_config handler for C03A,
AE_ALREADY_EXISTS

and

ACPI: System [ACPI] (supports S0 S3 S4 S5)
	ACPI-1155: *** Error: Method execution failed, AE_AML_BUFFER_LIMIT

and

ACPI: AC Adapter [C186] (on-line)
	ACPI-1155: *** Error: Method execution failed, AE_AML_UNINITIALIZED_LOCAL


Thanks,
 MArkus


-----Ursprüngliche Nachricht-----
Von: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]Im Auftrag von Pavel
Machek
Gesendet: Sonntag, 10. November 2002 18:45
An: Markus Joschko
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Betreff: Re: [ACPI] N600c/N610c fan not working problem


Hi!

> I recently bought a Evo N610c Compaq notebook and tried to install gentoo
> linux with the latest acpi patched gentoo kernel.
>
> Like others on the mailinglist I noticed that the fan isn't working as
soon
> as ACPI is enabled. Passing acpi=off to the kernel during boottime brings
> back the fan.
>
> Is there any solution for the fan problem yet? Can I help with providing
> some kind of data?

Heh, kernel version would be helpfull.

Also /proc/acpi/thermal/*.
								Pavel
--
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


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
