From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Mon, 10 Mar 2008 09:18:10 +0800
Message-ID: <1205111890.4069.1.camel@yakui_zhao.sh.intel.com>
References: <fmaaj5$jsl$1@ger.gmane.org>
	 <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org>
	 <20080112124619.GA15578@srcf.ucam.org>  <fmakts$gqs$1@ger.gmane.org>
	 <1203347919.6019.79.camel@queen.suse.de> <fqtkjq$rod$1@ger.gmane.org>
	 <fqtor7$5mu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5355 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753122AbYCJB3C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Mar 2008 21:29:02 -0400
In-Reply-To: <fqtor7$5mu$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: giggz <giggzounet@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, 2008-03-08 at 11:08 +0100, giggz wrote:
> giggz a =C3=A9crit :
> [snip]
>=20
> >>>> In that case, try catting /proc/acpi/event and hit the button.
> >> On SUSE, instead of stopping acpid, you can use:
> >> acpi_listen
> >> to log acpi events.
> >>
>=20
> in my case when I increase the level of acpi debug and hit the Fn+F3
> button I don't see anything when I cat /proc/acpi/event. And it's the
> same if I use acpi_listen. I launch acpi_listen and the hit the butto=
n,
> but nothing appears. I just get the message I posted in the
> /var/log/messages.
>=20
Will you please attach the acpidump output ?
The pmtools can be downloaded from :
http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools-2=
0071116.tar.bz2

Thanks.

> Guillaume
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
