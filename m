From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: acpi_find_bmc() and acpi_get_table()
Date: Thu, 19 Jul 2007 12:50:19 -0600
Message-ID: <200707191250.19370.bjorn.helgaas@hp.com>
References: <200702102327.28312.lenb@kernel.org>
	<200707181319.41081.bjorn.helgaas@hp.com>
	<5DDAB7BA7BDB58439DD0EED0B8E9A3AE53C94D@ausx3mpc102.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <5DDAB7BA7BDB58439DD0EED0B8E9A3AE53C94D@ausx3mpc102.aus.amer.dell.com>
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

On Thursday 19 July 2007 10:32:11 am Jordan_Hargrave@dell.com wrote:
> From Bjorn:
> >> In RHEL5 there was a change made to the acpi motherboard driver to
> >> not attach if any of the _CRS values are not I/O ports.
> 
> >Yes.  This is part of linux-2.6-x86_64-memory-hotplug.patch, and it
> >apparently helps fix a bug:
> >  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208445,
> >But I can't read the bugzilla, so I don't know exactly how.  I suspect
> >some hot-addable memory device also had a _CID of PNP0C01, and they
> >had the same problem you now have with IPMI.
> 
> >But making the motherboard driver ignore devices if they have any
> >non-I/O port resources seems like the wrong fix.
> 
> Yeah but it gets even better, that bugfix has a bug itself.. the acpi_walk_resources 
> function also passes the end-of-list (79 00) marker into the callback.  This isn't a
> resource I/O type, so the motherboard object is failing to attach to any PNP0C01
> device.  This is why the IPMI driver can find the IPI0001 device on RHEL5 but not on 
> RHEL4/SLES10/SLES9.

Beginning with 2.6.16, acpi_walk_resources() passes the end tag to
the callback.  We had a little discussion about this in January, 2006:
  http://www.mail-archive.com/linux-acpi%40vger.kernel.org/msg00117.html

The conclusion was that the callback must be able to handle any resource
type (ignoring ones it doesn't know about), so it should be harmless and
potentially useful to pass the end tag to the callback.

RHEL4/SLES10/SLES9 do this correctly (they ignore unknown resource types
and claim PNP0C01 devices, which prevents the IPMI driver from claiming
IPI0001 devices that have PNP0C01 _CIDs).  RHEL5 is broken (bombs out on
unknown resource types and fails to claim PNP0C01 devices, which happens
to make the IPMI driver claim work).

Bjorn


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
