From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Tue, 25 Jan 2011 22:00:27 +0200
Message-ID: <4D3F2BDB.7050508@pardus.org.tr>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101252038.25113.rjw@sisk.pl> <4D3F2869.3000406@pardus.org.tr> <201101252054.46647.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201101252054.46647.rjw@sisk.pl>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com
List-Id: linux-acpi@vger.kernel.org


> However, it would be good to check if the affected systems work with
> intel_idle + the above patch instead of acpi_idle.

My bad. I thought that I enabled intel_idle but it was not
driving those processors but it seems that I've not enabled it on those 
kernels.

Okay, ASAP I'll report back what's going on with intel_idle + the
patch that you gave.


-- 
Pardus Linux
http://www.pardus.org.tr/eng
