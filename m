From: Norbert Preining <preining@logic.at>
Subject: Re: Why is it so hard to (get) help on ACPI?
Date: Thu, 17 May 2007 21:21:23 +0200
Message-ID: <20070517192123.GD7637@gamma.logic.tuwien.ac.at>
References: <200705172005.47845.matija.suklje@rutka.net> <8f8ff01d0705171158q3412f0f1o4465562bb961d774@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:41266 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758040AbXEQTV0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 May 2007 15:21:26 -0400
Content-Disposition: inline
In-Reply-To: <8f8ff01d0705171158q3412f0f1o4465562bb961d774@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Matija =?iso-8859-15?Q?=A6uklje?= <matija.suklje@rutka.net>, linux-acpi@vger.kernel.org

On Don, 17 Mai 2007, Alexey Starikovskiy wrote:
> First of all, why do you want/need to change your DSDT?
> Second, patching DSDT is meant to be a last resort if any other
> method, like finding error in our implementation of ACPI or drivers.

Well, of course, but frustration level is sometimes getting high, and
one tries to fix as much as possible to get it working. I for example
removed my modified DSDT some time ago to test the `official' ACPI
implementation. Then I tried to get s2ram to working, to no avail.
Restarting was freezing the kernel beyond repair (there is already a bu=
g
reported, but no real action).

Now of course I tried also to fix the compile errors in the DSDT etc.

> So "better" DSDT patch is patch of zero length -- don't touch it, fix
> ACPI or drivers.

Well, tell me how?

Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Dr. Norbert Preining <preining@logic.at>                    Universit=E0=
 di Siena
Debian Developer <preining@debian.org>                         Debian T=
eX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
DEEPING ST NICHOLAS (n.)
			--- Douglas Adams, The Meaning of Liff
What street-wise kids do at Christmas. They hide on the rooftops
waiting for Santa Claus so that if he arrives and goes down the
chimney, they can rip stuff off from his sleigh.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
