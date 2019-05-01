From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / property: fix handling of data_nodes in acpi_get_next_subnode()
Date: Wed, 1 May 2019 10:11:31 +0200
Message-ID: <CAJZ5v0hm5RLDRd-T+fwn_JGCZH-++ZhCZjKf7ww1wbj7ax_KLA@mail.gmail.com>
References: <20190430155229.14213-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430155229.14213-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 30, 2019 at 5:52 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> When the DSDT tables expose devices with subdevices and a set of
> hierarchical _DSD properties, the data returned by
> acpi_get_next_subnode() is incorrect, with the results suggesting a bad
> pointer assignment. The parser works fine with device_nodes or
> data_nodes, but not with a combination of the two.
>
> The problem is traced to an invalid pointer used when jumping from
> handling device_nodes to data nodes. The existing code looks for data
> nodes below the last subdevice found instead of the common root. Fix
> by forcing the acpi_device pointer to be derived from the same fwnode
> for the two types of subnodes.
>
> This same problem of handling device and data nodes was already fixed
> in a similar way by 'commit bf4703fdd166 ("ACPI / property: fix data
> node parsing in acpi_get_next_subnode()")' but broken later by 'commit
> 34055190b19 ("ACPI / property: Add fwnode_get_next_child_node()")', so
> this should probably go to linux-stable all the way to 4.12
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Applied with the Andy's R-by, but I reformatted the comment to take
fewer lines of code.

Thanks!
