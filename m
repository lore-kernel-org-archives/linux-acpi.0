From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/3 rev 2] Centralized parsing of ACPI device resources
Date: Wed, 14 Nov 2012 11:52:32 +0200
Message-ID: <20121114095232.GN31759@intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <2429141.J1r7BIpiiT@vostro.rjw.lan>
 <5953163.ZajFIHZXph@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5953163.ZajFIHZXph@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, mathias.nyman@linux.intel.com, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, khali@linux-fr.org, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 13, 2012 at 09:51:39PM +0100, Rafael J. Wysocki wrote:
> Updated series, taking the Mika's feedback into account, follows.  There are
> bug fixes in [1/3], [2/3] is unchanged and the new [3/3] is a replacement, done
> in a different way because of some ACPICA limitations I didn't realize before.

I've now tested this series on my ACPI 5 enabled test machine and
everything works fine - I can see the platform devices and that they have
the ACPI handle attached.

For the whole series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

(testing has been limited on one ACPI 5 machine, though).

I guess I can start preparing the GPIO/SPI/I2C patches soon ;-)
