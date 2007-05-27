From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: allow hotkey to input event map to be modified
Date: Sat, 26 May 2007 23:38:18 -0400
Message-ID: <200705262338.19137.dtor@insightbb.com>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <11802006652128-git-send-email-hmh@hmh.eng.br> <11802006652058-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:19445 "EHLO
	asav06.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbXE0DiL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 May 2007 23:38:11 -0400
In-Reply-To: <11802006652058-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org

On Saturday 26 May 2007 13:31, Henrique de Moraes Holschuh wrote:
> Add a sysfs interface to allow userspace to modify the mapping between
> ThinkPad hotkeys and the keycode input events they generate.
> 

No, please do not do that. We have a standard way to adjust keymap for
an input device via EVIOCGKEYCODE/EVIOCSKEYCODE ioctls on corresponding
event device; there is no need to invent another interface. Just define
getkeycodes() and setkeycode() methods for your input device and be done
with it.

-- 
Dmitry
