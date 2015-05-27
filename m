From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] ACPI / property: Define a symbol for PRP0001
Date: Tue, 26 May 2015 21:50:05 -0700
Message-ID: <20150527045005.GC21644@fury.dvhart.com>
References: <1703975.P7AUE5bA3t@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1703975.P7AUE5bA3t@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 22, 2015 at 04:24:34AM +0200, Rafael Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use a #defined symbol ACPI_DT_NAMESPACE_HID instead of the PRP0001
> string.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

That's a worthy improvement for both legibility as well as maintenance.

Reviewed-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center
