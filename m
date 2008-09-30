From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/2] PNP: don't check disabled PCI BARs for conflicts in
 quirk_system_pci_resources()
Date: Tue, 30 Sep 2008 11:01:38 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0809301052200.3436@nehalem.linux-foundation.org>
References: <200809290953.56565.bjorn.helgaas@hp.com> <200809290957.59813.bjorn.helgaas@hp.com> <alpine.LFD.1.10.0809290912060.3265@nehalem.linux-foundation.org> <48E11EFA.8010402@keyaccess.nl> <alpine.LFD.2.00.0809291211330.3389@nehalem.linux-foundation.org>
 <48E1EF0E.8030006@keyaccess.nl> <alpine.LFD.2.00.0809300741320.3389@nehalem.linux-foundation.org> <48E24C6F.3030903@keyaccess.nl> <alpine.LFD.2.00.0809300904530.3389@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753744AbYI3SD0@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0809300904530.3389@nehalem.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Frans Pop <elendil@planet.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>, Avuton Olrich <avuton@gmail.com>, Karl Bellve <karl.bellve@umassmed.edu>, Willem Riede <wriede@riede.org>, Matthew Hall <mhall@mhcomputing.net>
List-Id: linux-acpi@vger.kernel.org



On Tue, 30 Sep 2008, Linus Torvalds wrote:
> 
> In contrast, the PnP fixup thing is called from pnp_fixup_device, called 
> from __pnp_add_device(), called from pnp_add_device() (and 
> pnp_add_card(), but that should be later), and those in turn from
> pnpacpi_add_device and pnpacpi_init(). 
> 
> And pnpacpi_init is _also_ a subsys_initcall [...]

Btw, why is that? We very much have a separate

	/**
	 * Reserve motherboard resources after PCI claim BARs,
	 * but before PCI assign resources for uninitialized PCI devices
	 */
	fs_initcall(pnp_system_init);

which is called much later. That seems to be the _right_ point for any 
quirks. It seems that the _real_ problem here is that the PnP device fixup 
is simply called from the wrong point. Ie, why do we do device discovery - 
and thus PnP quirks - in pnp_init (before the PCI bus is actually fully 
initialized!), rather than in pnp_system_init?

Ie, maybe the proper thing to do is to simply be *consistent* in the PnP 
subsystem, and always use fs_initcall (for the stated reasons!) for the 
device discovery. Ie the patch would be something like the appended, and 
then you really can depend on the PCI subsystem having been set up, 
including having all relevant resources inserted into the tree!

Hmm?  Bjorn? Everything that is true about "pnp_system_init" should be 
equally true abote pnpacpi_init and pnpbios_init, no?

			Linus

---
 drivers/pnp/pnpacpi/core.c |    2 +-
 drivers/pnp/pnpbios/core.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index c1b9ea3..53561d7 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -268,7 +268,7 @@ static int __init pnpacpi_init(void)
 	return 0;
 }
 
-subsys_initcall(pnpacpi_init);
+fs_initcall(pnpacpi_init);
 
 static int __init pnpacpi_setup(char *str)
 {
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index 19a4be1..662dfcd 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -571,7 +571,7 @@ static int __init pnpbios_init(void)
 	return 0;
 }
 
-subsys_initcall(pnpbios_init);
+fs_initcall(pnpbios_init);
 
 static int __init pnpbios_thread_init(void)
 {
