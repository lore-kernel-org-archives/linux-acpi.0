From: Kristen Accardi <kristen.kml@gmail.com>
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Date: Thu, 28 Jul 2005 10:00:14 -0700
Message-ID: <512afbf905072810005f327e3@mail.gmail.com>
References: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com>
	 <b115cb5f0507241949da02aa7@mail.gmail.com>
	 <512afbf905072711295f87ad24@mail.gmail.com>
	 <b115cb5f05072803451836055c@mail.gmail.com>
Reply-To: Kristen Accardi <kristen.kml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hotplug-devel-admin@lists.sourceforge.net>
In-Reply-To: <b115cb5f05072803451836055c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-hotplug-devel-admin@lists.sourceforge.net
Errors-To: linux-hotplug-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-hotplug-devel@lists.sourceforge.net>
List-Help: <mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-hotplug-devel>
To: Rajat Jain <rajat.noida.india@gmail.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org, acpi-devel@lists.sourceforge.net, linux-hotplug-devel@lists.sourceforge.net, dkumar@noida.hcltech.com
List-Id: linux-acpi@vger.kernel.org

On 7/28/05, Rajat Jain <rajat.noida.india@gmail.com> wrote:
> >
> > Hi Rajat, you can learn more about the OSHP method by reading the PCI
> > express spec.  It is used to tell an ACPI bios that the OS will be
> > handling the hotplug events natively.  It may be that your BIOS does
> > not allow native hotplug for pcie, in which case you need to be using
> > the acpiphp driver instead of the pciehp driver.  You could just try
> > modprobing acpiphp and see if this will handle the hotplug events.  A
> > recent version of lspci (which understands pcie) will tell you as well
> > if pcie hotplug capability is supported (lspci -vv).
> >
>=20
> Okay. I'm sorry but I'm not very clear with this. I'm just putting
> down here my understanding. So basically we have two mutually
> EXCLUSIVE hotplug drivers I can use for PCI Express:
>=20
> 1) "pciehp.ko" : We use this PCIE HP driver when our BIOS supports
> Native Hot-plug for PCI Express (which means that hot-plug will be
> handled by OS single handedly).
>=20
> 2) "acpiphp.ko" : We use this "generic" ACPI HP driver when BIOS
> allows only ITSELF to handle hot-plug events.

usually this is configurable.  So, you can configure you BIOS to use
acpi to handle hot-plug, or you can allow the OS to handle it.  Most
OS (from what I hear) don't actually implement native hotplug support,
so native hotplug support is probably not as big a priority for bios
writers as the acpi support.  so, it doesn't surprise me to find some
that don't support native.

you can run the native hotplug driver on a system who's bios supports
acpi - if it provides the OSHP method, this tells the bios to allow
the OS to handle it.

>=20
> Is my understanding correct? I would appreciate if you could help me
> gain a grip on this.

i'm trying to gain a grip myself, as i've just started learning about
pcie :).  someone else hopefully will correct me if i'm telling you
the wrong info.


>=20
> Thanks a lot for the useful info you gave. Provided me with a new
> direction to work on.
>=20
> Regards,
>=20
> Rajat
>=20

Kristen


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
