From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] acpi/hmat: Update acpi_hmat_type enum with
 ACPI_HMAT_TYPE_PROXIMITY
Date: Thu, 18 Apr 2019 08:56:40 -0600
Message-ID: <20190418145640.GA7659@localhost.localdomain>
References: <20190417181310.27613-1-alison.schofield@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190417181310.27613-1-alison.schofield@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alison Schofield <alison.schofield@intel.com>
Cc: rjw@rjwysocki.net, robert.moore@intel.com, erik.schmauss@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 17, 2019 at 11:13:10AM -0700, Alison Schofield wrote:
> ACPI 6.3 changed the subtable "Memory Subsystem Address Range Structure"
> to "Memory Proximity Domain Attributes Structure".
> 
> Updating and renaming of the structure was included in commit:
> ACPICA: ACPI 6.3: HMAT updates (9a8d961f1ef835b0d338fbe13da03cb424e87ae5)

I was not really happy with that HMAT update. Platforms implementing
6.2's HMAT continue to exist even if 6.3 isn't backward compatible. We
just lost the original subtable definition.
