From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 5/5] gpiolib / ACPI: document the GPIO descriptor
 based interface
Date: Mon, 21 Oct 2013 10:06:32 +0300
Message-ID: <20131021070632.GY3521@intel.com>
References: <1381392071-21407-1-git-send-email-mika.westerberg@linux.intel.com>
 <1381392071-21407-6-git-send-email-mika.westerberg@linux.intel.com>
 <CACRpkdaAgsoO=w6=LDqE4-JZaOY7Ooofa_L2tRL2Hnt6SNh70g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaAgsoO=w6=LDqE4-JZaOY7Ooofa_L2tRL2Hnt6SNh70g@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grant Likely <grant.likely@secretlab.ca>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Oct 19, 2013 at 11:35:39PM +0200, Linus Walleij wrote:
> On Thu, Oct 10, 2013 at 10:01 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> 
> > In addition to the existing ACPI specific GPIO interface, document the new
> > descriptor based GPIO interface in Documentation/acpi/enumeration.txt, so
> > it is clear that this new interface is preferred over the ACPI specific
> > version.
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> I've applied the last 4 of these patches now as well, on top of
> Alexandre's gpiod interface. If you can, please test the result
> on my "devel" branch and let's see if the autobuilder likes it too...

Just tested using your devel branch and works fine with GPIOs from ACPI
namespace.

Thanks!
