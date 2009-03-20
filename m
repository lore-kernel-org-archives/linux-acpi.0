From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Fri, 20 Mar 2009 00:38:23 +0000
Message-ID: <20090320003823.GA27600@srcf.ucam.org>
References: <20090319212123.GA24700@srcf.ucam.org> <20090319213428.GK29624@gamma.logic.tuwien.ac.at> <20090319214437.GB24898@srcf.ucam.org> <20090319221527.GA11001@gamma.logic.tuwien.ac.at> <20090320002827.GB19755@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44130 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759120AbZCTAi1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 20:38:27 -0400
Content-Disposition: inline
In-Reply-To: <20090320002827.GB19755@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

On Fri, Mar 20, 2009 at 01:28:27AM +0100, Norbert Preining wrote:
> On Do, 19 M=E4r 2009, Norbert Preining wrote:
> > Ok, here some first test result:
> > kernel 2.6.29-rc8 plus only your patch.
>=20
> Another result, but this time a bit negative: Your patch does not (we=
ll
> I know) incorporate the stuff turning off the secondary nvidia card o=
n
> the device having Stamina-Speed switch.=20

As far as we can tell, the handling of the handover is consistent acros=
s=20
all dual-GPU nvidia laptops[1]. The right place for support to end up i=
s=20
in the kernel component of the nouveau drivers.

[1] Possibly not the Macs
--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
