From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with
 the sony-platform module]
Date: Tue, 19 Jun 2012 08:59:34 +0800
Message-ID: <1340067574.1682.5.camel@rui.sh.intel.com>
References: <4FDA2051.3050108@babioch.de>
	 <20120614203914.GA2645@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20120614203914.GA2645@kamineko.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Karol Babioch <karol@babioch.de>, platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On =E4=BA=94, 2012-06-15 at 05:39 +0900, Mattia Dongili wrote:
> On Thu, Jun 14, 2012 at 07:33:05PM +0200, Karol Babioch wrote:
> > Hi,
> >=20
> > I'm a user of the Sony VAIO VPCS12C5E and as such have always strug=
gled
> > with the Linux support of my laptop basically forever. Until now I'=
ve
> > used the patch provided here [1], which worked quite well for some =
time.
> > However since kernel version 3.3 I couldn't change the brightness o=
f my
> > screen anymore.
>=20
> This is not an issue with the platform driver but with the acpi video
> driver.
>=20
so ACPI video driver is used before 3.3 and it works?
please try this patch
https://bugzilla.kernel.org/attachment.cgi?id=3D73576
and boot without acpi_backlight=3Dvendor and see if it helps.

thanks,
rui

> You can boot with acpi_backlight=3Dvendor and get brightness control =
back
> but the issue with acpi_video remains.
>=20
> ...
> > So, I've uploaded a dmesg log when loading the module with the debu=
g
> > option enabled and trying to change the brightness with the fn keys=
 here
> > [2]. Maybe this is already enough to nail the issue down. Otherwise=
 just
> > let me know what you would like to have.
>=20
> please provide your laptop's DSDT table as well.
>=20
> > [1] https://code.google.com/p/vaio-f11-linux/wiki/KernelSupport
> > [2] http://pastebin.com/GRrtp024
>=20
> Thanks
