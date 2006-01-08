From: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: 2.6.15-mm2
Date: Sun, 08 Jan 2006 09:23:45 -0500
Message-ID: <43C12071.5010208@ens-lyon.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A1348A@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752630AbWAHOZ4@vger.kernel.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A1348A@hdsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Brown, Len wrote:

> 
>  
>
>>2) acpi-cpufreq does not load either, returns ENODEV too. It's probably
>>git-acpi. I tried to revert it but there are lots of other patches
>>depending on it, so I finally gave up.
>>    
>>
>
>Brice,
>Can you try the converse?
>Apply the acpi patch (which is included in -mm)
>without the rest of the mm tree to see if that broke acpi-cpufreq?:
>
>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.15/acpi-test-20051216-2.6.15.diff.bz2
>
>thanks,
>-Len
>  
>

Len,

This patch applied on top of 2.6.15 breaks acpi-cpufreq in the same way.

Brice
