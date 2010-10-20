From: "Jan Beulich" <JBeulich@novell.com>
Subject: lost parts of "pci, acpi: reroute PCI interrupt to legacy boot
	 interrupt equivalent" during merge
Date: Wed, 20 Oct 2010 11:03:28 +0100
Message-ID: <4CBEDA90020000780001E290@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@elte.hu, sassmann@redhat.com
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org

The git history shows the complete patch (commit
e1d3a90846b40ad3160bf4b648d36c6badad39ac), but none of the
released versions from .29 onwards have the pieces the patch was
supposed to add to drivers/acpi/pci_irq.c. What happened here? Is
the workaround no longer needed (in which case the other bits
should also be removed to avoid confusion)?

Thanks, Jan

