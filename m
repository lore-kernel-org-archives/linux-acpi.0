From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: AML method concurrency
Date: Tue, 29 May 2007 14:54:27 -0600
Message-ID: <200705291454.27905.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:55057 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbXE2Uyh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 May 2007 16:54:37 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Can AML methods be executed concurrently?

The existence of mutexes, serialized methods, and the Linux
"acpi_serialize" parameter makes me think that in general, we
should be able to execute multiple AML methods concurrently.

However, the ACPI CA Programmer Reference, rev 1.16, section 2.2.5,
says:

  The specification states that at most one control method can be
  actually executing AML code at any given time.  ...  it can be
  said that the specification precludes the concurrent execution
  of control methods.

It is referring to the ACPI specification, but I don't see any
explicit statement there.  I've been pointed to this text from
ACPI 3.0, section 5.5.2:

  Interpretation of a Control Method is not preemptive, but it can
  block.  When a control method does block, the operating software
  can initiate or continue the execution of a different control
  method.

But this doesn't actually say anything about concurrency.

If ACPI does in fact preclude concurrent method execution, can you
point me to discussion of this in the ACPI spec?

Bjorn
