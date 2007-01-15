From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: i810, mergedfb and lid switch and acpi video
Date: Mon, 15 Jan 2007 14:01:39 +0800
Message-ID: <1C601A6A3344064EB423D0C1E83B717BDACA94@pdsmsx411.ccr.corp.intel.com>
References: <200701120312.53809.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47244 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbXAOGBu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jan 2007 01:01:50 -0500
Content-class: urn:content-classes:message
In-Reply-To: <200701120312.53809.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: emisca <emisca.ml@gmail.com>
Cc: xorg@lists.freedesktop.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>


>
>I have an hp nx7400 notebook with intel 945gma. The lid switch
>normally toggles (using acpi video module) internal display and
>external display.
>It works like a charm, unless using mergedfb. I have not tried with
>dual screen or dual screen + xinerama because I was affected by the
>bug fixed (probably, I've not tested it) by 1.7.4 version of the
>driver.
>Using mergedfb, if I press the lid switch or close the screen, the
>display gets corrupted and I have to reinit the card switching to a
>virtual console and returning back to X.
>
>Is there a way to disable the switching behaviour of the acpi code? I
>was able to disable completely the switch unloading the acpi video
>module, but it's not the right way....
>

Please send me acpidump output , let me check how does acpi video
extension get
supported on hp nx7400. 

If it support _DOS, please just try  " echo 0 > /proc/acpi/video/*/DOS "

Thanks,
Luming
