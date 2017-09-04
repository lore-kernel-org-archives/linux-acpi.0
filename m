From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86: intel_cht_int33fe: Work around BIOS bug
 on some devices
Date: Mon, 4 Sep 2017 14:53:22 +0300
Message-ID: <20170904115322.GB2477@lahna.fi.intel.com>
References: <20170902162040.18565-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170902162040.18565-1-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Sep 02, 2017 at 06:20:40PM +0200, Hans de Goede wrote:
> At least one BIOS enumerates the max17047 both through the INT33FE ACPI
> device (it is right there in the resources table) as well as through a
> separate MAX17047 device.
> 
> This commit checks for the max17047 already being enumerated through
> a separate MAX17047 ACPI device and if so it uses the i2c-client
> instantiated for this and attaches the device-props for the max17047 to
> that i2c-client.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I won't say this looks good to me, but since this seems to be the only
sane way to deal with the crappy BIOS,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
