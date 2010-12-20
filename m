From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [Resend][PATCH] PCI / Hotplug: Fix unexpected driver unregister
 in pciehp_acpi.c
Date: Mon, 20 Dec 2010 09:30:04 +0900
Message-ID: <4D0EA38C.2090003@jp.fujitsu.com>
References: <201012181329.46071.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201012181329.46071.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

(2010/12/18 21:29), Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki<rjw@sisk.pl>
> 
> If pcie_ports_disabled is set, pcie_port_service_register() returns
> error code and select_detection_mode() should not attempt to
> unregister dummy_driver and use dummy_slots.  It should return
> PCIEHP_DETECT_ACPI immediately instead.
> 
> Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>

Reviewed-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Acked-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
