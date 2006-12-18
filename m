From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend to RAM on lifebook 7110
Date: Mon, 18 Dec 2006 21:00:41 +0100
Message-ID: <200612182100.42186.rjw@sisk.pl>
References: <20061208123358.GA3724@invalid.invalid>
	<20061218120551.GA27546@srcf.ucam.org>
	<20061218174851.GE13541@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061218174851.GE13541@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Stefan Seyfried <seife@suse.de>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Miroslav Ruda <ruda@ics.muni.cz>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, 18 December 2006 18:48, Stefan Seyfried wrote:
> On Mon, Dec 18, 2006 at 12:05:51PM +0000, Matthew Garrett wrote:
> > On Mon, Dec 18, 2006 at 12:29:16PM +0100, Stefan Seyfried wrote:
> 
> > >  - implement this as a workaround in userspace?
> > 
> > Might be easier for the moment, though I agree that it's less than 
> > ideal.
> 
> Ok, so how about that (compiled, not really tested. I tested the 
> "save_vga_pci" by outputting to a file and comparing to /proc and sysfs),
> but i have no hardware here that needs this:
> 
> Warning: watch out for my maybe creative usage of "*" and "&" and complain
> if you find obvious errors ;-)
> 
> Index: s2ram.c
> ===================================================================
> RCS file: /cvsroot/suspend/suspend/s2ram.c,v
> retrieving revision 1.45
> diff -u -p -r1.45 s2ram.c
> --- s2ram.c	20 Sep 2006 16:23:51 -0000	1.45
> +++ s2ram.c	18 Dec 2006 16:44:47 -0000
> @@ -11,12 +11,16 @@
>  #include <errno.h>
>  #include <string.h>
>  
> +#include <pci/pci.h>
> +
>  #define S2RAM
>  #include "vbetool/vbetool.h"
>  #include "vt.h"
>  #include "s2ram.h"
>  
>  static void *vbe_buffer;
> +unsigned char vga_pci_state[256];
> +struct pci_dev vga_dev;
>  /* Flags set from whitelist */
>  static int flags, vbe_mode = -1;
>  char bios_version[1024], sys_vendor[1024], sys_product[1024], sys_version[1024];
> @@ -36,6 +40,7 @@ char bios_version[1024], sys_vendor[1024
>  #define UNSURE      0x20	/* unverified entries from acpi-support 0.59 */
>  #define NOFB        0x40	/* must not use a frame buffer */
>  #define VBE_MODE    0x80	/* machine needs "vbetool vbemode get / set" */
> +#define PCI_SAVE   0x100	/* we need to save the VGA PCI registers */
>  
>  #include "whitelist.c"
>  
> @@ -67,14 +72,15 @@ void machine_known(int i)
>  	       "    bios_version = '%s'\n", i,
>  	       whitelist[i].sys_vendor, whitelist[i].sys_product,
>  	       whitelist[i].sys_version, whitelist[i].bios_version);
> -	printf("Fixes: 0x%x  %s%s%s%s%s%s%s\n", flags,
> +	printf("Fixes: 0x%x  %s%s%s%s%s%s%s%s\n", flags,
>  	       (flags & VBE_SAVE) ? "VBE_SAVE " : "",
>  	       (flags & VBE_POST) ? "VBE_POST " : "",
>  	       (flags & VBE_MODE) ? "VBE_MODE " : "",
>  	       (flags & RADEON_OFF) ? "RADEON_OFF " : "",
>  	       (flags & S3_BIOS) ? "S3_BIOS " : "",
>  	       (flags & S3_MODE) ? "S3_MODE " : "",
> -	       (flags & NOFB) ? "NOFB " : "");
> +	       (flags & NOFB) ? "NOFB " : "",
> +	       (flags & PCI_SAVE) ? "PCI_SAVE " : "");
>  	if (flags & UNSURE)
>  		printf("Machine is in the whitelist but perhaps using "
>  		       "vbetool unnecessarily.\n"
> @@ -143,6 +149,35 @@ int s2ram_check(int id)
>  	return ret;
>  }
>  
> +struct pci_dev find_vga(void)
> +{
> +	struct pci_access *pacc;
> +	struct pci_dev *dev;
> +
> +	pacc = pci_alloc();	/* Get the pci_access structure */
> +	pci_init(pacc);		/* Initialize the PCI library */
> +	pci_scan_bus(pacc);	/* We want to get the list of devices */
> +
> +	for (dev=pacc->devices; dev; dev=dev->next) {
> +		pci_fill_info(dev, PCI_FILL_IDENT | PCI_FILL_CLASS);
> +		if (dev->device_class == 0x300)
> +			break;
> +	}
> +	pci_cleanup(pacc);
> +
> +	return *dev;
> +}

