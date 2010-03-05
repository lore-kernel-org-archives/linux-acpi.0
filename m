From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 2/4] ipmi: Remove SPMI table based
	device discovery method
Date: Fri, 5 Mar 2010 09:06:20 -0700
Message-ID: <201003050906.21122.bjorn.helgaas@hp.com>
References: <20100304033146.30205.68689.stgit@bob.kio>
	<1267728420.2437.162.camel@zim>
	<E0AA796A7E3F4C4E8F1065D15FE478610176ABB8AD@EXCH-MBX-4.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <E0AA796A7E3F4C4E8F1065D15FE478610176ABB8AD@EXCH-MBX-4.vmware.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: Bela Lubkin <blubkin@vmware.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, 'Myron Stowe' <myron.stowe@hp.com>, "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 05 March 2010 05:58:12 am Bela Lubkin wrote:
> It gives you twice as many chances to find a sufficiently
> non-buggy table to get on with your work ;-}

I think this is the wrong way to look at it.  I don't want a
"let's try a bunch of things, maybe one will work" plan.  In my
opinion, it's better to have a single strategy that everybody
uses because that one way becomes well-tested and well-understood.

Windows only looks at ACPI namespace and PCI, and the obvious
consequence is that those mechanisms are tested and tend to work.

Linux uses SPMI and SMBIOS and (until recently) ignored the ACPI
namespace.  SPMI and SMBIOS are redundant copies of what's in the
namespace, and that redundancy makes inconsistencies more likely.

The result is that (a) we waste the BIOS engineers' time because
they have to implement multiple descriptions, (b) we waste our
time resolving inconsistencies between the descriptions, and (c)
we delay finding and fixing bugs in the canonical ACPI namespace
descriptions.

Bjorn

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
