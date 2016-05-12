From: <Mario_Limonciello@Dell.com>
Subject: Proper kernel interface to fetch a buffer directly under system bus
Date: Thu, 12 May 2016 15:00:26 +0000
Message-ID: <e92efab79c4943aab206687cc8bd5af8@ausx13mpc124.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223]:14357 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcELPAd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 May 2016 11:00:33 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I wanted to be able to access and parse a buffer that is directly under _SB in the DSDT.  What is the proper kernel interface for doing this?

    Scope (_SB)
    {
        Name (AMAC, Buffer (0x17)
        {
            "_AUXMAC_#847BEB5992D2#"
        })
    }

Thanks,

