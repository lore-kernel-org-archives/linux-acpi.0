From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Sat, 29 Jan 2011 19:49:13 +0200
Message-ID: <4D445319.5020803@pardus.org.tr>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101252038.25113.rjw@sisk.pl> <4D3F2869.3000406@pardus.org.tr> <201101252054.46647.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:46770 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab1A2RtK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Jan 2011 12:49:10 -0500
In-Reply-To: <201101252054.46647.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com

On 25.01.2011 21:54, Rafael J. Wysocki wrote:

>
> If intel_idle is not active, then the patch will not help.
>
> However, it would be good to check if the affected systems work with
> intel_idle + the above patch instead of acpi_idle.

intel_idle enabled and the patch above applied. Got 1 feedback for now 
which tells that 1 out of 2 shutdown attempts failed. This is on Asus 
N61JQ (https://bugzilla.kernel.org/show_bug.cgi?id=27412).


-- 
Pardus Linux
http://www.pardus.org.tr/eng
