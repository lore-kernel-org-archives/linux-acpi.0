From: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: problem in allocating resources for
Date: Fri, 30 Sep 2005 11:42:08 -0700
Message-ID: <20050930114207.A28328@unix-os.sc.intel.com>
References: <20050926100312.B3471@unix-os.sc.intel.com> <20050928140814.28476.qmail@web35410.mail.mud.yahoo.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hotplug-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050928140814.28476.qmail@web35410.mail.mud.yahoo.com>; from kvidyut2000@yahoo.co.in on Wed, Sep 28, 2005 at 03:08:14PM +0100
Sender: linux-hotplug-devel-admin@lists.sourceforge.net
Errors-To: linux-hotplug-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-hotplug-devel@lists.sourceforge.net>
List-Help: <mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-hotplug-devel>
To: vidyut karan <kvidyut2000@yahoo.co.in>
Cc: linux-hotplug-devel@lists.sourceforge.net, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Wed, Sep 28, 2005 at 03:08:14PM +0100, vidyut karan wrote:
> 
>    While  inserting  pciehp.ko  module(for  native  hot  plug PCI Express
>    support, ACPI enabled), the following messages appear:
> 
>    "pciehp: pciehp: controller initialization failed".
> 
>    Can somebody give me some pointers where the problem possibly lies.
> 
Please provide the full dmesg output, preferably with pciehp_debug
set to 1. Most of the time I've seen the error happen on systems
that don't support native pci express hotplug.

Rajesh


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
