From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Acer Aspire V7-582PG (Haswell, GTX 750M) fails to power off GPU
 via Power Resources
Date: Fri, 28 Oct 2016 14:19:07 +0300
Message-ID: <20161028111907.GD23812@lahna.fi.intel.com>
References: <20161026225641.GA27017@al>
 <20161027081748.GX1476@lahna.fi.intel.com>
 <20161027090604.GB27017@al>
 <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
 <20161027093011.GZ1476@lahna.fi.intel.com>
 <CANni8her35iORgrZOkDzxhfVaOOzObTLG2Ly0kkNZPDTrbyfQQ@mail.gmail.com>
 <20161027095508.GA1476@lahna.fi.intel.com>
 <20161027160648.GF27017@al>
 <20161028085630.GD1476@lahna.fi.intel.com>
 <20161028110930.GA1521@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64983 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751993AbcJ1LT2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Oct 2016 07:19:28 -0400
Content-Disposition: inline
In-Reply-To: <20161028110930.GA1521@al>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
Cc: Rick Kerkhof <rick.2889@gmail.com>, linux-acpi@vger.kernel.org, nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org, Robert Moore <Robert.Moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

On Fri, Oct 28, 2016 at 01:09:30PM +0200, Peter Wu wrote:
> On Fri, Oct 28, 2016 at 11:56:30AM +0300, Mika Westerberg wrote:
> > On Thu, Oct 27, 2016 at 06:06:48PM +0200, Peter Wu wrote:
> > > On Thu, Oct 27, 2016 at 12:55:08PM +0300, Mika Westerberg wrote:
> > > > On Thu, Oct 27, 2016 at 09:42:28AM +0000, Rick Kerkhof wrote:
> > > > >    No, there are not. Here is the recursive directory listing:
> > > > 
> > > > Are you able to try the following patch and send me dmesg (or attach it
> > > > to that bug)? It should show if the ACPI core even tries to add those
> > > > power resources.
> > > 
> > > So Rick has tested this patch now on top of 4.8.4 (mainline fails to
> > > boot due to a kbuild issue which I reported elsewhere), but the output
> > > is empty. That seems to indicate that flags.power_resources is unset.
> > 
> > Is it completely empty or is it empty just for RP05? It should print out
> > all devices with power resources.
> 
> \NVP2 and \NVP3 are the only power resources under RP05 and defined in
> SSDT1, there are no others.

We should probably add a debug print before checking
flags.power_resources just to be sure the patch is correctly applied.
