From: Rajat Jain <rajat.noida.india@gmail.com>
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Date: Fri, 29 Jul 2005 19:23:40 +0900
Message-ID: <b115cb5f05072903233fef8dc3@mail.gmail.com>
References: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com>
	 <b115cb5f0507241949da02aa7@mail.gmail.com>
	 <512afbf905072711295f87ad24@mail.gmail.com>
	 <b115cb5f05072803451836055c@mail.gmail.com>
	 <20050728175217.A1821@unix-os.sc.intel.com>
Reply-To: Rajat Jain <rajat.noida.india@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hotplug-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050728175217.A1821@unix-os.sc.intel.com>
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
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Kristen Accardi <kristen.kml@gmail.com>, greg@kroah.com, linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org, acpi-devel@lists.sourceforge.net, linux-hotplug-devel@lists.sourceforge.net, dkumar@noida.hcltech.com
List-Id: linux-acpi@vger.kernel.org

On 7/29/05, Rajesh Shah <rajesh.shah@intel.com> wrote:
> On Thu, Jul 28, 2005 at 07:45:49PM +0900, Rajat Jain wrote:
> >
> > Okay. I'm sorry but I'm not very clear with this. I'm just putting
> > down here my understanding. So basically we have two mutually
> > EXCLUSIVE hotplug drivers I can use for PCI Express:
> >
> A hotplug slot can be controlled only by a single hotplug
> technology - pcie shpc or acpiphp. However, different parts of
> the I/O hierarchy can be controlled by different technologies.
> For example, a host bridge I/O complex can be hotplugged using
> acpiphp, but end devices under this IO complex may be hotpplugged
> using pcie or shpc hotplug.
>=20
> > 1) "pciehp.ko" : We use this PCIE HP driver when our BIOS supports
> > Native Hot-plug for PCI Express (which means that hot-plug will be
> > handled by OS single handedly).
> >
> > 2) "acpiphp.ko" : We use this "generic" ACPI HP driver when BIOS
> > allows only ITSELF to handle hot-plug events.
> >
> No, acpi hotplug is not handled by BIOS only.
> Both acpi and pcie hotplug need firmware support as well as hardware
> support. Hardware in many (but not all) systems support both types of
> hotplug and its up to the BIOS to decide which type to support. If the
> platform supports pcie hotplug, you see an _OSC & _SUN methods in the
> ACPI namespace and the pciehp driver controls hotplug slots. If the
> system supports acpi hotplug, you see _ADR and _EJ0 methods in the ACPI
> namespace and the acpiphp driver controls the corresponding hotplug slots=
.
>=20
> Rajesh
>=20

Thanks a lot. It has proved to be a very useful information for me. I
can now do some R&D on it.

Thanks again,

Rajat


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
