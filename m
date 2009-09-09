From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [PATCH 1/5] PCI PM: Simplify PCI wake-up code
Date: Wed, 9 Sep 2009 14:20:20 -0700
Message-ID: <20090909142020.334a9e84@jbarnes-g45>
References: <200908300041.14541.rjw@sisk.pl>
	<200909040002.02562.rjw@sisk.pl>
	<200909082311.48366.rjw@sisk.pl>
	<200909082312.59769.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200909082312.59769.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Linux PCI <linux-pci@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ykzhao <yakui.zhao@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, 8 Sep 2009 23:12:59 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Rework the PCI wake-up code so that it's easier to read without
> changing the functionality.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Applied this series to my linux-next branch, thanks.  Len, that include
the ACPI portion; hope that's ok.

-- 
Jesse Barnes, Intel Open Source Technology Center
