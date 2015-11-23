From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 3/5] acer-wmi: Use acpi_dev_present
Date: Mon, 23 Nov 2015 11:06:09 -0800
Message-ID: <20151123190609.GV7413@malice.jf.intel.com>
References: <cover.1448282995.git.lukas@wunner.de>
 <16567313cc5fe318e4738ecd9442c04432f7e8cb.1448282995.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <16567313cc5fe318e4738ecd9442c04432f7e8cb.1448282995.git.lukas@wunner.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, platform-driver-x86@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 23, 2015 at 03:34:55PM +0100, Lukas Wunner wrote:
> Use shiny new acpi_dev_present and remove all the boilerplate to search
> for a particular ACPI device. No functional change.
> 
> Cc: Lee, Chun-Yi <jlee@suse.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Rafael, I presume you'll pick this one up as well?

For platform-drivers-x86:

Acked-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center
