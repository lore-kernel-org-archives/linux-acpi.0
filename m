From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 2/2] ia64: add driver for ACPI methods to call native firmware
Date: Wed, 12 Sep 2007 10:50:27 -0600
Message-ID: <200709121050.27668.bjorn.helgaas@hp.com>
References: <200709111714.57095.bjorn.helgaas@hp.com> <200709111716.47194.bjorn.helgaas@hp.com> <20070912085650.GA3015@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20070912085650.GA3015@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-ia64-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ia64@vger.kernel.org, linux-acpi@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 12 September 2007 02:56:51 am Matthew Garrett wrote:
> On Tue, Sep 11, 2007 at 05:16:46PM -0600, Bjorn Helgaas wrote:
> > +config IA64_HP_AML_NFW
> > +	tristate "Support ACPI AML calls to native firmware"
> 
> The description seems a bit generic for something that's HP specific?

Thanks, I'll wordsmith the description a bit.  There's actually nothing
in the implementation that prevents this from working on non-HP firmware.  

I really want feedback on the best approach of:

  1.  Always build the driver static, accept the additional 4600 bytes
      in everybody's image, not export anything.

  2.  Allow building driver as a module, export sal_lock.  This would
      also enable building arch/ia64/kernel/esi.c as a module.

  3.  Allow building driver as a module, restructure SAL_CALL so we
      don't have to export sal_lock, but we do export fw_call_lock()
      (as done in these patches).  This isn't quite sufficient to
      enable building esi.c as a module.

#1 would be easiest, of course, but I'm not happy about adding stuff
that is only used on HP hardware.  #2 would be simple, but exporting
sal_lock has been resisted in the past.

Bjorn
