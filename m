From: Stefan Assmann <sassmann@redhat.com>
Subject: Re: [PATCH 0/5 v2] x86: boot interrupt reroute fix
Date: Tue, 11 Jan 2011 11:38:44 +0100
Message-ID: <4D2C3334.8070305@redhat.com>
References: <20101202153344.29125.86670.sendpatchset@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20101202153344.29125.86670.sendpatchset@localhost6.localdomain6>
Sender: linux-pci-owner@vger.kernel.org
To: jbarnes@virtuousgeek.org
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, JBeulich@novell.com, Olaf.Dabrunz@gmx.net, mingo@elte.hu, bjorn.helgaas@hp.com, tglx@linutronix.de, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On 02.12.2010 16:33, Stefan Assmann wrote:
> During the 2.6.29 merge parts of e1d3a90846b40ad3160bf4b648d36c6badad39ac got
> lost because of other ACPI changes. This patchset gets the reroute code working
> again with the current ACPI code. As suggested by Ingo Molnar the missing boot
> interrupt reroute parts are re-added in separate files.
> Therefore some smaller changes to the ACPI and PCI code are necessary to allow
> the boot interrupt reroute code to access required structures and functionality.
> In detail, the reroute code requires access to:
> - struct acpi_prt_entry
> - pci_find_upstream_pcie_bridge()
> 
> Additionally to not change any information in the global acpi_prt_list it is
> desirable to have acpi_pci_irq_find_prt_entry() return a pointer to a copy of
> a struct acpi_prt_entry instead of pointer into the global acpi_prt_list. The
> callers of acpi_pci_irq_find_prt_entry() have been updated to free the
> allocated structure as well.
> 
> By request of Bjorn Helgaas I've created a bugzilla entry at
> https://bugzilla.kernel.org/show_bug.cgi?id=21882
> to gather information about the boot interrupt reroute problem.
> 
> Jesse Barnes suggested to integrate the changes through the ACPI tree.
> 
> v2:
> - split pci_find_upstream_pcie_bridge() changes into separate patches

No response from the ACPI side.

Jesse,
could you take the PCI changes (patches 3 and 4) through your tree?

  Stefan
--
Stefan Assmann         | Red Hat GmbH
Software Engineer      | Otto-Hahn-Strasse 20, 85609 Dornach
                       | HR: Amtsgericht Muenchen HRB 153243
                       | GF: Brendan Lane, Charlie Peters,
sassmann at redhat.com |     Michael Cunningham, Charles Cachera
