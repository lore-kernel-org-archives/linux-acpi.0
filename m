From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 4/4] i2c: allow specify device properties in
 i2c_board_info
Date: Thu, 2 Feb 2017 12:08:45 +0200
Message-ID: <20170202100845.GG2053@lahna.fi.intel.com>
References: <20170201173125.40354-1-dmitry.torokhov@gmail.com>
 <20170201173125.40354-5-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170201173125.40354-5-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 01, 2017 at 09:31:25AM -0800, Dmitry Torokhov wrote:
> With many drivers converting to using generic device properties, it is
> useful to provide array of device properties when instantiating new i2c
> client via i2c_board_info and have them automatically added to the device
> in question.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
