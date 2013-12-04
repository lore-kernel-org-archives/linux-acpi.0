From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCHv2 2/2] ACPI/platform: Add ACPI ID for Intel MBI device
Date: Wed, 4 Dec 2013 02:21:30 +0000
Message-ID: <20131204022130.GA26084@srcf.ucam.org>
References: <1385100357-5459-1-git-send-email-david.e.box@linux.intel.com>
 <1386115178-7559-1-git-send-email-david.e.box@linux.intel.com>
 <1386115178-7559-3-git-send-email-david.e.box@linux.intel.com>
 <20131204013001.GA25037@srcf.ucam.org>
 <20131204021703.GA8282@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131204021703.GA8282@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 03, 2013 at 06:17:03PM -0800, David E. Box wrote:
> This is per the requirement in Documentation/acpi/enumeration.txt:
> 
> "Currently the kernel is not able to automatically determine from which ACPI
> device it should make the corresponding platform device so we need to add
> the ACPI device explicitly to acpi_platform_device_ids list defined in
> drivers/acpi/acpi_platform.c"

Well sure, but why do you need to be a platform device at all? This 
functionality was intended for cases where we already have a driver for 
the part that enumerated it via some other mechanism. If the driver's 
only intended for ACPI systems then why not just be an ACPI device?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
