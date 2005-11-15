From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: battery issues with 2.6.14
Date: Tue, 15 Nov 2005 16:05:00 -0700
Message-ID: <20051115230502.ED1B43C005A@ningauble.scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Greetings. 

I did a quick search of the list archives and the bugzilla.kernel.org,
but didn't see any reports of what I am seeing:

Under 2.6.13-1.1532_FC4 (fedora update kernel) and all before it, my
battery works great. I can use amount left, no errors, survives
suspend/resume just fine. 

Starting with 2.6.14-1.1633_FC4 and any 2.6.14 kernel after that, the
battery works ok for a while, then stops reporting any information. 
It looks like it stops working when the battery would normally start
reporting something like discharging or the like. 

Unloading and reloading the battery module doesn't change anything. 

In the dmesg I see:

    ACPI-0292: *** Error: Looking up [SERN] in namespace, AE_ALREADY_EXISTS
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.GBIF] (Node f7e245a0), AE_ALREADY_EXISTS
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node f7e24460),
AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node f7e24460),
AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node f7e24460),
AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node f7e24460),
AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node f7e24460),
AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node f7e24460),
AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node f7e24460),
AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node f7e24460),
AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node f7e24460),
AE_AML_METHOD_LIMIT

This laptop is a thinkpad t42p. 

Happy to provide any further information that would be helpfull. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFDemme3imCezTjY0ERAhlyAJ42UUwOck3L6E8YufNJxVOgv/FDSwCfYNFE
vihmFkHQhJGItXhKWhAQzYQ=
=g5Cb
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
