From: Thomas Renninger <trenn@suse.de>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Mon, 10 Mar 2008 12:23:11 +0100
Message-ID: <1205148191.25830.106.camel@queen.suse.de>
References: <fmaaj5$jsl$1@ger.gmane.org>
	 <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org>
	 <20080112124619.GA15578@srcf.ucam.org>  <fmakts$gqs$1@ger.gmane.org>
	 <1203347919.6019.79.camel@queen.suse.de> <fqtkjq$rod$1@ger.gmane.org>
	 <fqtor7$5mu$1@ger.gmane.org>
	 <1205111890.4069.1.camel@yakui_zhao.sh.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58479 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbYCJLXM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Mar 2008 07:23:12 -0400
In-Reply-To: <1205111890.4069.1.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: giggz <giggzounet@gmail.com>, linux-acpi@vger.kernel.org

On Mon, 2008-03-10 at 09:18 +0800, Zhao Yakui wrote:
> On Sat, 2008-03-08 at 11:08 +0100, giggz wrote:
> > giggz a =C3=A9crit :
> > [snip]
> >=20
> > >>>> In that case, try catting /proc/acpi/event and hit the button.
> > >> On SUSE, instead of stopping acpid, you can use:
> > >> acpi_listen
> > >> to log acpi events.
> > >>
> >=20
> > in my case when I increase the level of acpi debug and hit the Fn+F=
3
> > button I don't see anything when I cat /proc/acpi/event. And it's t=
he
> > same if I use acpi_listen. I launch acpi_listen and the hit the but=
ton,
> > but nothing appears. I just get the message I posted in the
> > /var/log/messages.
> >=20
> Will you please attach the acpidump output ?
> The pmtools can be downloaded from :
> http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools=
-20071116.tar.bz2

Yep.
Depending on your distribution you might find the acpidump binary in a
package. On SUSE it would be the pmtools package. A bit googling should
tell you what package you need to install on your distri to get
acpidump.

Best is you open a bug here:
http://bugzilla.kernel.org/
and attach the info you already posted on the list (the dmesg output
with increased ACPI debug output) and the acpidump.
Please add me to CC of the bug then.
Currently there are patches to connect ACPI and graphics driver on the
way, it could be that we miss some support in the kernel of the latter,
I don't know, let's evaluate this a bit further in the bug...

Thanks,

   Thomas

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
