From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [UPDATE] [PATCH v3 1/5] ACPI / processor : add support for ACPI0010 processor container
Date: Wed, 24 Feb 2016 00:41:50 +0100
Message-ID: <2770602.Nt428br2IX@vostro.rjw.lan>
References: <1449065446-26115-2-git-send-email-sudeep.holla@arm.com> <1455710059-14380-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455710059-14380-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, x86@kernel.org, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mahesh Sivasubramanian <msivasub@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Prashanth Prakash <pprakash@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, February 17, 2016 11:54:19 AM Sudeep Holla wrote:
> ACPI 6.0 adds support for optional processor container device which may
> contain child objects that are either processor devices or other processor
> containers. This allows representing hierarchical processor topologies.
> 
> It is declared using the _HID of ACPI0010. It is an abstract container
> used to represent CPU topology and should not be used to hotplug
> purposes.
> 
> If no matching handler is found for a device in acpi_scan_attach_handler,
> acpi_bus_attach does a default enumeration for those devices with valid
> HID in the acpi namespace. This patch adds a scan handler for these ACPI
> processor containers to avoid default that enumeration and ensures the
> platform devices are not created for them.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Queued up for 4.6, thanks!

Rafael
