From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 2/2] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Date: Wed, 10 Apr 2019 18:08:55 -0500
Message-ID: <20190410230855.GN256045@google.com>
References: <cover.1553027719.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <4818f4dfa41bddc3968da4717c453897d4ad5717.1553027719.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190410184124.GF256045@google.com>
 <dc4e2bcf-44c9-1ffb-ab4f-75c04340b8dd@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dc4e2bcf-44c9-1ffb-ab4f-75c04340b8dd@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, keith.busch@intel.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 10, 2019 at 03:12:05PM -0700, sathyanarayanan kuppuswamy wrote:
> On 4/10/19 11:41 AM, Bjorn Helgaas wrote:
> > On Tue, Mar 19, 2019 at 01:47:29PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > As per PCI firmware specification v3.2 ECN
> > > (https://members.pcisig.com/wg/PCI-SIG/document/12614), when firmware
> > > owns Downstream Port Containment (DPC), its expected to use the "Error
> > > Disconnect Recover" (EDR) notification to alert OSPM of a DPC event and
> > > if OS supports EDR, its expected to handle the software state invalidation
> > > and port recovery in OS and let firmware know the recovery status via _OST
> > > ACPI call.
> > > 
> > > Since EDR is a hybrid service, DPC service shall be enabled in OS even
> > > if AER is not natively enabled in OS.

> > > +	bool			native_dpc;
> > This is going to be way too confusing with a "native_dpc" in both the
> > struct pci_host_bridge and the struct dpc_dev.
> Any suggestions? what about native_mode ?

"native_mode" is different but doesn't contain any additional
information.  I haven't worked out what this new symbol actually does;
if it's related to EDR, maybe that could be incorporated somehow?

> > > +		/* Register ACPI notifier for EDR event */
> > "Register handler for System events, one of which is the EDR event"?
> In our case, we only handle EDR event. So I just explicitly mentioned it.

Right.  As a courtesy to the reader, I think it's worth making
the comment match the code, i.e., you can't pass an event type to
acpi_install_notify_handler(), so obviously the handler will be called
for *all* System events.  By saying "one of which is the EDR event",
you give the reader a hint that the handler will have to filter out
the others.

The reason I noticed this is because I read "Register notifier for EDR
event" and wondered to myself "Hmmm, how does this work?  I don't see
anything passed to acpi_install_notify_handler() that would identify
an EDR event."

> > > +	/*
> > > +	 * If EDR support is enabled in OS, then even if AER is not handled in
> > > +	 * OS, DPC service can be enabled.
> > > +	 */
> > >   	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> > > -	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER &&
> > > -	    (pcie_ports_native || host->native_dpc))
> > > +	    ((IS_ENABLED(CONFIG_PCIE_EDR) && !host->native_dpc) ||
> > > +	    (pci_aer_available() && services & PCIE_PORT_SERVICE_AER &&
> > > +	    (pcie_ports_native || host->native_dpc))))
> > Holy cow, I think I'll have to schedule an hour sometime to figure
> > out what's going on here :)
> Please check the previous patch in this series for details related to
> host->native_dpc.

Yeah, I'm just saying that conditional is starting to look pretty
gnarly.  Possibly there's nothing to do about it.

Bjorn
