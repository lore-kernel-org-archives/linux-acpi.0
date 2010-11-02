From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: Linux 2.6.37-rc1 (acpi_video)
Date: Tue, 2 Nov 2010 11:51:06 -0700
Message-ID: <20101102115106.bac57d21.randy.dunlap@oracle.com>
References: <AANLkTimr3rW67HxgOUyReEW8dmmSsd4b7-Ns57mXzS1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:56636 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0KBSxg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2010 14:53:36 -0400
In-Reply-To: <AANLkTimr3rW67HxgOUyReEW8dmmSsd4b7-Ns57mXzS1w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>


When I disable CONFIG_INPUT (on purpose):

ERROR: "input_event" [drivers/acpi/video.ko] undefined!
ERROR: "input_register_device" [drivers/acpi/video.ko] undefined!
ERROR: "input_free_device" [drivers/acpi/video.ko] undefined!
ERROR: "input_unregister_device" [drivers/acpi/video.ko] undefined!
ERROR: "input_allocate_device" [drivers/acpi/video.ko] undefined!


due to the gpu/stub (poulsbo) driver:

config STUB_POULSBO
	tristate "Intel GMA500 Stub Driver"
	depends on PCI
	# Poulsbo stub depends on ACPI_VIDEO when ACPI is enabled
	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
	select ACPI_VIDEO if ACPI

The config does not select INPUT, even though the comment says that
ACPI_VIDEO's dependencies need to be selected, and ACPI_VIDEO does
depend on INPUT.  But then, I'm trying to build a kernel with
CONFIG_INPUT disabled....


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
