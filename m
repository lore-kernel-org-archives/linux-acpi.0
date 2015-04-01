From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] mailbox: add ACPI support for mailbox framework
Date: Wed, 1 Apr 2015 10:45:53 +0300
Message-ID: <20150401074553.GV1524@lahna.fi.intel.com>
References: <1427836680-13008-1-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427836680-13008-1-git-send-email-fkan@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Kan <fkan@apm.com>
Cc: patches@apm.com, jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 31, 2015 at 02:18:00PM -0700, Feng Kan wrote:
> This will add support for ACPI parsing of the mboxes attribute
> when booting with ACPI table. The client will have a attribute
> mimic the dts call "mboxes". In the ACPI case, the client will
> mark "mboxes" with the ACPI HID of the mbox it wishes to use.
> 
> 	Name (_DSD, Package () {
> 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> 		Package () {
> 			Package (2) {"mboxes", "ACPIHID"},
> 		}
> 	})

Instead of this, why not match against the DT compatible property?

	Name (_HID, "PRP0001")

 	Name (_DSD, Package () {
 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 		Package () {
 			Package (2) {"compatible", "your-dt-compatible-string"},
 		}
 	})

This all will be done for you automatically with zero changes in the
code.
