From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: Error calling BSTS
Date: Tue, 5 Dec 2006 08:04:43 +0100
Message-ID: <200612050804.44486.corentincj@iksaif.net>
References: <4570BECB.5050502@seclark.us> <200612041856.48871.corentincj@iksaif.net> <4574CE67.2000302@seclark.us>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:39587 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967460AbWLEHEr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Dec 2006 02:04:47 -0500
In-Reply-To: <4574CE67.2000302@seclark.us>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen.Clark@seclark.us
Cc: linux-acpi@vger.kernel.org


> ACPI: AC Adapter [AC0] (on-line)
> Asus Laptop ACPI Extras version 0.31b2
>   Error calling BSTS
>   Z96F model detected, supported

The Error is "normal" .. It will be fixed ...
Now files is /proc/acpi/asus/ should work (and maybe /sys/class/backlight/ if 
you kernel support it).
-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
