From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Disable hibernate -- Live media shouldn't allow it?
Date: Thu, 16 May 2013 09:56:43 -0400
Message-ID: <5194E59B.8070800@ubuntu.com>
References: <519408C1.9030706@ubuntu.com> <1613817.TcdBxdmQtn@vostro.rjw.lan> <51941E2C.1070900@ubuntu.com> <1504575.PoflzRoA7X@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:65210 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab3EPN4p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 May 2013 09:56:45 -0400
In-Reply-To: <1504575.PoflzRoA7X@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 5/16/2013 4:54 AM, Rafael J. Wysocki wrote:
> No, I don't think so.  At least I'm not aware of that.  Do you have
> any pointers to the kernel code doing that?

No, but I also can't see anything in user mode doing it either, which
is why I'm asking.  I assumed that since this is an emergency response
required by the ACPI spec, that it would be implemented by the kernel
ACPI driver.

> Actually, it is not all it takes.  You need to point the hibernate
> code to the specific swap through the resume= kernel command line
> option (there is a default, though).

That's needed to resume, but not to hibernate.  Simply doing a swapon
is enough to enable hibernating.  Checking that you have a valid
resume= kernel argument probably would be a sane thing to do before
allowing hibernation, but this isn't currently the case.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJRlOWYAAoJEJrBOlT6nu75C5AH/AylnOPsCPngyZtMGoyBNE5t
IY/AM6YjVnuOuCYkIvQ973Vm6gIBaX4jP3SIAc35GEHWMwc+374DmDsuCsH3+hSh
aT16qYIyx/hMgX8YN1qKoLSLoN3VwA0Lv1UV8aaAsmlJsX5mG4FtSpzPTtwBkIoj
ctVJIfihpKgBJcbF0uvWyI8Z+2i9xa8jryd+Tl31K3Q4WLX/8XWjOtph9dcsXUXC
6En190gCz9dYeNN0937OLCXbmjOd0krGo7512OkfsygjAoPf589XzopS3BCLichM
RQ8w295x8OhO5BZaKMUtHaxsLuj7v5X4BAqfAP83iNbR7Gj/nP7dQpExb8/y7xs=
=O9Ks
-----END PGP SIGNATURE-----
