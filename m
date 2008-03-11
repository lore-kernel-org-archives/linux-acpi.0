From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Tue, 11 Mar 2008 09:52:20 +0800
Message-ID: <1205200340.2240.1.camel@acpi-hp-zz.sh.intel.com>
References: <fmaaj5$jsl$1@ger.gmane.org>
	 <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org>
	 <20080112124619.GA15578@srcf.ucam.org>  <fmakts$gqs$1@ger.gmane.org>
	 <1203347919.6019.79.camel@queen.suse.de> <fqtkjq$rod$1@ger.gmane.org>
	 <fqtor7$5mu$1@ger.gmane.org>
	 <1205111890.4069.1.camel@yakui_zhao.sh.intel.com>
	 <1205148191.25830.106.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14723 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753810AbYCKCCy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Mar 2008 22:02:54 -0400
In-Reply-To: <1205148191.25830.106.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Zhao Yakui <yakui.zhao@intel.com>, giggz <giggzounet@gmail.com>, linux-acpi@vger.kernel.org, hong.liu@intel.com


On Mon, 2008-03-10 at 12:23 +0100, Thomas Renninger wrote:=20
> On Mon, 2008-03-10 at 09:18 +0800, Zhao Yakui wrote:
> > On Sat, 2008-03-08 at 11:08 +0100, giggz wrote:
> > > giggz a =C3=A9crit :
> > > [snip]
> > >=20
> > > >>>> In that case, try catting /proc/acpi/event and hit the butto=
n.
> > > >> On SUSE, instead of stopping acpid, you can use:
> > > >> acpi_listen
> > > >> to log acpi events.
> > > >>
> > >=20
> > > in my case when I increase the level of acpi debug and hit the Fn=
+F3
> > > button I don't see anything when I cat /proc/acpi/event. And it's=
 the
> > > same if I use acpi_listen. I launch acpi_listen and the hit the b=
utton,
> > > but nothing appears. I just get the message I posted in the
> > > /var/log/messages.
> > >=20
> > Will you please attach the acpidump output ?
> > The pmtools can be downloaded from :
> > http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtoo=
ls-20071116.tar.bz2
>=20
> Yep.
> Depending on your distribution you might find the acpidump binary in =
a
> package. On SUSE it would be the pmtools package. A bit googling shou=
ld
> tell you what package you need to install on your distri to get
> acpidump.
>=20
> Best is you open a bug here:
> http://bugzilla.kernel.org/
> and attach the info you already posted on the list (the dmesg output
> with increased ACPI debug output) and the acpidump.
> Please add me to CC of the bug then.
> Currently there are patches to connect ACPI and graphics driver on th=
e
> way,
And these patches are used to notify graphics kernel mode driver to
change the brightness when some events occur, like hot key press, lid
close/open and dock/undock.
But unfortunately the graphics kernel mode driver is not finished yet,
which means that we've just setup the full working stack but won't do
any actual work at the last step.
Hong, correct me if I say something wrong. :)

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
