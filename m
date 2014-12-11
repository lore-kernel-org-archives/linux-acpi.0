From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1] ACPI / Fan: Use bus id for non PNP0C0B (Fan) device
Date: Thu, 11 Dec 2014 22:03:03 +0100
Message-ID: <1703289.SOjM2Vqzvg@vostro.rjw.lan>
References: <1418170540-8349-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1513887.Yep6z7hHDZ@vostro.rjw.lan> <1418253516.740.101.camel@spandruv-desktop.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54775 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758980AbaLKUl3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Dec 2014 15:41:29 -0500
In-Reply-To: <1418253516.740.101.camel@spandruv-desktop.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Wednesday, December 10, 2014 03:18:36 PM Srinivas Pandruvada wrote:
> On Wed, 2014-12-10 at 22:53 +0100, Rafael J. Wysocki wrote: 
> > On Tuesday, December 09, 2014 04:15:40 PM Srinivas Pandruvada wrote:
> > > The _ART (Active Cooling Relationship Table), specifies relationship
> > > among heat generating sources to a target active cooling device like
> > > fan. The _ART table refers to actual bus id name for specifying relationship.
> > > Naming "Fan" is not enough as name in the _ART table can change on every
> > > platform, to establish relationship for user space thermal controllers.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > 
> > I can apply this or do you have any thermal material depending on it?
> This patch can go independently as no thermal patches depends on this.

OK, applied.  Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
