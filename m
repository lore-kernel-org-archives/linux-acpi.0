From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [ACPI] [PATCH] 4 of 6 introduce acpi_global_irq_to_irq()
Date: Tue, 9 Mar 2004 17:09:13 -0700
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <200403091709.13272.bjorn.helgaas@hp.com>
References: <7F740D512C7C1046AB53446D37200173FEB472@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <7F740D512C7C1046AB53446D37200173FEB472@scsmsx402.sc.intel.com>
Content-Disposition: inline
To: "Nakajima, Jun" <jun.nakajima@intel.com>, davidm@hpl.hp.com
Cc: acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org, Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 09 March 2004 5:00 pm, Nakajima, Jun wrote:
> I agree with David. And GSI is more consistent with the ACPI spec, and
> you don't need to explain what it is.

OK, once we get the current patches squared away, I'll prepare a patch
to change to "gsi".  (It will be more extensive, because I think it
makes sense to change the names in include/linux/acpi.h, such as those
in struct acpi_table_ioapic and struct acpi_table_iosapic, at the
same time.)

