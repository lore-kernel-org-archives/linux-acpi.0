From: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [ACPI] native vs acpi support
Date: Mon, 12 Sep 2005 11:00:25 -0700
Message-ID: <20050912110025.A15668@unix-os.sc.intel.com>
References: <20050912071649.22726.qmail@web35406.mail.mud.yahoo.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hotplug-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050912071649.22726.qmail@web35406.mail.mud.yahoo.com>; from kvidyut2000@yahoo.co.in on Mon, Sep 12, 2005 at 08:16:49AM +0100
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
Cc: linux-hotplug-devel@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, greg@kroah.com
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 12, 2005 at 08:16:49AM +0100, vidyut karan wrote:
> 
>    What is the difference betwwen an
> 
>    OS with an "native hot plug support"
> 
An OS that has hotplug support as described in the PCI Express
specification. This is supported by the pciehp driver.

>    and controlling the hot-plug by using ACPI.
> 
An OS that has hotplug support as described in the ACPI
specification. This is supported by the acpiphp driver.

Native pcie hotplug is newer and better, since it describes a
usage model (e.g. attention buttons, indicators etc.) and
standardizes the programming interface to the hotplug
hardware. 

> 
>    If  my  query sounds idiotic, give me some pointers so that i can move
>    on the right track.
> 
See the PCI hotplug specification and PCI Express specification
from the PCI SIG, and the ACPI specification from 
http://www.acpi.info/.

Rajesh


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