Hm, I'd rather return the pointer (eg. so that the structure can be freed).

> +
> +void save_vga_pci(struct pci_dev dev)

A pointer here?

> +{
> +	pci_read_block(&dev, 0, vga_pci_state, 256);
> +}
> +
> +void restore_vga_pci(struct pci_dev dev)

And here?

> +{
> +	pci_write_block(&dev, 0, vga_pci_state, 256);
> +}
> +
>  /* warning: we have to be on a text console when calling this */
>  int s2ram_hacks(void)
>  {
> @@ -171,6 +206,12 @@ int s2ram_hacks(void)
>  		printf("Calling radeon_cmd_light(0)\n");
>  		radeon_cmd_light(0);
>  	}
> +	if (flags & PCI_SAVE) {
> +		vga_dev = find_vga();

Could vga_dev be a pointer?

> +		printf("saving PCI config of device %02x:%02x.%d\n",
> +			 vga_dev.bus, vga_dev.dev, vga_dev.func);
> +		save_vga_pci(vga_dev);
> +	}
>  
>  	return 0;
>  }
> @@ -216,6 +257,11 @@ int s2ram_do(void)
>  
>  void s2ram_resume(void)
>  {
> +	if (flags & PCI_SAVE) {
> +		printf("saving PCI config of device %02x:%02x.%d\n",
> +			 vga_dev.bus, vga_dev.dev, vga_dev.func);
> +		restore_vga_pci(vga_dev);
> +	}
>  	// FIXME: can we call vbetool_init() multiple times without cleaning up?
>  	if (flags & VBE_POST) {
>  		vbetool_init();
> @@ -260,6 +306,7 @@ static void usage(void)
>  	       "    -a, --acpi_sleep: set the acpi_sleep parameter before "
>  				       "suspend\n"
>  	       "                      1=s3_bios, 2=s3_mode, 3=both\n"
> +	       "    -v, --pci_save:   save the PCI config space for the VGA card.\n"
>  	       "\n");
>  	exit(1);
>  }
> @@ -278,10 +325,11 @@ int main(int argc, char *argv[])
>  		{ "radeontool",	no_argument,		NULL, 'r'},
>  		{ "identify",	no_argument,		NULL, 'i'},
>  		{ "acpi_sleep",	required_argument,	NULL, 'a'},
> +		{ "pci_save",	no_argument,		NULL, 'v'},
>  		{ NULL,		0,			NULL,  0 }
>  	};
>  
> -	while ((i = getopt_long(argc, argv, "nhfspmria:", options, NULL)) != -1) {
> +	while ((i = getopt_long(argc, argv, "nhfspmriva:", options, NULL)) != -1) {
>  		switch (i) {
>  		case 'h':
>  			usage();
> @@ -311,6 +359,9 @@ int main(int argc, char *argv[])
>  		case 'a':
>  			flags |= (atoi(optarg) & (S3_BIOS | S3_MODE));
>  			break;
> +		case 'v':
> +			flags |= PCI_SAVE;
> +			break;
>  		default:
>  			usage();
>  			break;
> 

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
