From: Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>
Subject: Re: [PATCH] ACPI update (20030122)
Date: Fri, 24 Jan 2003 00:00:40 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030124000040.GB18596@codemonkey.org.uk>
References: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A131-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 23, 2003 at 02:44:55PM -0800, Grover, Andrew wrote:

 > The latest ACPI patch is now available at http://sf.net/projects/acpi .
 > Non-Linux packages will be available within 24 hours from
 > http://developer.intel.com/technology/iapc/acpi/downloads.htm .

I've noticed that with .59 some of my boxes no longer have
functioning NICs unless I boot with acpi=off. Packets get
transmitted, but nothing ever gets received.
Seen this with a 3c509, an 8139, and an e100.

Known bug? Fixed in this patch ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
