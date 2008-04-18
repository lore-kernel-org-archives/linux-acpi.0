From: Sergey Yanovich <ynvich@gmail.com>
Subject: Re: [PATCH 3/3] Synchronize wireless power state with hardware for
 Sony laptops
Date: Sat, 19 Apr 2008 02:59:10 +0300
Message-ID: <480935CE.5040104@gmail.com>
References: <1208558495-22792-1-git-send-email-ynvich@gmail.com> <1208558495-22792-2-git-send-email-ynvich@gmail.com> <1208558495-22792-3-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000001070002070601060105"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:62901 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbYDRX71 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Apr 2008 19:59:27 -0400
Received: by ug-out-1314.google.com with SMTP id z38so184579ugc.16
        for <linux-acpi@vger.kernel.org>; Fri, 18 Apr 2008 16:59:26 -0700 (PDT)
In-Reply-To: <1208558495-22792-3-git-send-email-ynvich@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000001070002070601060105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sergey Yanovich wrote:
> The drivers stores own representation of wireless power states. Since
> hardware switch takes presedence over software controls, internal
> data goes out of sync with device state, after the hardware switch
> is toggled.
> 
> This patch safeguards itself against possible conflicts with earlier
> models, and will only have any effect on the latest Type 4 devices.
> ---

I am enclosing a script, which I use with acpid and invoke by Fn-F1. It 
makes the wireless leds blink like a Christmas tree.

-- 
Sergey Yanovich

--------------000001070002070601060105
Content-Type: application/x-sh;
 name="sonywifi.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sonywifi.sh"

#!/bin/sh
set -x

wifi=`cat /sys/devices/platform/sony-laptop/wifipower`
wwan=`cat /sys/devices/platform/sony-laptop/wwanpower`
bluetooth=`cat /sys/devices/platform/sony-laptop/bluetoothpower`

if test $wifi -eq 1; then
	if test $bluetooth -eq 1; then
		if test $wwan -eq 1; then
			echo 0 > /sys/devices/platform/sony-laptop/wwanpower
			echo 0 > /sys/devices/platform/sony-laptop/bluetoothpower
		else
			echo 0 > /sys/devices/platform/sony-laptop/bluetoothpower
		fi
	else
		if test $wwan -eq 1; then
			echo 0 > /sys/devices/platform/sony-laptop/wwanpower
		else
			echo 0 > /sys/devices/platform/sony-laptop/wifipower
			echo 1 > /sys/devices/platform/sony-laptop/bluetoothpower
		fi
	fi
else
	if test $bluetooth -eq 1; then
		if test $wwan -eq 1; then
			echo 0 > /sys/devices/platform/sony-laptop/wwanpower
		else
			echo 0 > /sys/devices/platform/sony-laptop/bluetoothpower
			echo 1 > /sys/devices/platform/sony-laptop/wwanpower
		fi
	else
		if test $wwan -eq 1; then
			echo 0 > /sys/devices/platform/sony-laptop/wwanpower
			echo 1 > /sys/devices/platform/sony-laptop/wifipower
			echo 1 > /sys/devices/platform/sony-laptop/bluetoothpower
		else
			echo 1 > /sys/devices/platform/sony-laptop/wifipower
		fi
	fi
fi

--------------000001070002070601060105--
