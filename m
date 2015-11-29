From: Krzysztof Kolasa <kkolasa@winsoft.pl>
Subject: System crash on boot, system x86 32bit, kernel-next
Date: Sun, 29 Nov 2015 11:55:36 +0100
Message-ID: <565AD9A8.7060702@winsoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vps01.winsoft.pl ([5.133.9.51]:55085 "EHLO vps01.winsoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbbK2LCN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Nov 2015 06:02:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, jiang.liu@linux.intel.com, hanjun.guo@linaro.org, bhelgaas@google.com, rafael.j.wysocki@intel.com

My old laptop, Fujitsu Siemens Amilo Pro v3405 hard oops on boot, bisected first bad commit:

4d6b4e69a245 x86/PCI/ACPI: Use common interface to support PCI host bridge

after revert, system starting OK

screen images, which captured my camera:

start system stopped:

https://drive.google.com/file/d/0B1LAMAFWTdewT1MxbHBuYnZ0enM/view?usp=sharing

and oops:

https://drive.google.com/file/d/0B1LAMAFWTdewSVl3Q1RuSktITDQ/view?usp=sharing

Krzysztof Kolasa
