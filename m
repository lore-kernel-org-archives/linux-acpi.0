From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH] Xen/ACPI: support sleep state entering
 on hardware reduced systems
Date: Mon, 11 Mar 2013 13:32:17 +0000
Message-ID: <513DEAF102000078000C496E@nat28.tlf.novell.com>
References: <513DB68E02000078000C4864@nat28.tlf.novell.com>
 <20130311132127.GH23018@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:58113 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab3CKNcW convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:7:1>);
	Mon, 11 Mar 2013 09:32:22 -0400
In-Reply-To: <20130311132127.GH23018@phenom.dumpdata.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Gang Wei <gang.wei@intel.com>, richard.l.maliszewski@intel.com, Shane Wang <shane.wang@intel.com>, Len Brown <lenb@kernel.org>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xen.org>, rjw@sisk.pl, linux-acpi@vger.kernel.org

>>> On 11.03.13 at 14:21, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> Could the commit should also mention what version of the Xen hypervisor
> supports this new flag and takes action on it?

Do you really think this is needed? I generally try to stay away
from doing such, since backports can easily invalidate such
statements.

> Besides that little nit-pick it looks OK to me. Are there any changes
> neccessary on the IA64 or ARM side for this?

Xen on IA64 is dead, so I don't see any need for further action
there. And I don't think ARM has any ACPI enablement so far (on
the Xen side at least).

Jan

