From: Norbert Preining <preining@logic.at>
Subject: Re: help with fixing code for 2.6.29-rc7
Date: Fri, 13 Mar 2009 00:43:36 +0100
Message-ID: <20090312234336.GC29738@gamma.logic.tuwien.ac.at>
References: <20090312115032.GB26205@gamma.logic.tuwien.ac.at> <200903121441.13936.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:36560 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbZCLXnr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2009 19:43:47 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3] ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1LhuYq-0007xH-4k
	for linux-acpi@vger.kernel.org; Fri, 13 Mar 2009 00:43:36 +0100
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1LhuYq-0007qH-29
	for linux-acpi@vger.kernel.org; Fri, 13 Mar 2009 00:43:36 +0100
Content-Disposition: inline
In-Reply-To: <200903121441.13936.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Do, 12 M=E4r 2009, Rafael J. Wysocki wrote:
> Seemingly, struct acpi_namespace_node is undefined.

Thanks, good point. The problem is that they are used in the sony-lapto=
p
module for Sony-Z series laptops. I copied the relevant three acpica/*.=
h
files to the build directory and added includes, now it compiles and
works fine.

Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Te=
chnology
Debian Developer <preining@debian.org>                         Debian T=
eX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
OCKLE (n.)
An electrical switch which appears to be off in both positions.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
