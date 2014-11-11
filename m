From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] dell-wireless: new driver for dell wireless button for
 Windows 8
Date: Tue, 11 Nov 2014 19:35:56 +0000
Message-ID: <20141111193556.GA18229@srcf.ucam.org>
References: <1415685685-16953-1-git-send-email-alex.hung@canonical.com>
 <20141111061242.GD56947@vmdeb7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141111061242.GD56947@vmdeb7>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Alex Hung <alex.hung@canonical.com>, Rafael Wysocki <rjw@rjwysocki.net>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 10, 2014 at 10:12:42PM -0800, Darren Hart wrote:

> As this is ACPI enumerated, does it belong in drivers/platform and not in
> drivers/acpi?

Yeah, it's still a platform driver rather than a core ACPI driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
