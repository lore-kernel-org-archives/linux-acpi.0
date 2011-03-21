From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hot plug issue on 2.6.38
Date: Tue, 22 Mar 2011 00:41:50 +0100
Message-ID: <201103220041.51154.rjw@sisk.pl>
References: <201103052254.48515.rjw@sisk.pl> <20110321223408.GA17412@srcf.ucam.org> <20110321233104.GA4334@xanatos>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110321233104.GA4334@xanatos>
Sender: linux-kernel-owner@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, March 22, 2011, Sarah Sharp wrote:
> On Mon, Mar 21, 2011 at 10:34:08PM +0000, Matthew Garrett wrote:
> > Try setting CONFIG_HOTPLUG_PCI_ACPI to y as well, just to rule that out?
> 
> It's set to build as a module, do you want me to compile it in?

Yes, if poss.  But as I said before, please make sure you have the ASPM patch
applied.

Rafael
