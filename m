From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/6] DMI: Introduce dmi_first_match to make the interface
 more flexible
Date: Wed, 01 Oct 2008 12:31:57 +0900
Message-ID: <48E2EF2D.4030006@gmail.com>
References: <200808290002.55026.rjw@sisk.pl> <48D17BBE.5020807@garzik.org> <200809300006.24919.rjw@sisk.pl> <200809300013.22924.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <200809300013.22924.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Garzik <jeff@garzik.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.de>, ralf@linux-mips.org
List-Id: linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> DMI: Introduce dmi_first_match to make the interface more flexible
> 
> Some notebooks from HP have the problem that their BIOSes attempt to
> spin down hard drives before entering ACPI system states S4 and S5.
> This leads to a yo-yo effect during system power-off shutdown and the
> last phase of hibernation when the disk is first spun down by the
> kernel and then almost immediately turned on and off by the BIOS.
> This, in turn, may result in shortening the disk's life times.
> 
> To prevent this from happening we can blacklist the affected systems
> using DMI information.  However, only the on-board controlles should
> be blacklisted and their PCI slot numbers can be used for this
> purpose.  Unfortunately the existing interface for checking DMI
> information of the system is not very convenient for this purpose,
> because to use it, we would have to define special callback functions
> or create a separate struct dmi_system_id table for each blacklisted
> system.
> 
> To overcome this difficulty introduce a new function
> dmi_first_match() returning a pointer to the first entry in an array
> of struct dmi_system_id elements that matches the system DMI
> information.  Then, we can use this pointer to access the entry's
> .driver_data field containing the additional information, such as
> the PCI slot number, allowing us to do the desired blacklisting.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Tejun Heo <tj@kernel.org>

(cc'ing recent committers to dmi)

If no one objects, I'd like to push this through libata-dev#upstream.
Any objections?

Thanks.

-- 
tejun
