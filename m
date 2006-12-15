From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Large Reference Count warnings
Date: Thu, 14 Dec 2006 17:00:45 -0700
Message-ID: <200612141700.45934.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:56764 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbWLOATy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Dec 2006 19:19:54 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Moore, Robert" <robert.moore@intel.com>

I have the AML below that defines an OpRegion inside the scope of
a method.  The region gets attached (and its ref count incremented)
in this path:

    acpi_ev_attach_region
    acpi_ev_initialize_region
    acpi_ds_load2_end_op
    acpi_ds_exec_end_op
    acpi_ps_parse_loop
    acpi_ps_parse_aml

But I don't see any corresponding place where the ref count gets
decremented.  That only seems to happen via acpi_ev_install_handler()
or acpi_remove_address_space_handler(), neither of which is called
from the interpreter.

I expected the OpRegion to be detached when exiting the LRRD scope.
Is that supposed to happen?

On a large system, we are tripping over warnings like this:

  ACPI Warning (utdelete-0397): Large Reference Count (801) in object e0000a0ff6797ab0 [20060707]

This method is used to access registers in a PCI host bridge, so
we do lots of attaches for the LREG region, which eventually bumps
the ref count above the 0x800 limit.

FWIW, this didn't seem to happen with older kernels, like RHEL4.
I don't know whether the difference is in the ACPI CA or in the
way Linux is using the root bridges.


            Device (L000)
            {
                ...
                Method (LRRD, 6, NotSerialized)
                {
                    Store (Arg0, Local0)
                    Store (Arg1, Local1)
                    Add (Local0, Arg2, Local0)
                    ShiftLeft (Local1, 0x20, Local1)
                    Or (Local0, Local1, Local0)
                    OperationRegion (LREG, SystemMemory, Local0, Arg3)
                    Field (LREG, ByteAcc, NoLock, Preserve)
                    {
                        LRDB,   8
                    }
                    ...
