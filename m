From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Disable hibernate -- Live media shouldn't allow it?
Date: Wed, 15 May 2013 19:45:48 -0400
Message-ID: <51941E2C.1070900@ubuntu.com>
References: <519408C1.9030706@ubuntu.com> <1613817.TcdBxdmQtn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:45036 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab3EOXpv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 May 2013 19:45:51 -0400
In-Reply-To: <1613817.TcdBxdmQtn@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/15/2013 06:29 PM, Rafael J. Wysocki wrote:
> That said, it is reasonable to expect live CDs not to configure the
> system to hibernate in response to overheating etc.  But that's not
> a problem we can address in the kernel.

How would that be configured?  Initiating the hibernation in response
to api HOT event is done in the kernel isn't it?

Setting the policy obviously isn't something that can be done in the
kernel, but it should provide for the ability to have such a policy by
having a knob user mode has to switch on when it thinks hibernation
makes any kind of sense.  Simply enabling a swap shouldn't be all it
takes -- you should have to specify that yes, this swap is configured
for hibernate/resume.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJRlB4sAAoJEJrBOlT6nu75oCwIAI2BmGmz/3gZjXuijTtDT90A
ztcC04GltiCW6ciP8eq87L+dxogUoorR7lyJAeDycafEGscjbu9zaMFf6DL2SheH
MKEWGg9Kk0j81gl2FDdkKrj6ZJzibcDuEFytcr9kLVE+je7vckUxDueBQvcy7ReK
P6HYLgy6kEprvlAi8xmhv3CKZRmBi/gzsi6kxSTb32smqJ9l5qFfPSpL6paq6QbX
20rUvX0JHF5b8LHAsHgQfyS5DQ50tGVBKwE/X0+CRoVqPmS4tdJVvkp429SlwmJY
FSPEN2aXESfwtRt/zk9AJRkZN9OCFQP44mVBSRsmjAN/lTTOjb35bdZPRBUP76o=
=0vb+
-----END PGP SIGNATURE-----
