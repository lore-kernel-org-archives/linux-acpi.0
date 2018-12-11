From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCHv2 01/12] acpi: Create subtable parsing infrastructure
Date: Tue, 11 Dec 2018 10:44:32 +0100
Message-ID: <CAJZ5v0iqC2CwR2nM7eF6pDcJe2Me-_fFekX=s16-1TGZ6f6gcA@mail.gmail.com>
References: <20181211010310.8551-1-keith.busch@intel.com> <20181211010310.8551-2-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211010310.8551-2-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 11, 2018 at 2:05 AM Keith Busch <keith.busch@intel.com> wrote:
>
> Parsing entries in an ACPI table had assumed a generic header structure
> that is most common. There is no standard ACPI header, though, so less
> common types would need custom parsers if they want go through their
> sub-table entry list.

It looks like the problem at hand is that acpi_hmat_structure is
incompatible with acpi_subtable_header because of the different layout
and field sizes.

If so, please state that clearly here.

With that, please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch.
