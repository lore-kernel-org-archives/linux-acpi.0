From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Add sysfs interface for acpi device wakeup
Date: Thu, 10 Jan 2008 10:30:20 +0000
Message-ID: <20080110103019.GA9403@srcf.ucam.org>
References: <1198738022.8950.3.camel@yangyi-dev.bj.intel.com> <1199688961.3551.19.camel@yangyi-dev.bj.intel.com> <1199917306.9596.3.camel@yangyi-dev.bj.intel.com> <200801100943.08780.maximlevitsky@gmail.com> <1199923176.3827.13.camel@yangyi-dev.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754902AbYAJKao@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1199923176.3827.13.camel@yangyi-dev.bj.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yi Yang <yi.y.yang@intel.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, acpi-bugzilla@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 10, 2008 at 07:59:36AM +0800, Yi Yang wrote:

> Maybe this is a good idea, but i don't know the relationships between
> acpi devices, devices, pci devices and pnp devices. If we can merge all
> these things together, that will be a great job.

Let's not merge this yet, then, otherwise we'll be forced to carry 
around a sysfs API that's of no real use.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
