From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Thu, 19 Mar 2009 22:34:28 +0100
Message-ID: <20090319213428.GK29624@gamma.logic.tuwien.ac.at>
References: <20090319212123.GA24700@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:38599 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbZCSVen (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 17:34:43 -0400
Content-Disposition: inline
In-Reply-To: <20090319212123.GA24700@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

HI Matthew,

On Do, 19 M=E4r 2009, Matthew Garrett wrote:
> Enable events on all Vaio's with the new-style ACPI interface, and us=
e
> it to support rfkill where available.

Thanks for these patches, do they enable wwan activation on Vaio Z
series, too?

Currently the stock kernel sony-laptop with all patches floating around
on lkml did not make the wwan interface show up from the turned off
state. The only way to do that is using the 0.6 version for Vaio Z from
http://www.basyskom.org/~eva/log_installation_vaio_z21vnx.html

Thanks and all the best

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
BAUGHURST
That kind of large fierce ugly woman who owns a small fierce ugly dog.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
