From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 00/13] Software fwnode references
Date: Wed, 17 Apr 2019 09:54:19 +0200
Message-ID: <CAJZ5v0gg9cwbNXS=88CdC6dioYaxPCVKx-PSU86PFjvU77MdRg@mail.gmail.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 12, 2019 at 3:42 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> This is the third version of my proposal to add reference handling to
> the software node code. In this version I renamed ACPI_NAME_SIZE to
> ACPI_NAMESEG_SIZE in 6/13, and slit patch 9/13 in two separate patches
> (9/13 and 10/13) as suggested by Andy. Patch 9/13 will now only move
> the registration of max17047 out of probe, and 10/13 will introduce
> the software nodes.
>
> v2 commit message:
>
> This is the second version of this series. In this version I'm
> introducing a new helper device_find_child_by_name() as proposed
> by Andy. Andy requested also another helper that could be used for
> chaining the fwnodes, but I decided not to add that now. I would like
> to still think about how we should handle exceptions like if there
> already is a secondary node assigned for a node.
>
> v1 commit message:
>
> This series adds support for software fwnode reference handling. In
> practice it means making fwnode_property_get_reference_args() function
> usable in the drivers also with software nodes. I send the series
> originally as RFC [1].
>
> As the first user for the software node references, I'm converting
> intel_cht_int33fe.c to use them as part of the series.
>
> [1] https://lkml.org/lkml/2019/3/15/457

I added this series to the bleeding-edge branch last night and it
triggered some warnings from various checkers and there was a breakage
report from Hans.  All of that needs to be fixed IMO, so I'm expecting
an update.

Thanks!
