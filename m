From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] ACPI / hotplug / driver core: Handle containers in a
 special way
Date: Sat, 28 Dec 2013 19:58:41 -0800
Message-ID: <20131229035841.GA26111@kroah.com>
References: <1421028.Rsfpmhnym3@vostro.rjw.lan>
 <2686210.6vSP0yehxh@vostro.rjw.lan>
 <63118574.0bgUpLnDbK@vostro.rjw.lan>
 <1991202.gilW172FBV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1991202.gilW172FBV@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Yinghai Lu <yinghai@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 27, 2013 at 11:28:34PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ACPI container devices require special hotplug handling, at least
> on some systems, since generally user space needs to carry out
> system-specific cleanup before it makes sense to offline devices in
> the container.  However, the current ACPI hotplug code for containers
> first attempts to offline devices in the container and only then it
> notifies user space of the container offline.
> 
> Moreover, after commit 202317a573b2 (ACPI / scan: Add acpi_device
> objects for all device nodes in the namespace), ACPI device objects
> representing containers are present as long as the ACPI namespace
> nodes corresponding to them are present, which may be forever, even
> if the container devices are physically detached from the system (the
> return values of the corresponding _STA methods change in those
> cases, but generally the namespace nodes themselves are still there).
> Thus it is useful to introduce entities representing containers that
> will go away during container hot-unplug.
> 
> The goal of this change is to address both the above issues.
> 
> The idea is to create a "companion" container system device for each
> of the ACPI container device objects during the initial namespace
> scan or on a hotplug event making the container present.  That system
> device will be unregistered on container removal.  A new bus type
> for container devices is added for this purpose, because device
> offline and online operations need to be defined for them.  The
> online operation is a trivial function that is always successful
> and the offline uses a callback pointed to by the container device's
> offline member.
> 
> For ACPI containers that callback simply walks the list of ACPI
> device objects right below the container object (its children) and
> checks if all of their physical companion devices are offline.  If
> that's not the case, it returns -EBUSY and the container system
> device cannot be put offline.  Consequently, to put the container
> system device offline, it is necessary to put all of the physical
> devices depending on its ACPI companion object offline beforehand.
> 
> Container system devices created for ACPI container objects are
> initially online.  They are created by the container ACPI scan
> handler whose hotplug.demand_offline flag is set.  That causes
> acpi_scan_hot_remove() to check if the companion container system
> device is offline before attempting to remove an ACPI container or
> any devices below it.  If the check fails, a KOBJ_CHANGE uevent is
> emitted for the container system device in question and user space
> is expected to offline all devices below the container and the
> container itself in response to it.  Then, user space can finalize
> the removal of the container with the help of its ACPI device
> object's eject attribute in sysfs.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
