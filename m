From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] Documentation / ACPI: Fix location of GPIO documentation
Date: Wed, 21 May 2014 17:15:23 +0300
Message-ID: <20140521141523.GY1651@lahna.fi.intel.com>
References: <1400680705-11078-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400680705-11078-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, May 21, 2014 at 04:58:25PM +0300, Jarkko Nikula wrote:
> Commit fd8e198cfcaa ("Documentation: gpiolib: document new interface")
> moved Documentation/gpio.txt to Documentation/gpio/gpio-legacy.txt and added
> new documents for descriptor-based interface so fix the the location here to
> point Documentation/gpio/ since that what commit ccb6fbb99020
> ("Documentation / ACPI: update to GPIO descriptor API") was looking for.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
