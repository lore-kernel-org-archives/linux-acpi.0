From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Date: Fri, 5 Nov 2004 17:45:23 +0100
Message-ID: <20041105164523.GC1295@stusta.de>
References: <20041105001328.3ba97e08.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262721AbUKEQqJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041105001328.3ba97e08.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>, rml@novell.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, len.brown@intel.com, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

The following error (compin from Linus' tree) is caused by the fact that 
hotplug_path is no longer EXPORT_SYMBOL'ed:


<--  snip  -->

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.10-rc1-mm3; fi
WARNING: /lib/modules/2.6.10-rc1-mm3/kernel/drivers/acpi/container.ko needs unknown symbol hotplug_path

<--  snip  -->
