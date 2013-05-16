From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Disable hibernate -- Live media shouldn't allow it?
Date: Thu, 16 May 2013 10:54:18 +0200
Message-ID: <1504575.PoflzRoA7X@vostro.rjw.lan>
References: <519408C1.9030706@ubuntu.com> <1613817.TcdBxdmQtn@vostro.rjw.lan> <51941E2C.1070900@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:50737 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755825Ab3EPIpl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 May 2013 04:45:41 -0400
In-Reply-To: <51941E2C.1070900@ubuntu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday, May 15, 2013 07:45:48 PM Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 05/15/2013 06:29 PM, Rafael J. Wysocki wrote:
> > That said, it is reasonable to expect live CDs not to configure the
> > system to hibernate in response to overheating etc.  But that's not
> > a problem we can address in the kernel.
> 
> How would that be configured?  Initiating the hibernation in response
> to api HOT event is done in the kernel isn't it?

No, I don't think so.  At least I'm not aware of that.  Do you have any
pointers to the kernel code doing that?

> Setting the policy obviously isn't something that can be done in the
> kernel, but it should provide for the ability to have such a policy by
> having a knob user mode has to switch on when it thinks hibernation
> makes any kind of sense.  Simply enabling a swap shouldn't be all it
> takes -- you should have to specify that yes, this swap is configured
> for hibernate/resume.

Actually, it is not all it takes.  You need to point the hibernate code
to the specific swap through the resume= kernel command line option
(there is a default, though).

Thanks,
Rafael


> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.12 (GNU/Linux)
> Comment: Using GnuPG with undefined - http://www.enigmail.net/
> 
> iQEcBAEBAgAGBQJRlB4sAAoJEJrBOlT6nu75oCwIAI2BmGmz/3gZjXuijTtDT90A
> ztcC04GltiCW6ciP8eq87L+dxogUoorR7lyJAeDycafEGscjbu9zaMFf6DL2SheH
> MKEWGg9Kk0j81gl2FDdkKrj6ZJzibcDuEFytcr9kLVE+je7vckUxDueBQvcy7ReK
> P6HYLgy6kEprvlAi8xmhv3CKZRmBi/gzsi6kxSTb32smqJ9l5qFfPSpL6paq6QbX
> 20rUvX0JHF5b8LHAsHgQfyS5DQ50tGVBKwE/X0+CRoVqPmS4tdJVvkp429SlwmJY
> FSPEN2aXESfwtRt/zk9AJRkZN9OCFQP44mVBSRsmjAN/lTTOjb35bdZPRBUP76o=
> =0vb+
> -----END PGP SIGNATURE-----
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
