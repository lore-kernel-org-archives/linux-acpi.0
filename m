From: Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH 0/6] ACPI: Simplify namespace scanning for devices
Date: Sun, 16 Dec 2012 23:59:58 +0800
Message-ID: <50CDEFFE.7030509@gmail.com>
References: <4532917.9APhB4xTvi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:44790 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab2LPQAK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Dec 2012 11:00:10 -0500
In-Reply-To: <4532917.9APhB4xTvi@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Yijing Wang <wangyijing0307@gmail.com>, Wen Congyang <wency@cn.fujitsu.com>

Hi Rafael,
	Great idea to get rid of the .start() staff, it could also
simplify our hotplug framework too.
	Thanks!
	Gerry

On 12/16/2012 09:47 PM, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series is on top of the one I sent on Thursday:
> 
> https://lkml.org/lkml/2012/12/13/632
> 
> It goes one step farther and makes some simplifications that become possible
> after applying that patchset.
> 
> [1/6] Fold acpi_pci_root_start() into acpi_pci_root_add()
> [2/6] Remove acpi_start_single_object() and acpi_bus_start()
> [3/6] Remove the arguments of acpi_bus_add() that are not used
> [4/6] Drop the second argument of acpi_bus_scan()
> [5/6] Replace ACPI device add_type field with a match_driver flag
> [6/6] Make acpi_bus_scan() and acpi_bus_add() take only one argument
> 
> It survives booting on Toshiba Portege R500 without any visible issues.
> 
> Thanks,
> Rafael
> 
> 

