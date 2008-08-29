From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Documentation: Provide Documenation/udev.txt
Date: Fri, 29 Aug 2008 17:05:37 +0200
Message-ID: <200808291705.38954.trenn@suse.de>
References: <20080205021658.4422.83165.stgit@pacifica> <200808272121.54882.carlos@strangeworlds.co.uk> <20080827204449.GA14925@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51983 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbYH2PFl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Aug 2008 11:05:41 -0400
In-Reply-To: <20080827204449.GA14925@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Kay Sievers <kay.sievers@vrfy.org>

Subject was:
Re: [PATCH 4/5] ACPI: WMI: Add sysfs userspace interface

On Wednesday 27 August 2008 22:44:49 Matthew Garrett wrote:
> On Wed, Aug 27, 2008 at 09:21:54PM +0100, Carlos Corbacho wrote:
> > Can we abuse uevent and cram all the GUID's into just one MODALIAS line?
>
> Looking at the udev rules, I suspect we need one event per GUID.
>
> > Alternatively, maybe just have the directories numbered 1 to X, and have
> > a uevent file under each, since we don't care about trying to abuse sysfs
> > to let userspace talk to WMI anymore.
>
> Yeah, that'd work for me.

You should add Kay if you get stuck...
Based on Kay's recent description on the linux-acpi list I set up
this documentation. IMO it's worth adding, Andi, Kay?

      Thomas

-----
From: Kay Sievers <kay.sievers@vrfy.org>
Documentation: Add udev.txt based on Kay's short summary

Signed-off-by: Thomas Renninger <trenn@suse.de>

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 5b5aba4..ce9dd7a 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -361,6 +361,8 @@ time_interpolators.txt
 	- info on time interpolators.
 tty.txt
 	- guide to the locking policies of the tty layer.
+udev.txt
+	- How autoloading of modules work.
 uml/
 	- directory with information about User Mode Linux.
 unicode.txt
diff --git a/Documentation/udev.txt b/Documentation/udev.txt
new file mode 100644
index 0000000..ceb0e40
--- /dev/null
+++ b/Documentation/udev.txt
@@ -0,0 +1,37 @@
+Maintainer of udev: Kay Sievers <kay.sievers@vrfy.org>
+
+Abstract:
+This is about getting a specific driver automatically loaded
+at boot time via udev. Depending on whether the kernel detects
+that the HW, the driver is supporting, is available.
+
+
+Devices, any kind of device, can export a match, based on specific
+properties of the subsystem it belongs to. In most cases its the same
+property/id that is used inside the kernel, to find a (already loaded)
+driver which will bind this device. 
+
+Any unique string, hardware ID's, whatever, are stuffed into a modalias,
+prefixed by "<subsystem>:" to be unique.
+
+PCI and USB are pretty obvious, they just stuff all their hardware ID'S
+into a string, in a defined order, and let every device export that value
+to userspace by MODALIAS environment key and the "modalias" sysfs file.
+Other subsystem may have simple strings to match, they define
+themselves.
+
+Now, the drivers contain "match id tables" which are used by the core
+to bind devices to drivers. These tables area made available to
+file2alias.c in the module postprocessing, and will end up in the
+module file itself. The string is mangled to contain wildcards, so
+they can just be fnmatch()'d against the modalias value, which the
+devices export.
+
+The string embedded in the modules are extracted by depmod, and put
+into the modules.aliases file in /lib/modules/. Every time modprobe
+is called with an alias, it searches through this file and loads all
+modules which contained a matching alias string.
+
+Udev does nothing but stupidly running modprobe for every device which
+contains MODALIAS in the event environment, and passes $MODALIAS as
+an argument to modprobe.
