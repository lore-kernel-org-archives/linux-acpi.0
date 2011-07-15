From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 08/17] ACPI, APEI, GHES, Support disable GHES at boot time
Date: Fri, 15 Jul 2011 09:33:49 -0400
Message-ID: <20110715133349.GX3765@redhat.com>
References: <1310534068-30547-1-git-send-email-ying.huang@intel.com>
 <1310534068-30547-9-git-send-email-ying.huang@intel.com>
 <20110714144716.GA3080@redhat.com>
 <4E1F8A44.8080609@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203Ab1GONeC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Jul 2011 09:34:02 -0400
Content-Disposition: inline
In-Reply-To: <4E1F8A44.8080609@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Jul 15, 2011 at 08:31:00AM +0800, Huang Ying wrote:
> On 07/14/2011 10:47 PM, Don Zickus wrote:
> > On Wed, Jul 13, 2011 at 01:14:19PM +0800, Huang Ying wrote:
> >> Some machine may have broken firmware so that GHES and firmware first
> >> mode should be disabled.  This patch adds support to that.
> > 
> > Does this still work if you have disabled ghes module support in the
> > previous patch?
> 
> Yes.  Module param can be specified in kernel command line, for example
> "ghes.disable=y".

Ok.  I just tested that too.  Didn't realize a built-in could still use
module params.

Tested-and-Reviewed-by: Don Zickus <dzickus@redhat.com>
