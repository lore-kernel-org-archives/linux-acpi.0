From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/3] drivers:pnp Add support for descendants claiming
 memory address space
Date: Fri, 06 Mar 2015 00:03:31 +0100
Message-ID: <54F8E0C3.6080103@intel.com>
References: <1424202111-14461-1-git-send-email-jakeo@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1424202111-14461-1-git-send-email-jakeo@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Jake Oshins <jakeo@microsoft.com>
Cc: olaf@aepfle.de, gregkh@linuxfoundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, apw@canonical.com, devel@linuxdriverproject.org
List-Id: linux-acpi@vger.kernel.org

On 2/17/2015 8:41 PM, Jake Oshins wrote:
> This patch adds some wrapper functions in the pnp layer.  The intent is
> to allow memory address space claims by devices which are descendants
> (a child or grandchild of) a device which is already part of the pnp
> layer.  This allows a device to make a resource claim that doesn't
> conflict with its "aunts" and "uncles."

How is this going to happen?

> This is useful in a Hyper-V VM because some paravirtual "devices" need
> memory-mapped I/O space, and their aunts and uncles can be PCI devices.
> Furthermore, the hypervisor expresses the possible memory address
> combinations for the devices in the VM through the ACPI namespace.
> The paravirtual devices need to suballocate from the ACPI nodes, and
> they need to avoid conflicting with choices that the Linux PCI code
> makes about the PCI devices in the VM.
>
> It might seem like this should be done in the platform layer rather
> than the pnp layer, but the platform layer assumes that the
> configuration of the devices in the machine are static, or at least
> expressed by firmware in a static fashion.

I'm not sure if I'm following you here.

Where exactly do we make that assumption?

Yes, some code to support platform device hotplug may be missing, but I'd
very much prefer to add it instead of reviving the dead man walking which is
the PNP subsystem today.

> The nature of a Hyper-V
> VM is that new devices can be added while the machine is running,
> and the potential configurations for them are expressed as part of
> the paravirtual communications channel.  This much more naturally
> aligns with the pnp layer.

That's debatable.

That aside, it would help a lot if you described your design in plain 
English
and added some useful kerneldoc comments to the new functions.

Kind regards,
Rafael
