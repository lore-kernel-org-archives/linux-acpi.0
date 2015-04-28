From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Discussion around quirking the _REV behavior for the XPS 13 (2015)
 until 4.2
Date: Tue, 28 Apr 2015 18:21:38 -0500
Message-ID: <55401602.5050907@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223]:22245 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031051AbbD1XVj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2015 19:21:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

Due to b1ef2972586577e0ca9675254ee141f65a8824e5 landing recently as a result of some previous ACPI community discussion, the Dell XPS 13 (2015) no longer has fully functional audio.  In case you aren't aware, the XPS 13 (2015) switches audio modes based upon a combination of what's detected for the _OSI string and _REV values. When "Windows 2013" is found with _REV=2 the audio codec will be configured for I2S audio mode.  When "Windows 2013" with _REV=5 is found it will be configured for HDA audio mode.

I2S audio is improving, but not as mature as HDA audio mode is at this point.  Currently jack detection does not work properly in 4.1 with I2S audio codecs.  I've been notified that the support for jack detection will be landing in 4.2.  I'd like to discuss the possibility of including a quirk for the _REV behavior when the DMI information corresponding to the Dell XPS 13 (2015) is detected for 4.1.  This will let it continue to run in HDA mode until I2S mode is mature.

I'd also like to plan for the quirk to be dropped when jack detection has landed for 4.2 (or if it gets pushed out further when it lands for 4.3).

Would you guys be open to that?

Thanks,
