From: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [ACPI] native vs acpi support
Date: Mon, 26 Sep 2005 10:03:14 -0700
Message-ID: <20050926100312.B3471@unix-os.sc.intel.com>
References: <20050912110025.A15668@unix-os.sc.intel.com> <20050924021044.61508.qmail@web35415.mail.mud.yahoo.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hotplug-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050924021044.61508.qmail@web35415.mail.mud.yahoo.com>; from kvidyut2000@yahoo.co.in on Sat, Sep 24, 2005 at 03:10:44AM +0100
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
Cc: Rajesh Shah <rajesh.shah@intel.com>, linux-hotplug-devel@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, greg@kroah.com
List-Id: linux-acpi@vger.kernel.org

On Sat, Sep 24, 2005 at 03:10:44AM +0100, vidyut karan wrote:
> 
>    Section [6.7.8] of pci express specs related to OSHP says that
> 
>    "Some  systems  that  include Hot-Plug capable Root Ports and Switches
>    that  are released before ACPI-compliant operating systems with native
>    Hot-Plug support are available, can use ACPI 
>    firmware  for  propagating  Hot-Plug  events.  Firmware control of the
>    Hot-Plug registers must be disabled if an operating system with native
>    support  is  used.  Platforms  that provide ACPI firmware to propagate
>    Hot-Plug events must also provide a control method to transfer control
>    to the operating system."
> 
The _OSC/OSHP mechanism is there to allow a system to support
hotplug on a variety of OS's, some with and some without native
pcie hotplug capabilities. Firmware could boot with the assumption
that it will control hotplug hardware and the OS will only support
the older acpiphp way of doing hot-plug. Of course, this still
requires acpiphp support in the OS. If the system ends up booting
a version of OS that supports native pcie hotplug, it will run the
OSHP method to tell the BIOS that the OS will now control hotplug
hardware directly. After OSHP is run, the BIOS must not attempt to
control hotplug hardware, and must not generate an ACPI interrupt
when hotplug occurs.

>    
>    I  could  not  understand the above properly.Please help me understand
>    this.  If  a OS is not ACPI compliant will it still be able to use the
>    OSHP  method  provided by ACPI. 

No.

> Or does it mean that ACPI will disable
>    the  firmware  taking  control of Hot plug so that OS can take care of
>    that.
> 
Yes.

> 
>    Also in the native hotpluggin on PCI-Express how the control flows for
>    ACPI and non-ACPI case. For e.g. in linux 2.6.
> 
acpi interrupts are not generated any more for hotplug once native
pcie hotplug is enabled. 

Rajesh


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
