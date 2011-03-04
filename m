From: Valdis.Kletnieks@vt.edu
Subject: Re: mmotm 2011-03-02 - ACPI/sysfs WARNING with NVidia graphics card
Date: Thu, 03 Mar 2011 23:28:50 -0500
Message-ID: <8842.1299212930@localhost>
References: <201103030127.p231ReNl012841@imap1.linux-foundation.org> <33350.1299196241@localhost>
            <20110304000550.GA2073@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1299212930_4910P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:55843 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758381Ab1CDE33 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2011 23:29:29 -0500
In-Reply-To: Your message of "Thu, 03 Mar 2011 16:05:50 PST."
             <20110304000550.GA2073@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: akpm@linux-foundation.org, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

--==_Exmh_1299212930_4910P
Content-Type: text/plain; charset=us-ascii

On Thu, 03 Mar 2011 16:05:50 PST, Greg KH said:

> > [    0.818236] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
> 
> Have you tried this option?
> 
> There's nothing sysfs can do here, sorry, it really looks like you have
> a BIOS/firmware problem.

Well, (a) it's been saying "try it if the current driver doesn't work" - and
things have worked just fine all along (or more properly, if it's broken in
behavior, I haven't actually seen the effects...)

and (b) Something changed very recently to add the WARNING, which wasn't there
in rc5-next-2011022.

And (c) I doubt that's going to fix the WARNING, because looking at drivers/
acpi/video.c, the variable allow_duplicates is checked in exactly *ONE* place,
which is *after* the printk:

        if (status == AE_ALREADY_EXISTS) {
                printk(KERN_WARNING FW_BUG
                        "Duplicate ACPI video bus devices for the"
                        " same VGA controller, please try module "
                        "parameter \"video.allow_duplicates=1\""
                        "if the current driver doesn't work.\n");
                if (!allow_duplicates)
                        return -ENODEV;
        }

So since the warning triggers before we see the printk(), setting the variable
won't make a difference because we warn before we ever get into that if
statement.

Now, maybe we need to be checking allow_duplicates earlier and/or in other
places - but I'll let somebody who actually understands the code to decide taht. ;)

--==_Exmh_1299212930_4910P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFNcGqCcC3lWbTT17ARAioGAKDNImt8X7Hwo+WqD28dlReYLIXwPACfTM8K
lHfchcbRleZmaNpXUkbx6+o=
=0pRI
-----END PGP SIGNATURE-----

--==_Exmh_1299212930_4910P--

