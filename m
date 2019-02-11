From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC 3/3] perf: arm_spe: Enable ACPI/Platform automatic module
 loading
Date: Mon, 11 Feb 2019 15:35:53 +0000
Message-ID: <20190211153553.GB4792@e107155-lin>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
 <20190209004718.3292087-4-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190209004718.3292087-4-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, catalin.marinas@arm.com, rafael.j.wysocki@intel.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, lenb@kernel.org, Sudeep Holla <sudeep.holla@arm.com>, erik.schmauss@intel.com, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 08, 2019 at 06:47:18PM -0600, Jeremy Linton wrote:
> Lets add the MODULE_TABLE and platform id_table entries so that
> the SPE driver can attach to the ACPI platform device created by
> the core pmu code.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
