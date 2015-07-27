From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 0/8] mfd: introduce a driver for LPSS devices on SPT
Date: Mon, 27 Jul 2015 16:27:33 +0100
Message-ID: <20150727152733.GB21114@x1>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-acpi@vger.kernel.org

=46AO Stephen Boyd,

> Stephen, can you, please, have a look into patch 8 regarding to clock=
 name
> matching and other stuff Lee asked?

Patch 8:

      "Can you review the clock implementation please?  It looks
      fragile to me as it relies heavily on device names constructed
      of MFD cell names and IDA numbers cat'ed together!"

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
