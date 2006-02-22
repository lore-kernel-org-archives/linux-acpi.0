From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/3] New dock patches
Date: Wed, 22 Feb 2006 11:21:21 -0800
Message-ID: <1140636081.32574.18.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751115AbWBVTR3@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Cc: greg@kroah.com, len.brown@intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz
List-Id: linux-acpi@vger.kernel.org

Hello, this is a new set of docking station patches which replaces
the old docking station patches.  It applies to 2.6.16-rc4-mm1.  It
is new and improved over the old version, in that it can now handle
laptops which define docking stations outside of the scope of PCI.

Thanks to everyone who provided feedback on the original patches, and
especially to Pavel who is the only brave soul to test these patches
out so far :).  As always, I would appreciate feedback on these 
patches.

Kristen
