From: Rajat Jain <rajat.noida.india@gmail.com>
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Date: Thu, 28 Jul 2005 19:45:49 +0900
Message-ID: <b115cb5f05072803451836055c@mail.gmail.com>
References: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com>
	 <b115cb5f0507241949da02aa7@mail.gmail.com>
	 <512afbf905072711295f87ad24@mail.gmail.com>
Reply-To: Rajat Jain <rajat.noida.india@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hotplug-devel-admin@lists.sourceforge.net>
In-Reply-To: <512afbf905072711295f87ad24@mail.gmail.com>
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
To: Kristen Accardi <kristen.kml@gmail.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org, acpi-devel@lists.sourceforge.net, linux-hotplug-devel@lists.sourceforge.net, dkumar@noida.hcltech.com
List-Id: linux-acpi@vger.kernel.org

>=20
> Hi Rajat, you can learn more about the OSHP method by reading the PCI
> express spec.  It is used to tell an ACPI bios that the OS will be
> handling the hotplug events natively.  It may be that your BIOS does
> not allow native hotplug for pcie, in which case you need to be using
> the acpiphp driver instead of the pciehp driver.  You could just try
> modprobing acpiphp and see if this will handle the hotplug events.  A
> recent version of lspci (which understands pcie) will tell you as well
> if pcie hotplug capability is supported (lspci -vv).
>=20

Okay. I'm sorry but I'm not very clear with this. I'm just putting
down here my understanding. So basically we have two mutually
EXCLUSIVE hotplug drivers I can use for PCI Express:

1) "pciehp.ko" : We use this PCIE HP driver when our BIOS supports
Native Hot-plug for PCI Express (which means that hot-plug will be
handled by OS single handedly).

2) "acpiphp.ko" : We use this "generic" ACPI HP driver when BIOS
allows only ITSELF to handle hot-plug events.

Is my understanding correct? I would appreciate if you could help me
gain a grip on this.

Thanks a lot for the useful info you gave. Provided me with a new
direction to work on.

Regards,

Rajat


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
