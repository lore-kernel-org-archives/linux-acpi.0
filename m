From: Greg KH <gregkh@linuxfoundation.org>
Subject: ACPI errors with 3.7-rc3
Date: Tue, 30 Oct 2012 18:45:27 -0700
Message-ID: <20121031014527.GA2984@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Len and Rafael,

With 3.7-rc3, I'm seeing a constant stream of these errors in the kernel
log for my MacBook Pro:

[30443.430133] ACPI: EC: input buffer is not empty, aborting transaction
[30443.430145] ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20120913/evregion-501)
[30443.430162] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.EC__.SMB0.SBRW] (Node ffff88045cc64618), AE_TIME (20120913/psparse-536)
[30443.430179] ACPI Error: Method parse/execution failed [\_SB_.BAT0.UBST] (Node ffff88045cc64988), AE_TIME (20120913/psparse-536)
[30443.430188] ACPI Error: Method parse/execution failed [\_SB_.BAT0._BST] (Node ffff88045cc648c0), AE_TIME (20120913/psparse-536)
[30443.430202] ACPI Exception: AE_TIME, Evaluating _BST (20120913/battery-464)

They never showed up before in 3.7-rc2.

Anything I should try out to resolve this?

thanks,

greg k-h
