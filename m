From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Tue, 25 Jan 2011 21:45:45 +0200
Message-ID: <4D3F2869.3000406@pardus.org.tr>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <4D3DDDA4.2080202@yahoo.fr> <201101250822.48287.ozan@pardus.org.tr> <201101252038.25113.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201101252038.25113.rjw@sisk.pl>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com
List-Id: linux-acpi@vger.kernel.org

On 25.01.2011 21:38, Rafael J. Wysocki wrote:

> Does
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ec30f343d61391ab23705e50a525da1d55395780
> generally help?

Well I can let them try a patched kernel but will a kernel showing 
acpi_idle as the cpuidle driver in dmesg will be affected by this patch?
I can't see any sign on reporters' dmesg that intel_idle is active.



-- 
Pardus Linux
http://www.pardus.org.tr/eng
