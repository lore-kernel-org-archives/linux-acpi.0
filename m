From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI / PM: Do not use native PCIe PME by default
Date: Fri, 18 Jun 2010 09:37:01 -0700
Message-ID: <20100618093701.681dc238@virtuousgeek.org>
References: <201006181704.22550.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201006181704.22550.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 18 Jun 2010 17:04:22 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Commit c7f486567c1d0acd2e4166c47069835b9f75e77b
> (PCI PM: PCIe PME root port service driver) causes the native PCIe
> PME signaling to be used by default, if the BIOS allows the kernel to
> control the standard configuration registers of PCIe root ports.
> However, the native PCIe PME is coupled to the native PCIe hotplug
> and calling pcie_pme_acpi_setup() makes some BIOSes expect that
> the native PCIe hotplug will be used as well.  That, in turn, causes
> problems to appear on systems where the PCIe hotplug driver is not
> loaded.  The usual symptom, as reported by Jaroslav Kamen=C3=ADk and
> others, is that the ACPI GPE associated with PCIe hotplug keeps
> firing continuously causing kacpid to take substantial percentage
> of CPU time.
>=20
> To work around this issue, change the default so that the native
> PCIe PME signaling is only used if directly requested with the help
> of the pcie_pme=3D command line switch.
>=20
> Fixes https://bugzilla.kernel.org/show_bug.cgi?id=3D15924 , which is
> a listed regression from 2.6.33.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Reported-by: Jaroslav Kamen=C3=ADk <jaroslav@kamenik.cz>
> Tested-by: Antoni Grzymala <antekgrzymala@gmail.com>=20
> ---

Applied to my for-linus tree, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center
