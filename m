From: Corentin CHARY <corentincj@iksaif.net>
Subject: acpi4asus-0.31 release
Date: Tue, 12 Dec 2006 10:08:04 +0100
Message-ID: <200612121008.04894.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:34353 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932153AbWLLJIH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Dec 2006 04:08:07 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

Hi,
There is a new acpi4asus release, the first since january ...
Changelog :
New default values to avoid errors
Added support for A6J
Added support for A6R
Added support for A6B, A6K
Added support for A6V
Added support for F3J
Added support for A3N, A3L
Added support for A3E
Added support for A3F
Added support for Z71V
Added support for Z71A
Added support for V6V
Added support for V6J
Added support for A8J
Added support for A6F
Added support for Z96F
Added support for W5F
Added support for light_sens (thx zorxd)
New methods name (mt_led -> set_led, etc ...)
Support for backlight class /sys/class/backlight/asus/
Constants params can be specified for lcd_switch and lcd_status (used for A6x, 
F3J, L3H, ..)
Remove asus_uid and asus_gid parameters
Added "unsupported" parameter
Added support for 2.6.19

Files can be found at http://acpi4asus.sourceforge.net/ .

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
