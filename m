From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: IPMI device discovery [was Re: [PATCH ] IPMI:
	Locate the IPMI system interface in ACPI namespace]
Date: Wed, 18 Nov 2009 09:45:44 -0700
Message-ID: <200911180945.45570.bjorn.helgaas@hp.com>
References: <1258363089-26881-1-git-send-email-yakui.zhao@intel.com>
	<200911170759.06902.bjorn.helgaas@hp.com>
	<1258515715.3813.108.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <1258515715.3813.108.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: ykzhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, Myron Stowe <myron.stowe@hp.com>, "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 17 November 2009 08:41:55 pm ykzhao wrote:
>    a. One is to add the support of detection IPMI system interface in
> ACPI namespace, which is a complement of ACPI SPMI detection.

This is not related to your current patch, which adds namespace
detection.  This is a new conversation about how I think we should
make future changes in IPMI device discovery.

The ACPI namespace is the canonical way to enumerate devices that
don't have a native enumeration protocol.  I think the only reason
the SPMI table exists at all is to allow an OS to find an IPMI system
interface during early boot, before the OS is prepared to parse the
ACPI namespace.  Anything described by the SPMI should also be described
in the namespace.

Linux does not need to use IPMI during that early boot phase, so I
think the SPMI detection should be dropped completely, and we should
rely *only* on the ACPI namespace and the PCI enumeration.  We may
have to use SPMI or SMBIOS to work around BIOS defects, but we
shouldn't use them in general.

I have been told that Windows is similar in that it does not use IPMI
during early boot, and that it does not look at the SPMI table at all,
so I think relying on the namespace would be fairly safe.

Bjorn

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
