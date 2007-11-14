From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Wed, 14 Nov 2007 18:55:21 +0900
Message-ID: <473AC609.2050204@jp.fujitsu.com>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113170129.GA20185@kroah.com> <20071113202154.GA22812@ldl.fc.hp.com> <20071113202632.GA3227@kroah.com> <473A2A61.7030303@hp.com> <20071113225605.GA2589@suse.de> <20071113230400.GP17785@parisc-linux.org> <20071113153314.ba46cdf0.kristen.c.accardi@intel.com> <20071114001008.GQ17785@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756749AbXKNKAe@vger.kernel.org>
In-Reply-To: <20071114001008.GQ17785@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Greg KH <gregkh@suse.de>, Rick Jones <rick.jones2@hp.com>, Greg KH <greg@kroah.com>, Alex Chiang <achiang@hp.com>, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Matthew Wilcox ????????:
> On Tue, Nov 13, 2007 at 03:33:14PM -0800, Kristen Carlson Accardi wrote:
>> As far as being able to retrieve the slot number (which it seemed from
>> the HP manageablity application perspective is the goal here), that
>> information is available from userspace as well for at least standard PCI
>> and pcie based systems for occupied slots.  For standard pci, you have
>> to make something up anyway - for shpchp we just use an incremental 
>> number and combine it with the bus number to represent the slot.  For
>> pcie, you can get this info from the slot capabilities register.
> 
> Ummm ... that's not what the /spec/ says.  I've never worked on any shpc
> machines, but the shpc driver reads the slot values from the SLOT_CONFIG
> register, just like the spec says to.
> 

The slot number for shpc slot is like 'YYYY_XXXX'.

YYYY is the bus number, though I don't know the specific reason
why it was added.

XXXX is slot number decided according to the shpc specification,
as you said.

Thanks,
Kenji Kaneshige
