From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 6/6] device property: Remove struct property_set
Date: Wed, 7 Nov 2018 14:34:28 +0200
Message-ID: <20181107123428.GG13048@kuha.fi.intel.com>
References: <20181105145928.46819-1-heikki.krogerus@linux.intel.com>
 <20181105145928.46819-7-heikki.krogerus@linux.intel.com>
 <20181106144641.GA10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181106144641.GA10650@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 06, 2018 at 04:46:41PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 05, 2018 at 05:59:28PM +0300, Heikki Krogerus wrote:
> > Replacing struct property_set with the software nodes that
> > were just introduced.
> > 
> > The API and functionality for adding properties to devices
> > remains the same, however, the goal is to convert the
> > drivers to use the API for software nodes when the device
> > has no real firmware node, and use the old API only when
> > "extra" build-in properties are needed.
> 
> It might be slightly easier to review if you preserve the ordering of
> functions, i.e. device_add_properties() and device_remove_properties().

True, that change does not belong to this series.

thanks,

-- 
heikki
