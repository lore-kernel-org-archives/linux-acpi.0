From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: suspend to RAM failure on t61p
Date: Sun, 09 Dec 2007 13:40:07 +0100
Message-ID: <475BE227.2040003@dbservice.com>
References: <20071209011928.c9873c66.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from neopsis.com ([213.239.204.14]:36979 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750879AbXLIMkU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Dec 2007 07:40:20 -0500
In-Reply-To: <20071209011928.c9873c66.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

Andrew Morton wrote:
> 2.6.24-rc4 on a Lenovo t61p, using FC8 config.
> 
> echo mem > /sys/power/state while running X.
> 
> It appears to suspend OK but then it instantly resumes and runs
> OK except the display is blank.

http://bugzilla.kernel.org/show_bug.cgi?id=9258

I have a X61 tablet, and the screen is blank after resume, too, but
pressing ctrl+alt+F1/F7 usually fixes it. It seems a problem with the X
video driver. I'm not sure though.

tom
