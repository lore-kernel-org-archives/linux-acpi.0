From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [Lhms-devel] [RFC:PATCH(000/003)] Memory add to onlined node. (ver. 2)
Date: Thu, 9 Feb 2006 09:04:43 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05AA16C3@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-ia64-owner@vger.kernel.org
To: Yasunori Goto <y-goto@jp.fujitsu.com>, Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>, "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>, "S, Naveen B" <naveen.b.s@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: ACPI-ML <linux-acpi@vger.kernel.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, x86-64 Discuss <discuss@x86-64.org>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

> - if the node is already online.-  If the node is offline, 
> (It means new node is comming!)  then the memory will belongs
> to node 0 yet.

What is the long term plan to address this?  Can you make sure
that the new node is always brought online before you get to
this code?  Or will you have to bring the node online in the
middle of the memory hot-add code?

Presumably there is a similar issue with hot add cpu.

-Tony
