From: Shan Wei <shanwei@cn.fujitsu.com>
Subject: ACPI: question about functional but not present PnP serial device
Date: Thu, 06 Nov 2008 20:39:38 +0800
Message-ID: <4912E58A.8040305@cn.fujitsu.com>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:55986 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753559AbYKFMpu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Nov 2008 07:45:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: shaohua.li@intel.com, yakui.zhao@intel.com
Cc: linux-acpi@vger.kernel.org

Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hi
 
  if the status of one serial device is not present
but functional, it's driver is not be loaded on boot,
and the device are not be startup , yes or no？

   and my question is when is the status of device 
not present but functional.

   After adding a serial device(e.g. ttyS0) on the 
/etc/inittab, when booting the kernel, is the status 
of the device not present but functional?

