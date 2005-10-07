From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/2] acpiphp: hotplug adapters with bridges on them
Date: Fri, 07 Oct 2005 10:45:45 -0700
Message-ID: <1128707145.11020.9.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030530AbVJGRqF@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Cc: rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

These 2 patches will allow adapters with p2p bridges on them to be
successfully hotplugged using the acpiphp driver.  Currently, if you
attempt to hotplug an adapter with a p2p bridge on it, the operation
will fail because resources are not allocated to it properly.  These
patches have had very limited testing as I only have one machine and one
type of adapter to test this with.  I tested this with 2.6.14-rc2, but
the patch applies fine to rc3 as well.
