From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/5] gpiolib / ACPI: convert to gpiod interfaces
Date: Tue, 8 Oct 2013 13:36:25 +0300
Message-ID: <20131008103625.GK3521@intel.com>
References: <1380639537-23406-1-git-send-email-mika.westerberg@linux.intel.com>
 <1380639537-23406-3-git-send-email-mika.westerberg@linux.intel.com>
 <CAAVeFuJZ3TwozZzpuHcYPDLjEsb2D_qvQADf85s3-eywYYHs8A@mail.gmail.com>
 <20131008084508.GI3521@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131008084508.GI3521@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, rjw@rjwysocki.net, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 08, 2013 at 11:45:08AM +0300, Mika Westerberg wrote:
> > I also wonder whether you could also avoid exporting acpi_get_gpiod*
> > (which allow GPIO consumers to shortcut gpiolib) by implementing
> > acpi_get_gpio* into the C file (maybe even using gpiod_get()). I see a
> > "char *path" parameter though, so maybe that would not be possible at
> > the moment.
> 
> Good point, I'll check if we can do that.

Looks like we can get rid of acpi_get_gpio() and acpi_get_gpiod() as there
are no users for those outside gpiolib-acpi. I'm going to do that in the
next revision.
