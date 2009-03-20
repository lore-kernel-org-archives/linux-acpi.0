From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Fri, 20 Mar 2009 01:28:27 +0100
Message-ID: <20090320002827.GB19755@gamma.logic.tuwien.ac.at>
References: <20090319212123.GA24700@srcf.ucam.org> <20090319213428.GK29624@gamma.logic.tuwien.ac.at> <20090319214437.GB24898@srcf.ucam.org> <20090319221527.GA11001@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:50247 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbZCTA2i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 20:28:38 -0400
Content-Disposition: inline
In-Reply-To: <20090319221527.GA11001@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

On Do, 19 M=E4r 2009, Norbert Preining wrote:
> Ok, here some first test result:
> kernel 2.6.29-rc8 plus only your patch.

Another result, but this time a bit negative: Your patch does not (well
I know) incorporate the stuff turning off the secondary nvidia card on
the device having Stamina-Speed switch.=20

Outcome of that is that the power consumption is much higher with your
modules about 8-10W (measured with powertop). So I have to go back to
the other module.

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
`That young girl is one of the least benightedly
unintelligent organic life forms it has been my profound
lack of pleasure not to be able to avoid meeting.'
                 --- Marvin's first ever compliment about anybody.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
