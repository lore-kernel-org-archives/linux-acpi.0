From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] ACPI: SPCR: Use access width to determine mmio
 usage
Date: Tue, 4 Jul 2017 09:22:51 +0200
Message-ID: <20170704072251.GA17867@kroah.com>
References: <1499117589-4829-1-git-send-email-lho@apm.com>
 <1499117589-4829-2-git-send-email-lho@apm.com>
 <CAJZ5v0gw82WcRomx0b=ZmxdXG4VFP8iCXSoQ_BvArQvOoi90TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:34024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbdGDHWw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Jul 2017 03:22:52 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gw82WcRomx0b=ZmxdXG4VFP8iCXSoQ_BvArQvOoi90TA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Loc Ho <lho@apm.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Jon Mason <jon.mason@broadcom.com>, Jon Masters <jcm@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, patches@apm.com

On Mon, Jul 03, 2017 at 11:44:30PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 3, 2017 at 11:33 PM, Loc Ho <lho@apm.com> wrote:
> > The current SPCR code does not check the access width of the mmio, and
> > uses a default of 8bit register accesses.  This prevents devices that
> > only do 16 or 32bit register accesses from working.  By simply checking
> > this field and setting the mmio string appropriately, this issue can be
> > corrected.  To prevent any legacy issues, the code will default to 8bit
> > accesses if the value is anything but 16 or 32.
> >
> > Signed-off-by: Loc Ho <lho@apm.com>
> > [Re-send as single patch set]
> > Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> 
> Greg, Aleksey, any objections here?
> 
> If not, I'll route this through the ACPI tree.

No objections from me for either of these patches:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
