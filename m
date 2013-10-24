From: Fabian Wehning <fabian.wehning@googlemail.com>
Subject: "Kernel panic - not syncing" while booting
Date: Thu, 24 Oct 2013 21:09:47 +0200
Message-ID: <5269707B.4040404@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:57431 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939Ab3JXTKV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Oct 2013 15:10:21 -0400
Received: by mail-ee0-f54.google.com with SMTP id t10so1114109eei.41
        for <linux-acpi@vger.kernel.org>; Thu, 24 Oct 2013 12:10:19 -0700 (PDT)
Received: from [192.168.170.28] (ip-178-203-8-101.unitymediagroup.de. [178.203.8.101])
        by mx.google.com with ESMTPSA id a6sm7870497eei.10.2013.10.24.12.10.18
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 24 Oct 2013 12:10:19 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[1.] Ubuntu 13.10 is not booting if kernel "v3.10 final" or later is
used. Title in Launchpad is "13.10: Kernel panic - not syncing (on
system start)"

[2.] Full description of the problem/report:
Directly after the bios information screen (during the start of
ubuntu) it is reporting "Kernel panic - not syncing: Attempted to kill
init! exitcode=0x00000009" and hangs from then on.

An image of the output is attached to Launchpad with the name
"CAM00061.jpg".

I hope this mailinglist is the correct one. I thought this might be
correct because directly preceeding the hanging it says
"acpi_rs_create_pci_routing_table+0xae/0x23b SS: ESP 0068:f6c6bce4"

I have tested this with the latest available version "v3.12-rc6" (not
only with "v3.10 final"). "v3.9 final" was OK.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Impossible to perform because system is not finishing booting.
But I have installed:
"linux-image-3.12.0-031200rc6-generic_3.12.0-031200rc6.201310191635_i386.deb"
from http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.12-rc6-saucy/

[5.] Seems I have none.

[6.] Beyond my skill level.

[7.] Impossible to perform because system is not finishing booting.

[7.1.] Impossible to perform because system is not finishing booting.

[7.2.] Impossible to perform because system is not finishing booting.

[7.3.] Impossible to perform because system is not finishing booting.

[7.4.] Impossible to perform because system is not finishing booting.

[7.5.] Impossible to perform because system is not finishing booting.

[7.6.] Impossible to perform because system is not finishing booting.

[7.7.] Any information i have can be found at
https://bugs.launchpad.net/bugs/1242938

[X.] see 7.7. There are also some files which some guys asked for.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21-beta20 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSaXB7AAoJEG37YNPnj3ukL4oH/AwSpoL0XrzfitNWWTHUDakm
xqN3watpgPR0FtXkwxzVvCfjjR2ld80QumJbTMHJBxRfsBzGLk2xATWlgbe7l1/G
P0R5RlD9DUOqa268Xpbt8zNxcVvIe6vE5LcE9xHUf1/ieRUzCG4VkmmhsO52BjO6
fSov/runcom9PKDkXQn9nMFsqlc4SiJQHG4qQxFd72ihjlAgHMlPXRAwDFmsRDAw
HAv3NXiqqgfhDJtqrr1iIjqZwJtP1qQNZqJyrbXWQlxBsHBDIk6VE6xMHFjnzcc9
M00c2bIAJU/YDIlxalgxr/toORZJO3mEd2dlK+34uhBrqbRPOLBMofuBrv2TtFw=
=ojDN
-----END PGP SIGNATURE-----
