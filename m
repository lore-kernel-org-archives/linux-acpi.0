From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: acpi_find_bmc() and acpi_get_table()
Date: Wed, 18 Jul 2007 13:19:40 -0600
Message-ID: <200707181319.41081.bjorn.helgaas@hp.com>
References: <200702102327.28312.lenb@kernel.org>
	<5DDAB7BA7BDB58439DD0EED0B8E9A3AE073879@ausx3mpc102.aus.amer.dell.com>
	<5DDAB7BA7BDB58439DD0EED0B8E9A3AE53C94B@ausx3mpc102.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <5DDAB7BA7BDB58439DD0EED0B8E9A3AE53C94B@ausx3mpc102.aus.amer.dell.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Sender: openipmi-developer-bounces@lists.sourceforge.net
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: Jordan_Hargrave@dell.com
Cc: minyard@acm.org, linux-acpi@vger.kernel.org, Matt_Domsch@dell.com, alexey.y.starikovskiy@linux.intel.com, openipmi-developer@lists.sourceforge.net, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 18 July 2007 10:49:58 am Jordan_Hargrave@dell.com wrote:
> I've done some more investigating on this and found why this works
> in RHEL5 but not other releases (RHEL4/SLES9/SLES10). 
> 
> The acpi motherboard driver is claiming all devices with _HID or
> _CID of PNP0C01.  Our BIOS declares the IPI0001 with a _CID of
> PNP0C01, so the acpi motherboard driver normally claims it.  When
> the IPMI driver loads it can't find the IPI0001 device as it is
> already claimed.    

I think this is dumb.  PNP0C01 is a generic "system board" identifier
with no clear programming model that I can see.  What good does it
do to have a _CID of PNP0C01?  The only useful thing that happens in
Linux is that the "motherboard" driver claims PNP0C01 devices and
reserves their resources.  But PNP ought to reserve the resources of
*all* active devices, even if no driver claims them.

So I think this sounds like a BIOS defect.  Of course, I'm sure it's
already in the field, so even if we agree that it's a BIOS problem,
we'd have to work around it in Linux.  What if we had some sort of
quirk that removes that _CID?

> In RHEL5 there was a change made to the acpi motherboard driver to
> not attach if any of the _CRS values are not I/O ports.

Yes.  This is part of linux-2.6-x86_64-memory-hotplug.patch, and it
apparently helps fix a bug:
  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208445,
But I can't read the bugzilla, so I don't know exactly how.  I suspect
some hot-addable memory device also had a _CID of PNP0C01, and they
had the same problem you now have with IPMI.

But making the motherboard driver ignore devices if they have any
non-I/O port resources seems like the wrong fix.

> Technically the only reason it is working in RHEL5 is due to the
> bug of the motherboard driver not attaching. 

Right.  I'm sure you've noticed that the ACPI motherboard driver has
been removed completely upstream.  It's been replaced by the PNP
"system" driver, which claims all PNP0C01 and PNP0C02 devices regardless
of what sort of resources they have.

> So using acpi_bus_register_driver looks like it won't work as a general solution.
> I'm investigating walking the whole namespace to detect the IPI0001 device.

I think we should make acpi_bus_register_driver() work.  It looks like
we already have two cases (IPMI and memory hotplug), so I'd like to
have a general solution rather than a collection of workarounds.

Bjorn


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
