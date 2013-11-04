From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update][PATCH 0/6] ACPI scan and hotplug fixes
Date: Mon, 04 Nov 2013 14:29:56 +0100
Message-ID: <2970389.SeMGM45Qln@vostro.rjw.lan>
References: <5839747.7HXXGHmMBd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5839747.7HXXGHmMBd@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Toshi Kani <toshi.kani@hp.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday, November 04, 2013 01:17:12 AM Rafael J. Wysocki wrote:
> Hi,
> 
> The following three patches fix some issues that we have in the common ACPI
> hotplug infrastructure.
> 
> If anyone sees any problems with them, please let me know.

Well, the last patch from the last version didn't really do the right thing in
my opinion, so new series follows.

I actually would like to squeeze it into 3.13 if there are no objections, since
at least patch [3/6] is kind of urgent.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
