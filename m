From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: Re: Working around bugs in ACPI BIOS [was Re: DSDT in initrd]
Date: Mon, 19 May 2003 11:07:34 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030519170738.E9CEEF7F60@voldemort.scrye.com>
References: <F760B14C9561B941B89469F59BA3A847E96EA0@orsmsx401.jf.intel.com>
	<20030518213405.GB452@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Pavel" == Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:

Pavel> Hi!
>> I must admit I'm really torn. If there were 2-3 little AML problems
>> that if we worked around them, a horde of machines would start
>> working, then I think we would do that, but my sense is that there
>> are many more ways a DSDT can be broken, and that implementing
>> workarounds for all of them would cause other systems to
>> fail. Maybe some of the people who have fixed their DSDTs can
>> comment on the scope of bugs out there.

Pavel> I believe policy should be "if it can't possibly break anyone".

Pavel> AML functions not returning value can be safely replaced with
Pavel> returning 0; uninitialized variables can also be initialized
Pavel> with 0. Both should be safe, and we should printk() loudly in
Pavel> both cases.

The one I would like to see is when acpi is parsing and comes accross
a variable with a * in it, it just removes the * and parses the
variable after that. This would make tons of compaq laptops happy with
acpi out of the box. I think pretty much all of them have this bug. 

The main reason I have to modify my dsdt is to remove all the *'s from
it. ie, 

Name(_HID, "*PNP0C0B")
...
Name(_HID, "*PNP0C01")
...
Name(_HID, "*PNP0A03")

Is there any way this could be added?

Granted this might cause compaq to not update their bios, but on many
of the older laptops I don't think thats going to happen anyhow. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+yQ9a3imCezTjY0ERAr3/AKCbuqoMQpYkRuMaBskTx1FPTiEDigCeMgN8
rWg4Pf0x6RuabOMEtfjTVj8=
=sStk
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
