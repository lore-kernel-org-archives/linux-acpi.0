From: Rajat Jain <rajat.noida.india@gmail.com>
Subject: ACPI problem with PCI Express Native Hot-plug driver
Date: Fri, 2 Sep 2005 16:57:33 +0900
Message-ID: <b115cb5f0509020057741365dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030451AbVIBH5h@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-newbie@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Cc: greg@kroah.com, dkumar@noida.hcltech.com, sanjayku@noida.hcltech.com
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm using RHEL4 kernel (2.6.9), and am trying to make PCI Express
Native Hot-plug driver (pciehp) work on my system (My system has two
hot-pluggable PCI Express slots). I am facing following problem, and
would really appreciate if any one can provide any info regarding this
problem.

When I disable the ACPI support in my kernel configuration, the
("non-acpi") pciehp driver inserts successfully and I see the
following two entries appearing in my /sys/bus/pci/slots:

drwxr-xr-x  2 root root 0 Sep  2 14:28 10
drwxr-xr-x  2 root root 0 Sep  2 14:28 11

However, when I enable the ACPI support in the kernel, the controller
initialization fails giving me following error (excerpts):

......
......
pciehp: pfar:cannot locate acpi bridge of PCI 0xb.
pciehp: pciehprm_find_available_resources = 0xffffffff
pciehp: unable to locate PCI configuration resources for hot plug add.
......
......
pciehp: pfar:cannot locate acpi bridge of PCI 0xe.
pciehp: pciehprm_find_available_resources = 0xffffffff
pciehp: unable to locate PCI configuration resources for hot plug add.
......
......

I am attaching both the logs (The one with ACPI enabled and giving
this error, the other - ACPI disabled and displaying the slot
entries). I am not sure where the problem lies. But the fact that the
entries are appearing correctly when I disable ACPI, combined with
above error messages, I suspect that there is a problem with ACPI
namespace (probably the resources cannot be found using ACPI).

I have two questions:

1) How can I go about tackling this problem? The possibility of BIOS /
Hardware being faulty cannot be ruled out. But then what exactly is
missing and how can that be solved?

2) If the resources are actually missing, then how does the driver
find the required resources when I disable the ACPI from kernel?

Even if no body had faced this problem before, I would really
appreciate if any one can provide ANY kind of pointers / information
regarding this (As I am willing to explore and solve this, no matter
what :-))

TIA

Rajat Jain
